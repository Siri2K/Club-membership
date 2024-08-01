-- To check club member age is in allowable range
DELIMITER //
CREATE TRIGGER check_club_member_age
BEFORE INSERT ON club_members
FOR EACH ROW
BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, NEW.birthdate, CURDATE());

    IF age < 4 OR age > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Club members must be between 4 and 10 years old at the time of registration.';
    END IF;
END //
DELIMITER ;

-- Checking for ineligible assignment to two matches within 3 hours on the same day
DELIMITER //
CREATE TRIGGER check_team_formation_conflict
BEFORE INSERT ON sessions
FOR EACH ROW
BEGIN
    DECLARE conflict_count INT;
    SELECT COUNT(*) INTO conflict_count
    FROM sessions s
    WHERE (s.team_1_id = NEW.team_1_id OR s.team_2_id = NEW.team_1_id OR
           s.team_1_id = NEW.team_2_id OR s.team_2_id = NEW.team_2_id)
    AND DATE(s.session_time) = DATE(NEW.session_time)
    AND ABS(TIMESTAMPDIFF(HOUR, s.session_time, NEW.session_time)) < 3;
    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A player cannot be assigned to two team formations within 3 hours on the same day.';
    END IF;
END //
DELIMITER ;

-- Trigger to make sure no personnel/employee is assigned to multiple locations at the same time
DELIMITER //
CREATE TRIGGER check_personnel_location_assignment
BEFORE INSERT ON personnels_in_locations
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;
    SELECT COUNT(*) INTO overlap_count
    FROM personnels_in_locations
    WHERE personnel_SSN = NEW.personnel_SSN
    AND ((NEW.start_date BETWEEN start_date AND IFNULL(end_date, '9999-12-31'))
         OR (IFNULL(NEW.end_date, '9999-12-31') BETWEEN start_date AND IFNULL(end_date, '9999-12-31'))
         OR (start_date BETWEEN NEW.start_date AND IFNULL(NEW.end_date, '9999-12-31')));
    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Personnel cannot be assigned to multiple locations at the same time.';
    END IF;
END //
DELIMITER ;

-- Trigger to make sure no club_member is assigned to multiple locations at the same time
DELIMITER //
CREATE TRIGGER check_club_member_location_assignment
BEFORE INSERT ON club_member_enrolled_in_locations
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;

    -- Check for overlapping enrollments
    SELECT COUNT(*) INTO overlap_count
    FROM club_member_enrolled_in_locations
    WHERE club_member_id = NEW.club_member_id
    AND ((NEW.start_date BETWEEN start_date AND IFNULL(end_date, '9999-12-31'))
         OR (IFNULL(NEW.end_date, '9999-12-31') BETWEEN start_date AND IFNULL(end_date, '9999-12-31'))
         OR (start_date BETWEEN NEW.start_date AND IFNULL(NEW.end_date, '9999-12-31')));

    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Club member cannot be enrolled in multiple locations at the same time.';
    END IF;
END //
DELIMITER ;


-- Trigger to make sure no family member is assigned to multiple locations at the same time
DELIMITER //
CREATE TRIGGER check_family_member_location_assignment
BEFORE INSERT ON family_enrolled_in_locations
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;

    -- Check for overlapping enrollments
    SELECT COUNT(*) INTO overlap_count
    FROM family_enrolled_in_locations
    WHERE family_SSN = NEW.family_SSN
    AND ((NEW.start_date BETWEEN start_date AND IFNULL(end_date, '9999-12-31'))
         OR (IFNULL(NEW.end_date, '9999-12-31') BETWEEN start_date AND IFNULL(end_date, '9999-12-31'))
         OR (start_date BETWEEN NEW.start_date AND IFNULL(NEW.end_date, '9999-12-31')));

    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Family member cannot be enrolled in multiple locations at the same time.';
    END IF;
END //
DELIMITER ;


-- Triggers to disallow members trying to join team of the opposite gender

DELIMITER //
CREATE TRIGGER check_member_gender
BEFORE INSERT ON goalkeepers
FOR EACH ROW
BEGIN
    DECLARE member_gender VARCHAR(20);
    DECLARE team_gender VARCHAR(20);

    -- Retrieve the gender of the club member
    SELECT gender INTO member_gender
    FROM club_members
    WHERE club_member_id = NEW.goalkeeper_id;

    -- Retrieve the gender of the team
    SELECT gender INTO team_gender
    FROM teams
    WHERE team_id = NEW.team_id;

    -- Check if the member's gender matches the team's gender
    IF member_gender <> team_gender THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gender mismatch: Club member and team genders must match.';
    END IF;
END;
//

CREATE TRIGGER check_member_gender_defender
BEFORE INSERT ON defenders
FOR EACH ROW
BEGIN
    DECLARE member_gender VARCHAR(20);
    DECLARE team_gender VARCHAR(20);

    -- Retrieve the gender of the club member
    SELECT gender INTO member_gender
    FROM club_members
    WHERE club_member_id = NEW.defender_id;

    -- Retrieve the gender of the team
    SELECT gender INTO team_gender
    FROM teams
    WHERE team_id = NEW.team_id;

    -- Check if the member's gender matches the team's gender
    IF member_gender <> team_gender THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gender mismatch: Club member and team genders must match.';
    END IF;
END;
//

CREATE TRIGGER check_member_gender_midfielder
BEFORE INSERT ON midfielders
FOR EACH ROW
BEGIN
    DECLARE member_gender VARCHAR(20);
    DECLARE team_gender VARCHAR(20);

    -- Retrieve the gender of the club member
    SELECT gender INTO member_gender
    FROM club_members
    WHERE club_member_id = NEW.midfielder_id;

    -- Retrieve the gender of the team
    SELECT gender INTO team_gender
    FROM teams
    WHERE team_id = NEW.team_id;

    -- Check if the member's gender matches the team's gender
    IF member_gender <> team_gender THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gender mismatch: Club member and team genders must match.';
    END IF;
END;
//

CREATE TRIGGER check_member_gender_forward
BEFORE INSERT ON forwards
FOR EACH ROW
BEGIN
    DECLARE member_gender VARCHAR(20);
    DECLARE team_gender VARCHAR(20);

    -- Retrieve the gender of the club member
    SELECT gender INTO member_gender
    FROM club_members
    WHERE club_member_id = NEW.forward_id;

    -- Retrieve the gender of the team
    SELECT gender INTO team_gender
    FROM teams
    WHERE team_id = NEW.team_id;

    -- Check if the member's gender matches the team's gender
    IF member_gender <> team_gender THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gender mismatch: Club member and team genders must match.';
    END IF;
END;
//
DELIMITER ;
