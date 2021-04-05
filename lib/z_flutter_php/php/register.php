<?php
    include "connexion.php";
    header('Content-type: application/json');

    if(isset($_POST['name'],$_POST['email'],$_POST['password'])){
        $name = $_POST['name'];
        $email = $_POST['email'];
        $password = $_POST['password'];

        echo json_encode([
            "data" => [
                $name,
                $email,
                $password,
            ]
        ]);
    }

    /*try {
        if(isset($name,$email,$password)){
            $req = $db->prepare("INSERT INTO users VALUES(null,?,?,?)");
            $req->execute(array($name,$email,sha1($password)));
            if($req){
                $succes = 1;
                $msg = "Succes registration";
            }else{
                $msg = "error registration";
                $succes = 0;
            }
        }else{
            $msg = "Empty data";
        }
        $succes = 1;
        $msg = "Succes registration";
    }catch(\Throwable $th){
        $succes = 0;
        $msg = "error ".$th->getMessage();
    }*/

    
?>