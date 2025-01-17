<?php

//Adds DB Redirects after Login
//Release Version Unknown
//Release Date Unknown
//Rewrote 2019-03-01 BA

$countE=0;

$db->query("ALTER TABLE updates ADD COLUMN update_skipped smallint DEFAULT NULL");
if(!$db->error()) {
  logger(1,"System Updates","Inserted update_skipped to updates table");
} else {
  $error=$db->errorString();
  // $countE++;
  logger(1,"System Updates","Unable to insert update_skipped to updates table, Error: ".$error);
  $errors[] = "Unable to insert update_skipped to updates table, Error: ".$error;
}

if($countE==0) {
  $db->insert('updates',['migration'=>$update]);
  if(!$db->error()) {
    if($db->count()>0) {
      logger(1,"System Updates","Update $update successfully deployed.");
      $successes[] = "Update $update successfully deployed.";
    } else {
      logger(1,"System Updates","Update $update unable to be marked complete, query was successful but no database entry was made.");
      $errors[] = "Update ".$update." unable to be marked complete, query was successful but no database entry was made.";
    }
  } else {
    $error=$db->errorString();
    logger(1,"System Updates","Update $update unable to be marked complete, Error: ".$error);
    $errors[] = "Update $update unable to be marked complete, Error: ".$error;
  }
} else {
  logger(1,"System Updates","Update $update unable to be marked complete");
  $errors[] = "Update $update unable to be marked complete";
}
