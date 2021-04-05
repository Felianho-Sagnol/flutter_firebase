<?php
    function connexion(){
        $host = "localhost";
        $dbname = "id16511713_flutter_db";
        $user = "id16511713_sagnol";
        $password = "5ZG=P>*|ZyJ@ZCdG";
        try {
            return new PDO("mysql:host=$host; dbname=$dbname,charset=utf8",$user,$password);
        }catch(\Throwable $th){
            echo json_encode([
                "error server : " => $th->getMessage()
            ]);
        }
    }
    $db = connexion();
?>
