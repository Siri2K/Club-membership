<?php
include 'db.php';

/* Queries */
$sql_query7 = "
    SELECT l.location_id, l.location_name, l.address, l.city, l.province, l.postal_code, l.phone_number, l.web_address, l.location_type, l.capacity,
	    (SELECT CONCAT(p.first_name, ' ', p.last_name)
	FROM personnels p
	JOIN personnels_in_locations pil ON p.SSN = pil.personnel_SSN
	WHERE pil.location_id = l.location_id AND p.personnel_role = 'General Manager') AS general_manager_name,
	COUNT(cmel.club_member_id) AS number_of_club_members
    FROM locations l
    LEFT JOIN club_member_enrolled_in_locations cmel ON l.location_id = cmel.location_id
    GROUP BY l.location_id
    ORDER BY l.province, l.city ASC;
";

$sql_query8 = "
    SELECT fm2.first_name AS secondary_first_name, fm2.last_name AS secondary_last_name, fm2.phone_number AS secondary_phone_number,
       cm.club_member_id, cm.first_name AS club_member_first_name, cm.last_name AS club_member_last_name, 
       cm.birthdate, cm.SSN AS club_member_SSN, cm.medicare, cm.phone_number AS club_member_phone_number, 
       cm.address, cm.city, cm.province, cm.postal_code, fem.relation
    FROM family_members fm1 
    JOIN family_enrolled_members fem ON fm1.SSN = fem.family_SSN
    JOIN club_members cm ON fem.club_member_id = cm.club_member_id 
    JOIN secondary_family_members sf ON cm.club_member_id = sf.club_member_id 
    JOIN family_members fm2 ON sf.family_SSN = fm2.SSN
    WHERE fm1.SSN = '106201399'; 
";

$sql_query9 = "
    SELECT s.session_time, s.address AS session_address, s.session_type, t1.team_name AS team1_name, t2.team_name AS team2_name, s.team_1_score, s.team_2_score,
        (SELECT CONCAT(f.first_name, ' ', f.last_name)
            FROM family_members f WHERE f.SSN = t1.head_coach_id) AS coach1_name, 
        (SELECT CONCAT(f.first_name, ' ', f.last_name)
            FROM family_members f WHERE f.SSN = t2.head_coach_id) AS coach2_name, 
        (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') 
            FROM goalkeepers g 
            JOIN club_members cm ON g.goalkeeper_id = cm.club_member_id 
            WHERE g.team_id = t1.team_id) AS team1_goalkeeper,
        (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') 
            FROM defenders d 
            JOIN club_members cm ON d.defender_id = cm.club_member_id 
            WHERE d.team_id = t1.team_id) AS team1_defender,
        (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') 
            FROM midfielders m 
            JOIN club_members cm ON m.midfielder_id = cm.club_member_id 
            WHERE m.team_id = t1.team_id) AS team1_midfielder,
        (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') 
            FROM forwards f 
            JOIN club_members cm ON f.forward_id = cm.club_member_id 
            WHERE f.team_id = t1.team_id) AS team1_forward,
        (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') 
            FROM goalkeepers g 
            JOIN club_members cm ON g.goalkeeper_id = cm.club_member_id 
            WHERE g.team_id = t2.team_id) AS team2_goalkeeper,
        (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') 
            FROM defenders d 
            JOIN club_members cm ON d.defender_id = cm.club_member_id 
            WHERE d.team_id = t2.team_id) AS team2_defender,
        (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') 
            FROM midfielders m 
            JOIN club_members cm ON m.midfielder_id = cm.club_member_id 
            WHERE m.team_id = t2.team_id) AS team2_midfielder,
        (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') 
            FROM forwards f 
            JOIN club_members cm ON f.forward_id = cm.club_member_id 
            WHERE f.team_id = t2.team_id) AS team2_forward
    FROM sessions s
    JOIN teams t1 ON s.team_1_id = t1.team_id 
    JOIN teams t2 ON s.team_2_id = t2.team_id 
    WHERE s.address = '6855 Little Port, South Miles, Minnesota' 
    AND s.session_time >= '2024-04-09' 
    ORDER BY s.session_time ASC;
";

$sql_query10 = "
    SELECT cm.club_member_id, cm.first_name, cm.last_name
    FROM club_members cm
    JOIN club_member_enrolled_in_locations cml ON cm.club_member_id = cml.club_member_id
    WHERE FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) >= 4 AND FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) <= 10
    AND DATEDIFF(CURDATE(), cml.start_date) <= 730 
    GROUP BY cm.club_member_id, cm.first_name, cm.last_name
    HAVING COUNT(DISTINCT cml.location_id) >= 4 
    ORDER BY cm.club_member_id ASC;
";

$sql_query11 = "
    SELECT s.address,
        COUNT(CASE WHEN s.session_type = 'Training' THEN 1 END) AS total_training_sessions, 
        COUNT(CASE WHEN s.session_type = 'Game' THEN 1 END) AS total_game_sessions, 
        SUM(CASE WHEN s.session_type = 'Training' THEN 
            (SELECT COUNT(*) FROM goalkeepers g1 WHERE g1.team_id = s.team_1_id) +
            (SELECT COUNT(*) FROM defenders d1 WHERE d1.team_id = s.team_1_id) +
            (SELECT COUNT(*) FROM midfielders m1 WHERE m1.team_id = s.team_1_id) +
            (SELECT COUNT(*) FROM forwards f1 WHERE f1.team_id = s.team_1_id) +
            (SELECT COUNT(*) FROM goalkeepers g2 WHERE g2.team_id = s.team_2_id) +
            (SELECT COUNT(*) FROM defenders d2 WHERE d2.team_id = s.team_2_id) +
            (SELECT COUNT(*) FROM midfielders m2 WHERE m2.team_id = s.team_2_id) +
            (SELECT COUNT(*) FROM forwards f2 WHERE f2.team_id = s.team_2_id)
        END) AS total_training_players,
        SUM(CASE WHEN s.session_type = 'Game' THEN 
            (SELECT COUNT(*) FROM goalkeepers g1 WHERE g1.team_id = s.team_1_id) +
            (SELECT COUNT(*) FROM defenders d1 WHERE d1.team_id = s.team_1_id) +
            (SELECT COUNT(*) FROM midfielders m1 WHERE m1.team_id = s.team_1_id) +
            (SELECT COUNT(*) FROM forwards f1 WHERE f1.team_id = s.team_1_id) +
            (SELECT COUNT(*) FROM goalkeepers g2 WHERE g2.team_id = s.team_2_id) +
            (SELECT COUNT(*) FROM defenders d2 WHERE d2.team_id = s.team_2_id) +
            (SELECT COUNT(*) FROM midfielders m2 WHERE m2.team_id = s.team_2_id) +
            (SELECT COUNT(*) FROM forwards f2 WHERE f2.team_id = s.team_2_id)
        END) AS total_game_players
    FROM sessions s
    WHERE s.session_time BETWEEN '2024-01-01' AND '2024-03-31'
    GROUP BY s.address
    HAVING total_game_sessions >= 3 
    ORDER BY total_game_sessions DESC;
";

$sql_query12 = "
    SELECT cm.club_member_id, cm.first_name, cm.last_name,
        FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) AS age, 
        cm.phone_number, l.location_name
    FROM club_members cm
    JOIN club_member_enrolled_in_locations cml ON cm.club_member_id = cml.club_member_id 
    JOIN locations l ON cml.location_id = l.location_id
    LEFT JOIN goalkeepers gk ON cm.club_member_id = gk.goalkeeper_id 
    LEFT JOIN defenders df ON cm.club_member_id = df.defender_id 
    LEFT JOIN midfielders mf ON cm.club_member_id = mf.midfielder_id
    LEFT JOIN forwards fw ON cm.club_member_id = fw.forward_id 
    WHERE cml.end_date IS NULL AND FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) >= 4 AND FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) <= 10 
        AND gk.goalkeeper_id IS NULL #players with roll
        AND df.defender_id IS NULL
        AND mf.midfielder_id IS NULL
        AND fw.forward_id IS NULL
    ORDER BY l.location_name ASC, cm.club_member_id ASC;
";

$sql_query13 = "
    SELECT cm.club_member_id, cm.first_name, cm.last_name,
        FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) AS age,
        cm.phone_number, l.location_name
    FROM club_members cm
    JOIN club_member_enrolled_in_locations cml ON cm.club_member_id = cml.club_member_id
    JOIN locations l ON cml.location_id = l.location_id
    LEFT JOIN goalkeepers gk ON cm.club_member_id = gk.goalkeeper_id
    LEFT JOIN defenders df ON cm.club_member_id = df.defender_id
    LEFT JOIN midfielders mf ON cm.club_member_id = mf.midfielder_id
    LEFT JOIN forwards fw ON cm.club_member_id = fw.forward_id
    WHERE cml.end_date IS NULL AND FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) >= 4 AND FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) <= 10 
        AND gk.goalkeeper_id IS NOT NULL 
        AND df.defender_id IS NULL
        AND mf.midfielder_id IS NULL 
        AND fw.forward_id IS NULL 
    GROUP BY cm.club_member_id
    HAVING COUNT(DISTINCT gk.goalkeeper_id) >= 1 
    ORDER BY l.location_name ASC, cm.club_member_id ASC;
";

$sql_query14 = "
    SELECT cm.club_member_id, cm.first_name, cm.last_name,
        FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) AS age,
        cm.phone_number, l.location_name
    FROM club_members cm
    JOIN club_member_enrolled_in_locations cml ON cm.club_member_id = cml.club_member_id
    JOIN locations l ON cml.location_id = l.location_id
    JOIN goalkeepers gk ON cm.club_member_id = gk.goalkeeper_id
    JOIN defenders df ON cm.club_member_id = df.defender_id
    JOIN midfielders mf ON cm.club_member_id = mf.midfielder_id
    JOIN forwards fw ON cm.club_member_id = fw.forward_id
    WHERE cml.end_date IS NULL  AND FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) >= 4 AND FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) <= 10 
        AND EXISTS (
            SELECT 1 FROM sessions s
            WHERE (s.team_1_id = gk.team_id OR s.team_2_id = gk.team_id)
            AND s.session_type = 'Game'
        )  
        AND EXISTS (
            SELECT 1 FROM sessions s
            WHERE (s.team_1_id = df.team_id OR s.team_2_id = df.team_id)
            AND s.session_type = 'Game'
        )  
        AND EXISTS (
            SELECT 1 FROM sessions s
            WHERE (s.team_1_id = mf.team_id OR s.team_2_id = mf.team_id)
            AND s.session_type = 'Game'
        )  
        AND EXISTS (
            SELECT 1 FROM sessions s
            WHERE (s.team_1_id = fw.team_id OR s.team_2_id = fw.team_id)
            AND s.session_type = 'Game'
        ) 
    GROUP BY cm.club_member_id
    HAVING 
        COUNT(DISTINCT gk.goalkeeper_id) >= 1 
        AND COUNT(DISTINCT df.defender_id) >= 1  
        AND COUNT(DISTINCT mf.midfielder_id) >= 1 
        AND COUNT(DISTINCT fw.forward_id) >= 1  
    ORDER BY l.location_name ASC, cm.club_member_id ASC;
";

$sql_query15 = "
    SELECT fm.SSN AS membership_number, fm.first_name, fm.last_name, CURDATE() - fm.birthdate as age, fm.phone_number, fm.email_address, l.location_name
    FROM family_enrolled_in_locations fel
    JOIN family_enrolled_members fem ON fel.family_ssn = fem.family_ssn 
    JOIN club_member_enrolled_in_locations cmil ON cmil.club_member_id = fem.club_member_id 
    JOIN club_members cm ON cm.club_member_id = cmil.club_member_id
    JOIN family_members fm ON fm.SSN = fem.family_SSN 
    JOIN teams t ON t.head_coach_id = fm.SSN 
    JOIN locations l ON l.location_id = fel.location_id
    WHERE fel.location_id = 1 
        AND fem.end_date is null AND FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) >= 4 AND FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) <= 10
        AND cmil.location_id = 1  
        AND t.location_id = 1 
    GROUP BY membership_number;
";

$sql_query16_1 = "
    WITH winning_teams AS (
	 SELECT
        CASE
            WHEN s.team_1_score > s.team_2_score THEN s.team_1_id
            ELSE s.team_2_id
        END AS winning_team_id,
        CASE
            WHEN s.team_1_score > s.team_2_score THEN s.team_1_score
            ELSE s.team_2_score
        END AS winning_score, t.location_id AS location_id
	FROM
		sessions s
	JOIN teams t ON ( 
			CASE
				WHEN s.team_1_score > s.team_2_score THEN s.team_1_id
				ELSE s.team_2_id
			END = t.team_id
		)
	WHERE
		s.team_1_score != s.team_2_score 
    )
    SELECT cm.club_member_id, cm.first_name, cm.last_name,  ROUND(DATEDIFF(CURDATE(), cm.birthdate) /360) as age, cm.phone_number, cm.address, l.location_name
    FROM  winning_teams wt
    JOIN goalkeepers g ON wt.winning_team_id = g.team_id
    JOIN club_members cm ON g.goalkeeper_id = cm.club_member_id
    JOIN club_member_enrolled_in_locations cmel ON cmel.location_id = wt.location_id
    JOIN locations l ON l.location_id = wt.location_id
    UNION
    SELECT cm.club_member_id, cm.first_name, cm.last_name, ROUND(DATEDIFF(CURDATE(), cm.birthdate) /360) as age, cm.phone_number, cm.address, l.location_name
    FROM  winning_teams wt
    JOIN forwards f ON wt.winning_team_id = f.team_id
    JOIN club_members cm ON f.forward_id = cm.club_member_id
    JOIN club_member_enrolled_in_locations cmel ON cmel.location_id = wt.location_id
    JOIN locations l ON l.location_id = wt.location_id
    UNION
    SELECT cm.club_member_id, cm.first_name, cm.last_name, ROUND(DATEDIFF(CURDATE(), cm.birthdate) /360) as age, cm.phone_number, cm.address, l.location_name
    FROM  winning_teams wt
    JOIN midfielders m ON wt.winning_team_id = m.team_id
    JOIN club_members cm ON m.midfielder_id = cm.club_member_id
    JOIN club_member_enrolled_in_locations cmel ON cmel.location_id = wt.location_id
    JOIN locations l ON l.location_id = wt.location_id
    UNION
    SELECT cm.club_member_id, cm.first_name, cm.last_name, ROUND(DATEDIFF(CURDATE(), cm.birthdate) / 360) as age, cm.phone_number, cm.address, l.location_name
    FROM  winning_teams wt
    JOIN defenders d ON wt.winning_team_id = d.team_id
    JOIN club_members cm ON d.defender_id = cm.club_member_id
    JOIN club_member_enrolled_in_locations cmel ON cmel.location_id = wt.location_id
    JOIN locations l ON l.location_id = wt.location_id
    ORDER BY location_name, club_member_id;

";

$sql_query16_2 = "
    WITH losing_teams AS
    (
    SELECT
        CASE
            WHEN s.team_1_score < s.team_2_score THEN s.team_1_id
            ELSE s.team_2_id
        END AS losing_team_id,
        CASE
            WHEN s.team_1_score > s.team_2_score THEN s.team_1_score
            ELSE s.team_2_score
        END AS losing_score, t.location_id AS location_id
        FROM
            sessions s
        JOIN teams t ON (  
            CASE
                WHEN s.team_1_score < s.team_2_score THEN s.team_1_id
                ELSE s.team_2_id
            END = t.team_id
        )
        WHERE
            s.team_1_score != s.team_2_score 
    )
    SELECT cm.club_member_id, cm.first_name, cm.last_name,  ROUND(DATEDIFF(CURDATE(), cm.birthdate) /360) as age, cm.phone_number, cm.address, l.location_name
    FROM  winning_teams wt
    JOIN goalkeepers g ON wt.winning_team_id = g.team_id
    JOIN club_members cm ON g.goalkeeper_id = cm.club_member_id
    JOIN club_member_enrolled_in_locations cmel ON cmel.location_id = wt.location_id
    JOIN locations l ON l.location_id = wt.location_id
    UNION
    SELECT cm.club_member_id, cm.first_name, cm.last_name, ROUND(DATEDIFF(CURDATE(), cm.birthdate) /360) as age, cm.phone_number, cm.address, l.location_name
    FROM  winning_teams wt
    JOIN forwards f ON wt.winning_team_id = f.team_id
    JOIN club_members cm ON f.forward_id = cm.club_member_id
    JOIN club_member_enrolled_in_locations cmel ON cmel.location_id = wt.location_id
    JOIN locations l ON l.location_id = wt.location_id
    UNION
    SELECT cm.club_member_id, cm.first_name, cm.last_name, ROUND(DATEDIFF(CURDATE(), cm.birthdate) /360) as age, cm.phone_number, cm.address, l.location_name
    FROM  winning_teams wt
    JOIN midfielders m ON wt.winning_team_id = m.team_id
    JOIN club_members cm ON m.midfielder_id = cm.club_member_id
    JOIN club_member_enrolled_in_locations cmel ON cmel.location_id = wt.location_id
    JOIN locations l ON l.location_id = wt.location_id
    UNION
    SELECT cm.club_member_id, cm.first_name, cm.last_name, ROUND(DATEDIFF(CURDATE(), cm.birthdate) / 360) as age, cm.phone_number, cm.address, l.location_name
    FROM  winning_teams wt
    JOIN defenders d ON wt.winning_team_id = d.team_id
    JOIN club_members cm ON d.defender_id = cm.club_member_id
    JOIN club_member_enrolled_in_locations cmel ON cmel.location_id = wt.location_id
    JOIN locations l ON l.location_id = wt.location_id
    ORDER BY location_name, club_member_id;
";

$sql_query17 = "
    SELECT personnels.first_name, personnels.last_name, pil.start_date AS start_date_as_president, pil.end_date AS end_date_as_president
    FROM personnels
    JOIN personnels_in_locations pil ON pil.personnel_SSN = personnels.SSN
    JOIN locations l ON l.location_id = pil.location_id
    WHERE personnel_role = 'General Manager' AND l.location_type = 'Head'
    ORDER BY personnels.first_name, personnels.last_name, start_date_as_president;
";

$sql_query18 = "
    SELECT p.first_name, p.last_name, p.phone_number, p.email_address, l.location_name, p.personnel_role
    FROM personnels p
    JOIN personnels_in_locations pil ON pil.personnel_SSN = p.SSN
    JOIN locations l ON l.location_id = pil.location_id
    WHERE mandate = 'Volunteer' AND p.SSN NOT IN (SELECT SSN from family_members)
    ORDER BY l.location_name, p.personnel_role, p.first_name, p.last_name;
";

/* Results from each Query */
$result_query7 = $conn->query($sql_query7);
$result_query8 = $conn->query($sql_query8);
$result_query9 = $conn->query($sql_query9);
$result_query10 = $conn->query($sql_query10);
$result_query11 = $conn->query($sql_query11);
$result_query12 = $conn->query($sql_query12);
$result_query13 = $conn->query($sql_query13);
$result_query14 = $conn->query($sql_query14);
$result_query15 = $conn->query($sql_query15);
$result_query16_1 = $conn->query($sql_query16_1);
$result_query16_2 = $conn->query($sql_query16_2);
$result_query17 = $conn->query($sql_query17);
$result_query18 = $conn->query($sql_query18);

?>