<!-- Backend code -->
<?php 
    include '../db.php';
    include '../queries.php';

    
    $page_title="Family Members"; 
    
    /* Queries */
    $query = "
        SELECT * FROM family_members AS FamilyMembers
        ORDER BY SSN
    ";
    
    /* Results */
    $result = $conn->query($query);
?>


<!DOCTYPE html>
<html lang="en">
    <!-- Return Home Button -->
    <div class="w3-top">
        <div class="w3-bar w3-red w3-card w3-center-align w3-large">
            <a href="../" class="w3-bar-item w3-button w3-padding-large w3-white">Home</a>
        </div>
    </div>

    <head>
        <meta charset="UTF-8">
        <title>Family Members List</title>
    </head>

    <body>
    <!-- Table -->
    <h1>Family Members List</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Date of Birth</th>
            <th>SSN</th>
            <th>Medicare #</th>
            <th>Phone #</th>
            <th>Address</th>
            <th>City</th>
            <th>Province</th>
            <th>Postal Code</th>
            <th>Email Address</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['first_name']?></td>
                <td><?=$row['last_name']?></td>
                <td><?=$row['birthdate']?></td>
                <td><?=$row['SSN']?></td>
                <td><?=$row['medicare']?></td>
                <td><?=$row['phone_number']?></td>
                <td><?=$row['address']?></td>
                <td><?=$row['city']?></td>
                <td><?=$row['province']?></td>
                <td><?=$row['postal_code']?></td>
                <td><?=$row['email_address']?></td>

                <!-- Edit and Delete Button -->
                <td>
                    <a href="edit.php?id=<?= $row['SSN'] ?>">Edit</a>
                    <a href="delete.php?id=<?= $row['SSN'] ?>">Delete</a>
                </td>
            </tr>
        <?php endwhile; ?>
        
        <!-- Add Button -->
        <br>
            <a href="add.php">Add New Family Member</a>
        </br>
        
    </table>


    <!-- Query 8  Table-->
    <h1>Associated Family Members List</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Secondary First Name</th>
            <th>Secondary Last Name</th>
            <th>Secondary Phone #</th>
            <th>Club Member ID</th>
            <th>Club Member First Name</th>
            <th>Club Member Last Name</th>
            <th>Club member Date of Birth</th>
            <th>Club member SSN</th>
            <th>Club member Medicare</th>
            <th>Address</th>
            <th>City</th>
            <th>Province</th>
            <th>Postal Code</th>
            <th>Relation</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query8->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['secondary_first_name']?></td>
                <td><?=$row['secondary_last_name']?></td>
                <td><?=$row['secondary_phone_number']?></td>
                <td><?=$row['club_member_id']?></td>
                <td><?=$row['club_member_last_name']?></td>
                <td><?=$row['birthdate']?></td>
                <td><?=$row['club_member_SSN']?></td>
                <td><?=$row['medicare']?></td>
                <td><?=$row['club_member_phone_number']?></td>
                <td><?=$row['address']?></td>
                <td><?=$row['city']?></td>
                <td><?=$row['province']?></td>
                <td><?=$row['postal_code']?></td>
                <td><?=$row['relation']?></td>
            </tr>
        <?php endwhile;?>
    </table>

    </body>

</html>