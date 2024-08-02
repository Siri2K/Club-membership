<?php
include '../db.php';


if (isset($_GET['id'])) {
    $id = $_GET['id'];
    
    $sql1 = "DELETE FROM club_member_enrolled_in_locations WHERE club_member_id=$id";
    $sql2 = "DELETE FROM goalkeepers WHERE goalkeeper_id=$id";
    $sql3 = "DELETE FROM defenders WHERE defender_id=$id";
    $sql4 = "DELETE FROM midfielders WHERE midfielder_id=$id";
    $sql5 = "DELETE FROM forwards WHERE forward_id=$id";
    $sql6 = "DELETE FROM secondary_family_members WHERE club_member_id=$id";
    $sql7 = "DELETE FROM family_enrolled_members WHERE club_member_id=$id";
    
    $sql = "DELETE FROM club_members WHERE club_member_id=$id";
    
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

    if ($conn->query($sql5) === TRUE) {
        ob_start();
    } 
    else {
        echo "Error: " . $sql5 . "<br>" . $conn->error;
    }

    if ($conn->query($sql6) === TRUE) {
        ob_start();
    } 
    else {
        echo "Error: " . $sql6 . "<br>" . $conn->error;
    }

    if ($conn->query($sql7) === TRUE) {
        ob_start();
    } 
    else {
        echo "Error: " . $sql7 . "<br>" . $conn->error;
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