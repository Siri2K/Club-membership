USE hoc353_1;

#Get complete details for every location #7
SELECT l.location_id, l.location_name, l.address, l.city, l.province, l.postal_code, l.phone_number, l.web_address, l.location_type, l.capacity,
	(SELECT CONCAT(p.first_name, ' ', p.last_name) #For gm
	FROM personnels p
	JOIN personnels_in_locations pil ON p.SSN = pil.personnel_SSN #join on ssn
	WHERE pil.location_id = l.location_id AND p.personnel_role = 'General Manager') AS general_manager_name, #where they have title of manager
	COUNT(cmel.club_member_id) AS number_of_club_members
FROM locations l
LEFT JOIN club_member_enrolled_in_locations cmel ON l.location_id = cmel.location_id
GROUP BY l.location_id; #sort by loc id

#from a family member get details of 2nd and all associate club members #8
SELECT 
    fm2.first_name AS secondary_first_name, fm2.last_name AS secondary_last_name, fm2.phone_number AS secondary_phone_number, cm.club_member_id, 
    cm.first_name AS club_member_first_name, cm.last_name AS club_member_last_name, cm.birthdate, cm.SSN AS club_member_SSN,
    cm.medicare, cm.phone_number AS club_member_phone_number, cm.address, cm.city, cm.province, cm.postal_code, sfm.relation
FROM family_members fm1  #Primary family member
JOIN secondary_family_members sfm ON fm1.SSN = sfm.family_SSN  #Link to secondary family member (actually a club member)
JOIN club_members fm2 ON sfm.club_member_id = fm2.club_member_id  #details of secondary family member (actually a club member)
JOIN family_enrolled_members fem ON fm1.SSN = fem.family_SSN  #associated members
JOIN club_members cm ON fem.club_member_id = cm.club_member_id  #Get details of associated members
WHERE fm1.SSN = '106201399';  #Test SSN to specify primary family member

#given location and day get all teams recorded in the system #9
SELECT s.session_time, s.address AS session_address, s.session_type, t1.team_name AS team1_name, t2.team_name AS team2_name, s.team_1_score, s.team_2_score,
    (SELECT CONCAT(p.first_name, ' ', p.last_name) #coach 1
        FROM personnels p WHERE p.SSN = t1.head_coach_id) AS coach1_name, 
    (SELECT CONCAT(p.first_name, ' ', p.last_name) #coach 2
        FROM personnels p WHERE p.SSN = t2.head_coach_id) AS coach2_name, 
    (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') #team 1 Goalkeeper
        FROM goalkeepers g 
        JOIN club_members cm ON g.goalkeeper_id = cm.club_member_id 
        WHERE g.team_id = t1.team_id) AS team1_goalkeeper,
    (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') #team 1 Defender
        FROM defenders d 
        JOIN club_members cm ON d.defender_id = cm.club_member_id 
        WHERE d.team_id = t1.team_id) AS team1_defender,
    (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') #team 1 Midfielder
        FROM midfielders m 
        JOIN club_members cm ON m.midfielder_id = cm.club_member_id 
        WHERE m.team_id = t1.team_id) AS team1_midfielder,
    (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') #team 1 Forward
        FROM forwards f 
        JOIN club_members cm ON f.forward_id = cm.club_member_id 
        WHERE f.team_id = t1.team_id) AS team1_forward,
    (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') #team 2 Goalkeeper
        FROM goalkeepers g 
        JOIN club_members cm ON g.goalkeeper_id = cm.club_member_id 
        WHERE g.team_id = t2.team_id) AS team2_goalkeeper,
    (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') #team 2 Defender
        FROM defenders d 
        JOIN club_members cm ON d.defender_id = cm.club_member_id 
        WHERE d.team_id = t2.team_id) AS team2_defender,
    (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') #team 2 Midfielder
        FROM midfielders m 
        JOIN club_members cm ON m.midfielder_id = cm.club_member_id 
        WHERE m.team_id = t2.team_id) AS team2_midfielder,
    (SELECT GROUP_CONCAT(CONCAT(cm.first_name, ' ', cm.last_name) SEPARATOR ', ') #team 2 Forward
        FROM forwards f 
        JOIN club_members cm ON f.forward_id = cm.club_member_id 
        WHERE f.team_id = t2.team_id) AS team2_forward
FROM sessions s
JOIN teams t1 ON s.team_1_id = t1.team_id #team 1 id
JOIN teams t2 ON s.team_2_id = t2.team_id #team 2 id
WHERE s.address = '6855 Little Port, South Miles, Minnesota' #Sample Data 
AND s.session_time >= '2024-04-09' #Sample Date
ORDER BY s.session_time ASC;

#Currently active club members w at least four different locations and are members for at most two years. #10
SELECT cm.club_member_id, cm.first_name, cm.last_name
FROM club_members cm
JOIN club_member_enrolled_in_locations cml ON cm.club_member_id = cml.club_member_id
WHERE cml.end_date IS NULL # currently active members
AND DATEDIFF(CURDATE(), cml.start_date) <= 730 # members for at most two years (730 days)
GROUP BY cm.club_member_id, cm.first_name, cm.last_name
HAVING COUNT(DISTINCT cml.location_id) >= 4 # associated with at least four different locations
ORDER BY cm.club_member_id ASC;

#For a period of time, report of teams formation for all locations #11
SELECT s.address,
    COUNT(CASE WHEN s.session_type = 'Training' THEN 1 END) AS total_training_sessions, #the number of training sessions
    COUNT(CASE WHEN s.session_type = 'Game' THEN 1 END) AS total_game_sessions, #the number of game sessions
    SUM(CASE WHEN s.session_type = 'Training' THEN #total number of players in training sessions
        (SELECT COUNT(*) FROM goalkeepers g1 WHERE g1.team_id = s.team_1_id) +
        (SELECT COUNT(*) FROM defenders d1 WHERE d1.team_id = s.team_1_id) +
        (SELECT COUNT(*) FROM midfielders m1 WHERE m1.team_id = s.team_1_id) +
        (SELECT COUNT(*) FROM forwards f1 WHERE f1.team_id = s.team_1_id) +
        (SELECT COUNT(*) FROM goalkeepers g2 WHERE g2.team_id = s.team_2_id) +
        (SELECT COUNT(*) FROM defenders d2 WHERE d2.team_id = s.team_2_id) +
        (SELECT COUNT(*) FROM midfielders m2 WHERE m2.team_id = s.team_2_id) +
        (SELECT COUNT(*) FROM forwards f2 WHERE f2.team_id = s.team_2_id)
    END) AS total_training_players,
    SUM(CASE WHEN s.session_type = 'Game' THEN #total number of players in game sessions
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
WHERE s.session_time BETWEEN '2024-01-01' AND '2024-03-31' #date range
GROUP BY s.address
HAVING total_game_sessions >= 3 #min 3 games per loc
ORDER BY total_game_sessions DESC;


#all active club members who have never been assigned (members that are enrolled but have no position) #12
SELECT cm.club_member_id, cm.first_name, cm.last_name,
	FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) AS age, #find age of the club member
    cm.phone_number, l.location_name
FROM club_members cm
JOIN club_member_enrolled_in_locations cml ON cm.club_member_id = cml.club_member_id 
JOIN locations l ON cml.location_id = l.location_id
LEFT JOIN goalkeepers gk ON cm.club_member_id = gk.goalkeeper_id #find out if gk
LEFT JOIN defenders df ON cm.club_member_id = df.defender_id #find if defender
LEFT JOIN midfielders mf ON cm.club_member_id = mf.midfielder_id #mf
LEFT JOIN forwards fw ON cm.club_member_id = fw.forward_id #f
WHERE cml.end_date IS NULL #only include current
    AND gk.goalkeeper_id IS NULL #players with roll
    AND df.defender_id IS NULL
    AND mf.midfielder_id IS NULL
    AND fw.forward_id IS NULL
ORDER BY l.location_name ASC, cm.club_member_id ASC;

#report of all active members only assigned to gk #13
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
WHERE cml.end_date IS NULL  #include currently active club members
    AND gk.goalkeeper_id IS NOT NULL #club members who are goalkeepers
    AND df.defender_id IS NULL #exclude club members who are defenders
    AND mf.midfielder_id IS NULL #exclude club members who are midfielders
    AND fw.forward_id IS NULL #exclude club members who are forwards
GROUP BY cm.club_member_id
HAVING COUNT(DISTINCT gk.goalkeeper_id) >= 1 #ensure the club member is assigned to at least one formation session as a goalkeeper
ORDER BY l.location_name ASC, cm.club_member_id ASC;

#All active club members assigned at least once to every formation role #14
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
WHERE cml.end_date IS NULL  #include currently active club members
    AND EXISTS (
        SELECT 1 FROM sessions s
        WHERE (s.team_1_id = gk.team_id OR s.team_2_id = gk.team_id)
        AND s.session_type = 'Game'
    )  #member assigned as goalkeeper in a game session
    AND EXISTS (
        SELECT 1 FROM sessions s
        WHERE (s.team_1_id = df.team_id OR s.team_2_id = df.team_id)
        AND s.session_type = 'Game'
    )  #member assigned as defender
    AND EXISTS (
        SELECT 1 FROM sessions s
        WHERE (s.team_1_id = mf.team_id OR s.team_2_id = mf.team_id)
        AND s.session_type = 'Game'
    )  #mf
    AND EXISTS (
        SELECT 1 FROM sessions s
        WHERE (s.team_1_id = fw.team_id OR s.team_2_id = fw.team_id)
        AND s.session_type = 'Game'
    )  #f
GROUP BY cm.club_member_id
HAVING 
    COUNT(DISTINCT gk.goalkeeper_id) >= 1  #assigned as goalkeeper at least once
    AND COUNT(DISTINCT df.defender_id) >= 1  #assigned as defender at least once
    AND COUNT(DISTINCT mf.midfielder_id) >= 1  #assigned as midfielder at least once
    AND COUNT(DISTINCT fw.forward_id) >= 1  #assigned as forward at least once
ORDER BY l.location_name ASC, cm.club_member_id ASC;

