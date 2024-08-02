<!-- Backend code -->
<?php 
    include '../db.php';
    include '../queries.php';

    
    $page_title="Locations"; 
    
    /* Queries */
    $query = "
        SELECT * FROM locations AS Locations
        ORDER BY location_id
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
        <title>Location List</title>
    </head>

    <body>
    <!-- Table -->
    <h1>Location List</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>ID</th>
            <th>Location Names</th>
            <th>Address</th>
            <th>City</th>
            <th>Province</th>
            <th>Postal-code</th>
            <th>Phone number</th>
            <th>Web address</th>
            <th>Type </th>
            <th>Capacity</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['location_id']?></td>
                <td><?=$row['location_name']?></td>
                <td><?=$row['address']?></td>
                <td><?=$row['city']?></td>
                <td><?=$row['province']?></td>
                <td><?=$row['postal_code']?></td>
                <td><?=$row['phone_number']?></td>
                <td><?=$row['web_address']?></td>
                <td><?=$row['location_type']?></td>
                <td><?=$row['capacity']?></td>

                <!-- Edit and Delete Button -->
                <td>
                    <a href="edit.php?id=<?= $row['location_id'] ?>">Edit</a>
                    <a href="delete.php?id=<?= $row['location_id'] ?>">Delete</a>
                </td>
            </tr>
        <?php endwhile; ?>
        
        <!-- Add Button -->
        <br>
            <a href="add.php">Add New Location</a>
        </br>
    </table>

    <!-- Query 7 Table -->
    <h1>Location List</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Location Names</th>
            <th>Address</th>
            <th>City</th>
            <th>Province</th>
            <th>Postal-code</th>
            <th>Phone number</th>
            <th>Web address</th>
            <th>Type </th>
            <th>Capacity</th>
            <th> General Manager</th>
            <th> # Club Members</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query7->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['location_name']?></td>
                <td><?=$row['address']?></td>
                <td><?=$row['city']?></td>
                <td><?=$row['province']?></td>
                <td><?=$row['postal_code']?></td>
                <td><?=$row['phone_number']?></td>
                <td><?=$row['web_address']?></td>
                <td><?=$row['location_type']?></td>
                <td><?=$row['capacity']?></td>
                <td><?=$row['general_manager_name']?></td>
                <td><?=$row['number_of_club_members']?></td>
            </tr>
        <?php endwhile; ?>
    </table>

    <!-- Query 9 Table -->
    <h1>Teams in Location #1</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Session Time</th>
            <th>Address</th>
            <th>Type</th>
            <th>Team 1</th>
            <th>Team 1 Score</th>
            <th>Team 1 Coach</th>
            <th>Team 1 Goalkeeper</th>
            <th>Team 1 Defender </th>
            <th>Team 1 Midfielders </th>
            <th>Team 1 Forward</th>
            <th>Team 2</th>
            <th>Team 2 Score</th>
            <th>Team 2 Coach</th>
            <th>Team 2 Goalkeeper</th>
            <th>Team 2 Defender </th>
            <th>Team 2 Midfielders </th>
            <th>Team 2 Forward</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query9->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['session_time']?></td>
                <td><?=$row['session_address']?></td>
                <td><?=$row['session_type']?></td>
                <td><?=$row['team1_name']?></td>
                <td><?=$row['team_1_score']?></td>
                <td><?=$row['coach1_name']?></td>
                <td><?=$row['team1_goalkeeper']?></td>
                <td><?=$row['team1_defender']?></td>
                <td><?=$row['team1_midfielder']?></td>
                <td><?=$row['team1_forward']?></td>
                <td><?=$row['team2_name']?></td>
                <td><?=$row['team_2_score']?></td>
                <td><?=$row['coach2_name']?></td>
                <td><?=$row['team2_goalkeeper']?></td>
                <td><?=$row['team2_defender']?></td>
                <td><?=$row['team2_midfielder']?></td>
                <td><?=$row['team2_forward']?></td>
            </tr>
        <?php endwhile; ?>
    </table>

    <h1>Family Member in Location #1</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Membership #</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Age</th>
            <th>Phone Number </th>
            <th>Email</th>
            <th>Location</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query15->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['membership_number']?></td>
                <td><?=$row['first_name']?></td>
                <td><?=$row['last_name']?></td>
                <td><?=$row['age']?></td>
                <td><?=$row['phone_number']?></td>
                <td><?=$row['email_address']?></td>
                <td><?=$row['location_name']?></td>
            </tr>
        <?php endwhile; ?>
    </table>
    </body>

</html>