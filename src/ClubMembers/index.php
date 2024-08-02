<!-- Backend code -->
<?php 
    include '../db.php';
    include '../queries.php';

    
    $page_title="Club Members"; 
    
    /* Queries */
    $query = "
        SELECT * FROM club_members AS ClubMembers
        ORDER BY club_member_id
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
        <title>Club Members List</title>
    </head>

    <body>
    <!-- Active Club Members -->
    <h1>Club Members List</h1>
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
            <th>Gender</th>
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
                <td><?=$row['gender']?></td>

                <!-- Edit and Delete Button -->
                <td>
                    <a href="edit.php?id=<?= $row['club_member_id'] ?>">Edit</a>
                    <a href="delete.php?id=<?= $row['club_member_id'] ?>">Delete</a>
                </td>
            </tr>
        <?php endwhile; ?>
        
        <!-- Add Button -->
        <br>
            <a href="add.php">Add New Club Member</a>
        </br>
        
    </table>

    <!-- Table -->
    <h1>Active Club Members List</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Club Member ID</th>
            <th>First Name</th>
            <th>Last Name</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query10->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['club_member_id']?></td>
                <td><?=$row['first_name']?></td>
                <td><?=$row['last_name']?></td>
            </tr>
        <?php endwhile; ?>
    </table>

    <h1>Active and Unassigned Club Members List</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Club Member ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Age</th>
            <th>Phone Number</th>
            <th>Location</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query12->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['club_member_id']?></td>
                <td><?=$row['first_name']?></td>
                <td><?=$row['last_name']?></td>
                <td><?=$row['age']?></td>
                <td><?=$row['phone_number']?></td>
                <td><?=$row['location_name']?></td>
            </tr>
        <?php endwhile; ?>
    </table>

    <h1>Goal Keepers</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Club Member ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Age</th>
            <th>Phone Number</th>
            <th>Location</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query13->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['club_member_id']?></td>
                <td><?=$row['first_name']?></td>
                <td><?=$row['last_name']?></td>
                <td><?=$row['age']?></td>
                <td><?=$row['phone_number']?></td>
                <td><?=$row['location_name']?></td>
            </tr>
        <?php endwhile; ?>
    </table>

    <h1>Members that done all roles</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Club Member ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Age</th>
            <th>Phone Number</th>
            <th>Location</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query14->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['club_member_id']?></td>
                <td><?=$row['first_name']?></td>
                <td><?=$row['last_name']?></td>
                <td><?=$row['age']?></td>
                <td><?=$row['phone_number']?></td>
                <td><?=$row['location_name']?></td>
            </tr>
        <?php endwhile; ?>
    </table>

    <h1>Club Members who have not lost</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Club Member ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Age</th>
            <th>Phone Number</th>
            <th>Address</th>
            <th>Location</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query16->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['club_member_id']?></td>
                <td><?=$row['first_name']?></td>
                <td><?=$row['last_name']?></td>
                <td><?=$row['age']?></td>
                <td><?=$row['phone_number']?></td>
                <td><?=$row['address']?></td>
                <td><?=$row['location_name']?></td>
            </tr>
        <?php endwhile; ?>
    </table>
    </body>

</html>