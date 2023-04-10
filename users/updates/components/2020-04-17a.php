<?php

//Disables messaging in settings table if plugin not active
//Release Version 5.1.0
//Release Date Unknown


$countE=0;

$db->query("ALTER TABLE logs ADD COLUMN user_id integer");
$db->query("ALTER TABLE users_online ADD COLUMN user_id integer");
$db->query("ALTER TABLE users_online ADD COLUMN id integer");
$db->query("ALTER TABLE permission_page_matches ADD COLUMN permission_id integer");
$db->query("ALTER TABLE permission_page_matches ADD COLUMN page_id integer");


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
