<?php
/*
UserSpice 5
An Open Source PHP User Management System
by the UserSpice Team at http://UserSpice.com

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
class DB {
	private static $_instance = null;
	private $_pdo, $_query, $_error = false, $_errorInfo, $_results=[], $_resultsArray=[], $_count = 0, $_lastId, $_queryCount=0;

	private function __construct($config = []){

        if (!$opts = Config::get('pgsql/options'))
        $opts = array(PDO::ATTR_EMULATE_PREPARES => false);
        try{
            // $dbCharset = Config::get('pgsql/charset')? Config::get('pgsql/charset') : 'utf8';
            if($config == []){
                //grab the default db from the init.php file
                $this->_pdo = new PDO('pgsql:host=' .
                Config::get('pgsql/host') .';dbname='.
                Config::get('pgsql/db'),
                Config::get('pgsql/username'),
                Config::get('pgsql/password'),
                $opts);

            }elseif(!is_array($config) || count($config) == 1){
                //this allows you to pass DB::getDB('dbname') OR DB::getDB(['dbname']) to get
                //a second db on the same server with the same username and password
                if(is_array($config)){$config = $config[0];}
                $this->_pdo = new PDO('pgsql:host=' .
                Config::get('pgsql/host') .';dbname='.
                Config::get('pgsql/db'),
                Config::get('pgsql/username'),
                Config::get('pgsql/password'),
                $opts);

            }elseif(in_array('init',$config)){
                //this allows you to get another db from your init file that is added to your init.php config
                //array and call it like this DB::getDB(['pgsql2','init']);
                //your init file can have as many of these sets of db creds as you would like added like this
                // 'pgsql'      => array(
                // 'host'         => '127.0.0.1',
                // 'username'     => 'root',
                // 'password'     => '',
                // 'db'           => '513',
                // ),
                // 'pgsql2'      => array(
                // 'host'         => 'localhost',
                // 'username'     => 'root',
                // 'password'     => '',
                // 'db'           => 'dbname',
                // ),
                //be sure to give each one a unique name like pgsql2, pgsql3

                $this->_pdo = new PDO('pgsql:host=' .
                Config::get('pgsql/host') .';dbname='.
                Config::get('pgsql/db'),
                Config::get('pgsql/username'),
                Config::get('pgsql/password'),
                $opts);

            }else{
                $this->_pdo = new PDO('pgsql:host=' .
                $config[0].';dbname='.
                $config[1],
                $config[2],
                $config[3],
                $opts);
            }
        }catch(PDOException $e){
            die($e->getMessage());
        }
    }


	public static function getInstance(){
		if (!isset(self::$_instance)) {
			self::$_instance = new DB();
		}
		return self::$_instance;
	}

	public static function getDB($config){
		self::$_instance = new DB($config);
		return self::$_instance;
	}

	public function query($sql, $params = array()){
		#echo "DEBUG: query(sql=$sql, params=".print_r($params,true).")<br />\n";
		$this->_queryCount++;
		$this->_error = false;
		$this->_errorInfo = array(0, null, null); $this->_resultsArray=[]; $this->_count=0; $this->_lastId=0;
		if ($this->_query = $this->_pdo->prepare($sql)) {
			$x = 1;
			if (count($params)) {
				foreach ($params as $param) {
					$this->_query->bindValue($x, $param);
					$x++;
				}
			}

			try {
				if($this->_query->execute()){
					if ($this->_query->columnCount() > 0) {
						$this->_results = $this->_query->fetchALL(PDO::FETCH_OBJ);
						$this->_resultsArray = json_decode(json_encode($this->_results),true);
					}
					$this->_count = $this->_query->rowCount();
                    if (preg_match('/^INSERT INTO (\w+)/i', $sql, $matches)) {
						// Try parsing the returned id
						$row = $this->first();
						if (isset($row->id)) {
							$this->_lastId = intval($row->id);
						} else {
							$tableName = $matches[1];
							// Determine the sequence name based on the table name
							//NOTE: PostgreSQL sequence increments are non-transactional -> there is no guarantee that lastId will be correct
							$sequenceName = $tableName . '_id_seq';
							$this->_lastId = $this->_pdo->lastInsertId($sequenceName);
						}
					} else {
						$this->_lastId = 0;
					}
				}else{
					throw new Exception("db error");
				}
			} catch (Exception $e){
				$this->_error = true;
				$this->_results = [];
				$this->_errorInfo = $this->_query->errorInfo();
                echo 'ERROR: ' . $e->getMessage();
			}
		}

		return $this;
	}

	public function findAll($table){
		return $this->action('SELECT *',$table);
	}

	public function findById($id,$table){
		return $this->action('SELECT *',$table,array('id','=',$id));
	}

	public function action($action, $table, $where = array()){
		$sql    = "{$action} FROM {$table}";
		$values = array();
		$is_ok  = true;

		if ($where_text = $this->_calcWhere($where, $values, "and", $is_ok));

		$sql .= " WHERE $where_text";
        // var_dump($sql);
		if ($is_ok);
		if (!$this->query($sql, $values)->error());
		return $this;

		return false;
	}

	private function _calcWhere($w, &$vals, $comboparg='and', &$is_ok=NULL) {
		// echo "DEBUG: Entering _calcwhere(w=".print_r($w,true).",...)<br />\n";
		if (is_array($w)) {
			#echo "DEBUG: is_array - check<br />\n";
			$comb_ops   = ['and', 'or', 'and not', 'or not'];
			$valid_ops  = ['=', '<', '>', '<=', '>=', '<>', '!=', 'LIKE', 'NOT LIKE', 'ALIKE', 'NOT ALIKE', 'REGEXP', 'NOT REGEXP'];
			$two_args   = ['IS NULL', 'IS NOT NULL'];
			$four_args  = ['BETWEEN', 'NOT BETWEEN'];
			$arr_arg    = ['IN', 'NOT IN'];
			$nested_arg = ['ANY', 'ALL', 'SOME'];
			$nested     = ['EXISTS', 'NOT EXISTS'];
			$nestedIN   = ['IN SELECT', 'NOT IN SELECT'];
			$wcount     = count($w);

			if ($wcount == 0)
			return "";

			# believe it or not, this appears to be the fastest way to check
			# sequential vs associative. Particularly with our expected short
			# arrays it shouldn't impact memory usage
			# https://gist.github.com/Thinkscape/1965669
			if (array_values($w) === $w) { // sequential array
				#echo "DEBUG: Sequential array - check!<br />\n";
				if (in_array(strtolower($w[0]), $comb_ops)) {
					#echo "DEBUG: w=".print_r($w,true)."<br />\n";
					$sql = '';
					$combop = '';
					for ($i = 1; $i < $wcount; $i++) {
						$sql .= ' '. $combop . ' ' . $this->_calcWhere($w[$i], $vals, "and", $is_ok);
						$combop = $w[0];
					}
					return '('.$sql.')';

				} elseif ($wcount==3  &&  in_array($w[1],$valid_ops)) {
					#echo "DEBUG: normal condition w=".print_r($w,true)."<br />\n";
					$vals[] = $w[2];
					return "{$w[0]} {$w[1]} ?";

				} elseif ($wcount==2  &&  in_array($w[1],$two_args)) {
					return "{$w[0]} {$w[1]}";

				} elseif ($wcount==4  &&  in_array($w[1],$four_args)) {
					$vals[] = $w[2];
					$vals[] = $w[3];
					return "{$w[0]} {$w[1]} ? AND ?";

				} elseif ($wcount==3  &&  in_array($w[1],$arr_arg)  &&  is_array($w[2])) {
					$vals = array_merge($vals,$w[2]);
					return "{$w[0]} {$w[1]} (" . substr( str_repeat(",?",count($w[2])), 1) . ")";

				} elseif (($wcount==5 || $wcount==6 && is_array($w[5]))  &&  in_array($w[1],$valid_ops)  &&  in_array($w[2],$nested_arg)) {
					return  "{$w[0]} {$w[1]} {$w[2]}" . $this->get_subquery_sql($w[4],$w[3],$w[5],$vals,$is_ok);

				} elseif (($wcount==3 || $wcount==4 && is_array($w[3]))  &&  in_array($w[0],$nested)) {
					return $w[0] . $this->get_subquery_sql($w[2],$w[1],$w[3],$vals,$is_ok);

				} elseif (($wcount==4 || $wcount==5 && is_array($w[4]))  &&  in_array($w[1],$nestedIN)) {
					return "{$w[0]} " . substr($w[1],0,-7) . $this->get_subquery_sql($w[3],$w[2],$w[4],$vals,$is_ok);

				} else {
					echo "ERROR: w=".print_r($w,true)."<br />\n";
					$is_ok = false;
				}
			} else { // associative array ['field' => 'value']
				#echo "DEBUG: Associative<br />\n";
				$sql = '';
				$combop = '';
				foreach ($w as $k=>$v) {
					if (in_array(strtolower($k), $comb_ops)) {
						#echo "DEBUG: A<br />\n";
						#echo "A: k=$k, v=".print_r($v,true)."<br />\n";
						$sql .= $combop . ' (' . $this->_calcWhere($v, $vals, $k, $is_ok) . ') ';
						$combop = $comboparg;
					} else {
						#echo "DEBUG: B<br />\n";
						#echo "B: k=$k, v=".print_r($v,true)."<br />\n";
						$vals[] = $v;
						if (in_array(substr($k,-1,1), array('=', '<', '>'))) // 'field !='=>'value'
						$sql .= $combop . ' ' . $k . ' ? ';
						else // 'field'=>'value'
						$sql .= $combop . ' ' . $k . ' = ? ';
						$combop = $comboparg;
					}
				}
				return ' ('.$sql.') ';
			}
		} else {
			echo "ERROR: No array in $w<br />\n";
			$is_ok = false;
		}
	}

	public function get($table, $where){
		return $this->action('SELECT *', $table, $where);
	}

	public function delete($table, $where){
		return empty($where) ? false : $this->action('DELETE', $table, $where);
	}

	public function deleteById($table,$id){
		return $this->action('DELETE',$table,array('id','=',$id));
	}

	public function insert($table, $fields = [], $update = false)
    {
        $keys = array_keys($fields);
        $values = [];
        $records = 0;

        foreach ($fields as $field) {
            $count = is_array($field) ? count($field) : 1;

            if (!isset($first_time) || $count < $records) {
                $first_time = true;
                $records = $count;
            }
        }

        for ($i = 0; $i < $records; $i++) {
            foreach ($fields as $field) {
                $values[] = is_array($field) ? $field[$i] : $field;
            }
        }

        $col = ",(" . substr(str_repeat(",?", count($fields)), 1) . ")";
        $sql = "INSERT INTO $table (\"" . implode('","', $keys) . "\") VALUES " . substr(str_repeat($col, $records), 1);

        if ($update) {
            $sql .= " ON CONFLICT DO UPDATE SET ";

            foreach ($keys as $key) {
                if ($key != "id") {
                    $sql .= "\"$key\" = excluded.\"$key\",";
                }
            }

            if (!empty($keys)) {
                $sql = rtrim($sql, ',');
            }
        }

		$sql .= " RETURNING id";

        return !$this->query($sql, $values)->error();
}

public function update($table, $id, $fields) {
    $sql = "UPDATE {$table} SET " . (empty($fields) ? "" : "\"") . implode("\" = ?, \"", array_keys($fields)) . (empty($fields) ? "" : "\" = ? ");
    $is_ok = true;
    if (!is_array($id)) {
        $sql .= "WHERE id = ?";
        $fields[] = $id;
    } else {
        if (empty($id)) {
            return false;
        }
        $where_arr = [];
        foreach ($id as $key => $value) {
            $where_arr[] = "\"{$key}\" = ?";
            $fields[] = $value;
        }
        $where_text = implode(" AND ", $where_arr);
        $sql .= "WHERE {$where_text}";
    }
    if ($is_ok) {
        if (!$this->query($sql, $fields)->error()) {
            return true;
        }
    }
    return false;
}

	public function results($assoc = false){
        if($assoc) return ($this->_resultsArray) ? $this->_resultsArray : [];
		return ($this->_results) ? $this->_results : [];
	}

	public function first($assoc = false){
        return (($this->count()>0)  ?  $this->results($assoc)[0]  :  []);
	}

	public function count(){
		return $this->_count;
	}

	public function error(){
		return $this->_error;
	}

	public function errorInfo() {
		return $this->_errorInfo;
	}

	public function errorString() {
		return 'ERROR #'.$this->_errorInfo[0].': '.$this->_errorInfo[2];
	}

	public function lastId(){
		return $this->_lastId;
	}

	public function getQueryCount(){
		return $this->_queryCount;
	}

	private function get_subquery_sql($action, $table, $where, &$values, &$is_ok) {
		if (is_array($where))
		if ($where_text = $this->_calcWhere($where, $values, "and", $is_ok))
		$where_text = " WHERE $where_text";

		return " (SELECT $action FROM $table$where_text)";
	}

	public function cell($tablecolumn, $id=[]) {
		$input = explode(".", $tablecolumn, 2);

		if (count($input) != 2)
		return null;

		$result = $this->action("SELECT {$input[1]}", $input[0], (is_numeric($id) ? ["id","=",$id] : $id));

		return ($result && $this->_count>0)  ?  $this->_resultsArray[0][$input[1]]  :  null;
	}

	public function getColCount(){
		return $this->_query->columnCount();
	}

	public function getColMeta($counter){
		return $this->_query->getColumnMeta($counter);
	}

}
