DELIMITER //
CREATE PROCEDURE populate_email()
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    DECLARE head_coach CHAR(9);
    DECLARE head_coach_first_name VARCHAR(20);
    DECLARE head_coach_last_name VARCHAR(20);
    DECLARE location_name VARCHAR(50);
    DECLARE body VARCHAR(100);
	DECLARE cur1 CURSOR FOR (SELECT DISTINCT t.head_coach_id, f.first_name, f.last_name, l.location_name FROM teams t
    INNER JOIN sessions s ON s.team_1_id = t.team_id OR s.team_2_id = t.team_id
    INNER JOIN family_members f ON f.SSN = t.head_coach_id
    INNER JOIN locations l ON l.location_id = t.location_id
    WHERE (s.session_time >= CURRENT_DATE() AND s.session_time <= DATE_ADD(CURRENT_DATE(), INTERVAL 1 WEEK))
    );
    
    -- DECLARE cur2 CURSOR FOR (SELECT 
	
    read_loop: LOOP
		FETCH cur1 INTO head_coach, head_coach_first_name, head_coach_last_name, location_name;
        IF done THEN
			LEAVE read_loop;
		END IF;
        
	END LOOP;
END //

SELECT * FROM 