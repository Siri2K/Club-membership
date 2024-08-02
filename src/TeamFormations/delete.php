<?php
include '../db.php';


if (isset($_GET['id'])) {
    $id = $_GET['id'];
    
    $sql1 = "DELETE FROM goalkeepers WHERE team_id=$id";
    $sql2 = "DELETE FROM defenders WHERE team_id=$id";
    $sql3 = "DELETE FROM midfielders WHERE team_id=$id";
    $sql4 = "DELETE FROM forwards WHERE team_id=$id";

    $sql = "DELETE FROM teams WHERE team_id=$id";
    
    /* Delete Children */
    if ($conn->query($sql1) === TRUE) {
        ob_start();
    } 
    else {
        echo "Error: " . $sql1 . "<br>" . $conn->error;
    }

    if ($conn->query($sql2) === TRUE) {
        ob_start();
    } 
    else {
        echo "Error: " . $sql2 . "<br>" . $conn->error;
    }

    if ($conn->query($sql3) === TRUE) {
        ob_start();
    } 
    else {
        echo "Error: " . $sql3 . "<br>" . $conn->error;
    }

    if ($conn->query($sql4) === TRUE) {
        ob_start();
    } 
    else {
        echo "Error: " . $sql4 . "<br>" . $conn->error;
    }

    /* Delete Club Member */
    if ($conn->query($sql) === TRUE) {
        ob_start();
        header('Location: index.php');
    } 
    else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
    
}
?>