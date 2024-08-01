<?php
include '../db.php';

if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $sql = "SELECT * FROM teams WHERE team_id=$id";
    $result = $conn->query($sql);
    $table = $result->fetch_assoc();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $location_id = $_POST['location_id'];
    $team_name = $_POST['team_name'];
    $head_coach_id = $_POST['head_coach_id'];
    $gender = $_POST['gender'];


    $sql = "
        UPDATE teams SET 
        location_id='$first_name', 
        team_name='$last_name', 
        birthdate='$birthdate', 
        gender='$medicare', 
        ";
    if ($conn->query($sql) === TRUE) {
        header('Location: index.php');
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Teams</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Edit Teams</h1>
    <form method="POST">
        <input type="hidden" name="SSN" value="<?= $table['SSN'] ?>">


        <label for="location_id">Location ID:</label><br>
        <input type="text" id="location_id" name="location_id" value="<?= $table['location_id'] ?>" required><br><br>

        <label for="team_name">Team Name:</label><br>
        <input type="text" id="team_name" name="team_name" value="<?= $table['team_name'] ?>" required><br><br>

        <label for="birthdate">Date of Birth:</label><br>
        <input type="text" id="birthdate" name="birthdate" value="<?= $table['birthdate'] ?>" required><br><br>

        <label for="medicare">Medicare #:</label><br>
        <input type="text" id="medicare" name="medicare" value="<?= $table['medicare'] ?>" required><br><br>

        
        <input type="submit" value="Update Teams">
    </form>
    <br>
    <a href="index.php">Back to Teams List</a>
</body>
</html>
