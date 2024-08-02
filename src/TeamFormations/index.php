<!-- Backend code -->
<?php 
    include '../db.php';
    include '../queries.php';

    
    $page_title="Team Formation"; 
    
    /* Queries */
    $query = "
        SELECT * FROM teams AS TeamFormations
        ORDER BY team_id
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
        <title>Team Formation List</title>
    </head>

    <body>
    <!-- Table -->
    <h1>Team Formation List</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Location ID</th>
            <th>Team Name</th>
            <th>Head Coach ID</th>
            <th>Gender</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['location_id']?></td>
                <td><?=$row['team_name']?></td>
                <td><?=$row['head_coach_id']?></td>
                <td><?=$row['gender']?></td>
                

                <!-- Edit and Delete Button -->
                <td>
                    <a href="edit.php?id=<?= $row['team_id'] ?>">Edit</a>
                    <a href="delete.php?id=<?= $row['team_id'] ?>">Delete</a>
                </td>
            </tr>
        <?php endwhile; ?>
        
        <!-- Add Button -->
        <br>
            <a href="add.php">Add New Team</a>
        </br>
        
    </table>

    <h1>Team Formations Between Jan to March 2024</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Address</th>
            <th># Training Session</th>
            <th># Players training</th>
            <th># Game Session</th>
            <th># Players</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query11->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['address']?></td>
                <td><?=$row['total_training_sessions']?></td>
                <td><?=$row['total_game_sessions']?></td>
                <td><?=$row['total_training_players']?></td>
                <td><?=$row['total_game_players']?></td>
            </tr>
        <?php endwhile; ?>
    </table>
    </body>

</html>