<?php
include '../db.php';

if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $sql = "SELECT * FROM club_members WHERE club_member_id=$id";
    $result = $conn->query($sql);
    $table = $result->fetch_assoc();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id = $_POST['club_member_id'];
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $birthdate = $_POST['birthdate'];
    $SSN = $_POST['SSN'];
    $medicare = $_POST['medicare'];
    $phone_number = $_POST['phone_number'];
    $address = $_POST['address'];
    $city = $_POST['city'];
    $province = $_POST['province'];
    $postal_code = $_POST['postal_code'];
    $gender = $_POST['gender'];


    $sql = "
        UPDATE club_members SET 
        first_name='$first_name', 
        last_name='$last_name', 
        birthdate='$birthdate', 
        SSN='$SSN', 
        medicare='$medicare', 
        phone_number='$phone_number', 
        address='$address', 
        city='$city', 
        province='$province',
        postal_code='$postal_code', 
        gender='$gender'
        WHERE club_member_id='$id'
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
    <title>Edit Club Member</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Edit Club Member</h1>
    <form method="POST">
        <input type="hidden" name="club_member_id" value="<?= $table['club_member_id'] ?>">


        <label for="first_name">First Name:</label><br>
        <input type="text" id="first_name" name="first_name" value="<?= $table['first_name'] ?>" required><br><br>

        <label for="last_name">Last Name:</label><br>
        <input type="text" id="last_name" name="last_name" value="<?= $table['last_name'] ?>" required><br><br>

        <label for="birthdate">Date of Birth:</label><br>
        <input type="text" id="birthdate" name="birthdate" value="<?= $table['birthdate'] ?>" required><br><br>

        <label for="SSN">SSN:</label><br>
        <input type="text" id="SSN" name="SSN" value="<?= $table['SSN'] ?>" required><br><br>

        <label for="medicare">Medicare #:</label><br>
        <input type="text" id="medicare" name="medicare" value="<?= $table['medicare'] ?>" required><br><br>

        <label for="phone_number">Phone Number:</label><br>
        <input type="text" id="phone_number" name="phone_number" value="<?= $table['phone_number'] ?>" required><br><br>

        <label for="address">Address:</label><br>
        <input type="text" id="address" name="address" value="<?= $table['address'] ?>" required><br><br>

        <label for="city">City:</label><br>
        <input type="text" id="city" name="city" value="<?= $table['city'] ?>" required><br><br>

        <label for="province">Province:</label><br>
        <input type="text" id="province" name="province" value="<?= $table['province'] ?>" required><br><br>

        <label for="postal_code">Postal Code:</label><br>
        <input type="text" id="postal_code" name="postal_code" value="<?= $table['postal_code'] ?>" required><br><br>

        <label for="gender">Gender:</label><br>
        <input type="text" id="gender" name="gender" value="<?= $table['gender'] ?>" required><br><br>
        
        <input type="submit" value="Update Club Member">
    </form>
    <br>
    <a href="index.php">Back to Club Member List</a>
</body>
</html>
