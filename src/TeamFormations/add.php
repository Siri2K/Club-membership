<?php
include '../db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $location_id = $_POST['location_id'];
    $team_name = $_POST['team_name'];
    $head_coach_id = $_POST['head_coach_id'];
    $gender = $_POST['gender'];

    $sql = " 
        INSERT INTO teams (
            location_id, 
            team_name, 
            head_coach_id, 
            gender, 
        )
        VALUES (
            '$location_id',
            '$team_name',
            '$birthdate',
            '$head_coach_id',
            '$gender',
        )";
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
    <title>Add Team</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Add New Team</h1>
    <form method="POST">
        <label for="location_id">Location ID:</label><br>
        <input type="text" id="location_id" name="location_id" value="<?= $table['location_id'] ?>" required><br><br>

        <label for="team_name">Team Name:</label><br>
        <input type="text" id="team_name" name="team_name" value="<?= $table['team_name'] ?>" required><br><br>

        <label for="head_coach_id">Head Coach ID:</label><br>
        <input type="text" id="head_coach_id" name="head_coach_id" value="<?= $table['head_coach_id'] ?>" required><br><br>

        <label for="gender">Team Gender:</label><br>
        <input type="gender" id="gender" name="gender" value="<?= $table['gender'] ?>" required><br><br>

        <input type="submit" value="Add New Team">
    </form>
    <br>
        <a href="index.php">Back to Team List</a>
    </br>
</body>
</html>