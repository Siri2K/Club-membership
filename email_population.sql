DELIMITER //
DROP PROCEDURE IF EXISTS populate_email//
CREATE PROCEDURE populate_email()
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE head_coach_ID CHAR(9);
    DECLARE head_coach_first_name VARCHAR(20);
    DECLARE head_coach_last_name VARCHAR(20);
    DECLARE head_coach_email VARCHAR(200);
    DECLARE location_name VARCHAR(50);
    DECLARE location_address VARCHAR(200);
    DECLARE session_time DATETIME;
    DECLARE session_type VARCHAR(50);
    DECLARE member_first_name VARCHAR(100);
    DECLARE member_last_name VARCHAR(100);
    DECLARE team_role VARCHAR(50);
    DECLARE team_name VARCHAR(100);
    DECLARE member_ID INT;
    
    
    DECLARE body VARCHAR(100);
    DECLARE email_subject VARCHAR(500);
    
    
	DECLARE cur1 CURSOR FOR (
    SELECT t.head_coach_id AS HeadCoachID, f.first_name AS HeadCoachFN, f.last_name AS HeadCoachLN, f.email_address AS HeadCoachEA, l.location_name AS LocationName, s.address AS Address, s.session_time AS SessionTime, s.session_type AS SessionType, cm.first_name AS ClubMemberFirstName, cm.last_name AS ClubMemberLastName, "Goalkeeper" AS TeamRole, t.team_name, cm.club_member_id FROM teams t
    INNER JOIN sessions s ON s.team_1_id = t.team_id OR s.team_2_id = t.team_id
    INNER JOIN family_members f ON f.SSN = t.head_coach_id
    INNER JOIN locations l ON l.location_id = t.location_id
    INNER JOIN goalkeepers g ON g.team_id = t.team_id
    INNER JOIN club_members cm ON cm.club_member_id = g.goalkeeper_id
    WHERE (s.session_time >= CURRENT_DATE() AND s.session_time <= DATE_ADD(CURRENT_DATE(), INTERVAL 1 WEEK))
    UNION
    SELECT t.head_coach_id, f.first_name, f.last_name, f.email_address, l.location_name, s.address, s.session_time, s.session_type, cm.first_name, cm.last_name, "Defender" AS TeamRole, t.team_name, cm.club_member_id FROM teams t
    INNER JOIN sessions s ON s.team_1_id = t.team_id OR s.team_2_id = t.team_id
    INNER JOIN family_members f ON f.SSN = t.head_coach_id
    INNER JOIN locations l ON l.location_id = t.location_id
    INNER JOIN defenders d ON d.team_id = t.team_id
    INNER JOIN club_members cm ON cm.club_member_id = d.defender_id
    WHERE (s.session_time >= CURRENT_DATE() AND s.session_time <= DATE_ADD(CURRENT_DATE(), INTERVAL 1 WEEK))
    UNION
    SELECT t.head_coach_id, f.first_name, f.last_name, f.email_address, l.location_name, s.address, s.session_time, s.session_type, cm.first_name, cm.last_name, "Midfielder" AS TeamRole, t.team_name, cm.club_member_id FROM teams t
    INNER JOIN sessions s ON s.team_1_id = t.team_id OR s.team_2_id = t.team_id
    INNER JOIN family_members f ON f.SSN = t.head_coach_id
    INNER JOIN locations l ON l.location_id = t.location_id
    INNER JOIN midfielders m ON m.team_id = t.team_id
    INNER JOIN club_members cm ON cm.club_member_id = m.midfielder_id
    WHERE (s.session_time >= CURRENT_DATE() AND s.session_time <= DATE_ADD(CURRENT_DATE(), INTERVAL 1 WEEK))
    UNION
    SELECT t.head_coach_id, f.first_name, f.last_name, f.email_address, l.location_name, s.address, s.session_time, s.session_type, cm.first_name, cm.last_name, "Forward" AS TeamRole, t.team_name, cm.club_member_id FROM teams t
    INNER JOIN sessions s ON s.team_1_id = t.team_id OR s.team_2_id = t.team_id
    INNER JOIN family_members f ON f.SSN = t.head_coach_id
    INNER JOIN locations l ON l.location_id = t.location_id
    INNER JOIN forwards fw ON fw.team_id = t.team_id
    INNER JOIN club_members cm ON cm.club_member_id = fw.forward_id
    WHERE (s.session_time >= CURRENT_DATE() AND s.session_time <= DATE_ADD(CURRENT_DATE(), INTERVAL 1 WEEK))
    ORDER BY SessionTime);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	
    
    OPEN cur1;
    read_loop: LOOP
		FETCH cur1 INTO head_coach_ID, head_coach_first_name, head_coach_last_name, head_coach_email, location_name, location_address, session_time, session_type, member_first_name, member_last_name, team_role, team_name, member_id;
        IF done THEN
			LEAVE read_loop;
		END IF;
        SET email_subject = CONCAT(team_name, " ", session_time, " ", session_type);
        SET body = SUBSTRING(CONCAT("Member: ", member_first_name, " ", member_last_name, " ", team_role, " ", 
        "Head Coach: ", head_coach_first_name, " ", head_coach_last_name, " ", head_coach_email, " ", session_type, " at: ", location_address), 1, 100);
        
        INSERT INTO email_logs VALUES(CURRENT_DATE(), location_name, member_id, email_subject, body);
        
	END LOOP;
    CLOSE cur1;
END //

CALL populate_email//

