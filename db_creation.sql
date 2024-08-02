USE hoc353_1;
-- use clubs_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS club_members;
DROP TABLE IF EXISTS family_members;
DROP TABLE IF EXISTS personnels;
DROP TABLE IF EXISTS personnels_in_locations;
DROP TABLE IF EXISTS family_enrolled_in_locations;
DROP TABLE IF EXISTS family_enrolled_members;
DROP TABLE IF EXISTS club_member_enrolled_in_locations;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS teams;
DROP TABLE IF EXISTS goalkeepers;
DROP TABLE IF EXISTS forwards;
DROP TABLE IF EXISTS defenders;
DROP TABLE IF EXISTS midfielders;
DROP TABLE IF EXISTS email_logs;
DROP TABLE IF EXISTS secondary_family_members;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE locations (
	location_id INT NOT NULL auto_increment,
	location_name VARCHAR(50) NOT NULL,
    address VARCHAR(40),
    city VARCHAR(20),
    province VARCHAR(20),
    postal_code VARCHAR(20),
    phone_number VARCHAR(13), -- Can use extra digits for country code
    web_address VARCHAR(75),
    location_type VARCHAR(50) CHECK (location_type IN ("Head", "Branch")),
    capacity INT(9),
    
    PRIMARY KEY(location_id)
);

CREATE TABLE club_members (
	club_member_id INT NOT NULL auto_increment,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birthdate DATE,
    SSN CHAR(9) NOT NULL UNIQUE,
	medicare CHAR(12) UNIQUE,
    phone_number VARCHAR(13),
    address VARCHAR(40),
    city VARCHAR(20),
    province VARCHAR(20),
    postal_code CHAR(6),
    gender ENUM("Male", "Female"),
    
    PRIMARY KEY(club_member_id)
);

CREATE TABLE family_members (
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birthdate DATE,
    SSN CHAR(9) NOT NULL UNIQUE,
	medicare CHAR(12) UNIQUE,
    phone_number VARCHAR(13),
    address VARCHAR(40),
    city VARCHAR(20),
    province VARCHAR(20),
    postal_code CHAR(6),
    email_address VARCHAR(40),
    
    PRIMARY KEY(SSN)
);

CREATE TABLE personnels (
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birthdate DATE,
    SSN CHAR(9) NOT NULL UNIQUE,
	medicare CHAR(12) UNIQUE,
    phone_number VARCHAR(13),
    address VARCHAR(40),
    city VARCHAR(20),
    province VARCHAR(20),
    postal_code CHAR(6),
    email_address VARCHAR(40),
    personnel_role ENUM ("General Manager", "Trainer", "Administrator", "Other", "Intern"),
    mandate VARCHAR(20),
    PRIMARY KEY(SSN)
);

CREATE TABLE personnels_in_locations(
	personnel_SSN CHAR(9),
    location_id INT,
    start_date DATE,
    end_date DATE,
    
    PRIMARY KEY(personnel_SSN, location_id, start_date),
    
    FOREIGN KEY(personnel_SSN) REFERENCES personnels(SSN),
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

CREATE TABLE family_enrolled_in_locations(
	family_SSN CHAR(9),
    location_id INT,
    start_date DATE,
    end_date DATE,
    
    PRIMARY KEY(family_SSN, location_id, start_date),
    
    FOREIGN KEY(family_SSN) REFERENCES family_members(SSN),
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

CREATE TABLE family_enrolled_members(
	family_SSN CHAR(9),
    club_member_id INT,
    start_date DATE,
    end_date DATE,
    relation VARCHAR(20),
    
    PRIMARY KEY(family_SSN, club_member_id, start_date),

    FOREIGN KEY(family_SSN) REFERENCES family_members(SSN),
    FOREIGN KEY(club_member_id) REFERENCES club_members(club_member_id)
);

CREATE TABLE club_member_enrolled_in_locations(
    club_member_id INT,
    location_id INT,
    start_date DATE,
    end_date DATE,
    
    PRIMARY KEY(club_member_id, location_id, start_date),
    
    FOREIGN KEY(club_member_id) REFERENCES club_members(club_member_id),
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

CREATE TABLE sessions(
    team_1_id INT,
    team_2_id INT,
    session_time DATETIME,
    address VARCHAR(100),
    team_1_score INT,
    team_2_score INT,
    session_type VARCHAR(50),
    PRIMARY KEY(team_1_id, team_2_id, session_time)
);

CREATE TABLE teams(
	team_id INT auto_increment,
    location_id INT NOT NULL,
    team_name VARCHAR(100),
    head_coach_id INT NOT NULL,
    gender VARCHAR(20),
    PRIMARY KEY(team_id)
);

CREATE TABLE goalkeepers(
	team_id INT,
    goalkeeper_id INT,
    PRIMARY KEY(team_id, goalkeeper_id),
    FOREIGN KEY(team_id) REFERENCES teams(team_id),
    FOREIGN KEY(goalkeeper_id) REFERENCES club_members(club_member_id)
);

CREATE TABLE defenders(
	team_id INT,
    defender_id INT,
    PRIMARY KEY(team_id, defender_id),
    FOREIGN KEY(team_id) REFERENCES teams(team_id),
    FOREIGN KEY(defender_id) REFERENCES club_members(club_member_id)
);

CREATE TABLE midfielders(
	team_id INT,
    midfielder_id INT,
    PRIMARY KEY(team_id, midfielder_id),
    FOREIGN KEY(team_id) REFERENCES teams(team_id),
    FOREIGN KEY(midfielder_id) REFERENCES club_members(club_member_id)
);

CREATE TABLE forwards(
	team_id INT,
    forward_id INT,
    PRIMARY KEY(team_id, forward_id),
    FOREIGN KEY(team_id) REFERENCES teams(team_id),
    FOREIGN KEY(forward_id) REFERENCES club_members(club_member_id)
);

CREATE TABLE email_logs(
	email_date DATE,
    sender VARCHAR(100),
    receiver_ID INT,
    email_subject VARCHAR(100),
    body VARCHAR(100)
);

CREATE TABLE secondary_family_members(
	family_SSN CHAR(9),
    club_member_id INT,
    relation VARCHAR(20),
    
    PRIMARY KEY(family_SSN, club_member_id),
    FOREIGN KEY(family_SSN) REFERENCES family_members(SSN),
    FOREIGN KEY(club_member_id) REFERENCES club_members(club_member_id)
);

-- Checking if there is only one head location
delimiter $$
CREATE TRIGGER check_location_head_unique BEFORE INSERT ON locations
FOR EACH ROW
BEGIN
	IF NEW.location_type = "Head" AND "Head" IN (SELECT location_type FROM locations) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ERROR! Cannot have 2 head branches';
	END IF;
END;
$$

-- Chcking if there is only one gm per location
CREATE TRIGGER check_one_general_manager_per_location BEFORE INSERT ON personnels_in_locations
FOR EACH ROW
BEGIN
	IF (SELECT p.SSN FROM personnels p
    INNER JOIN personnels_in_locations pl ON pl.personnel_SSN = p.SSN
    INNER JOIN locations l ON l.location_id = pl.location_id
    WHERE p.personnel_role = "General Manager" AND l.location_id = NEW.location_id AND pl.end_date IS NULL) > 0 AND (SELECT COUNT(*) FROM personnels p WHERE p.personnel_role = "General Manager" AND p.SSN = NEW.personnel_SSN) > 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ERROR! Cannot have 2 general managers at one branch!';
	END IF;
END;
$$

-- Checking that each personnel is working at a location at one time
CREATE TRIGGER check_location_per_personnel BEFORE INSERT ON personnels_in_locations
FOR EACH ROW
BEGIN
	IF (SELECT COUNT(*) FROM personnels_in_locations pl
    WHERE pl.personnel_SSN = NEW.personnel_SSN AND (pl.end_date IS NULL OR pl.end_date > NEW.start_date)) > 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ERROR! Cannot have a personnel working at 2 locations at the same time!';
	END IF;
END;
$$

-- Checking that each family member is associate with one location at one time
CREATE TRIGGER check_location_per_family BEFORE INSERT ON family_enrolled_in_locations
FOR EACH ROW
BEGIN
	IF (SELECT COUNT(*) FROM family_enrolled_in_locations fl
    WHERE fl.family_SSN = NEW.family_SSN AND (fl.end_date IS NULL OR fl.end_date > NEW.start_date)) > 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ERROR! Cannot have a family member registered at 2 locations at the same time!';
	END IF;
END;
$$

-- Checking that each club member is associate with one family member at one time
CREATE TRIGGER check_club_member_per_family BEFORE INSERT ON family_enrolled_members
FOR EACH ROW
BEGIN
	IF (SELECT COUNT(*) FROM family_enrolled_members fm
    WHERE fm.club_member_id = NEW.club_member_id AND (fm.end_date IS NULL OR fm.end_date > NEW.start_date)) > 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ERROR! Cannot have a club member registered with 2 family members at the same time!';
	END IF;
END;
$$

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

-- Checking to make sure each player is in location of team
-- Goalkeepers
DELIMITER //
CREATE TRIGGER check_goalkeepers_location
BEFORE INSERT ON goalkeepers
FOR EACH ROW
BEGIN
    IF (SELECT t.location_id FROM teams t 
    WHERE t.team_id = NEW.team_id) <> 
    (SELECT cl.location_id FROM club_member_enrolled_in_locations cl
    INNER JOIN club_members c ON c.club_member_id = cl.club_member_id 
    WHERE c.club_member_id = NEW.goalkeeper_id AND cl.end_date IS NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A player cannot be assigned to a team at a different location from where they are registered in.';
    END IF;
END //

-- Defenders
DELIMITER //
CREATE TRIGGER check_defenders_location
BEFORE INSERT ON defenders
FOR EACH ROW
BEGIN
    IF (SELECT t.location_id FROM teams t 
    WHERE t.team_id = NEW.team_id) <> 
    (SELECT cl.location_id FROM club_member_enrolled_in_locations cl
    INNER JOIN club_members c ON c.club_member_id = cl.club_member_id 
    WHERE c.club_member_id = NEW.defender_id AND cl.end_date IS NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A player cannot be assigned to a team at a different location from where they are registered in.';
    END IF;
END //

-- Midfielders
DELIMITER //
CREATE TRIGGER check_midfielders_location
BEFORE INSERT ON midfielders
FOR EACH ROW
BEGIN
    IF (SELECT t.location_id FROM teams t 
    WHERE t.team_id = NEW.team_id) <> 
    (SELECT cl.location_id FROM club_member_enrolled_in_locations cl
    INNER JOIN club_members c ON c.club_member_id = cl.club_member_id 
    WHERE c.club_member_id = NEW.midfielder_id AND cl.end_date IS NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A player cannot be assigned to a team at a different location from where they are registered in.';
    END IF;
END //

-- Forwards
DELIMITER //
CREATE TRIGGER check_forwards_location
BEFORE INSERT ON forwards
FOR EACH ROW
BEGIN
    IF (SELECT t.location_id FROM teams t 
    WHERE t.team_id = NEW.team_id) <> 
    (SELECT cl.location_id FROM club_member_enrolled_in_locations cl
    INNER JOIN club_members c ON c.club_member_id = cl.club_member_id 
    WHERE c.club_member_id = NEW.forward_id AND cl.end_date IS NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A player cannot be assigned to a team at a different location from where they are registered in.';
    END IF;
END //

-- Trigger to check team has at least one goalkeeper
DELIMITER //
CREATE TRIGGER check_goalie_count_teams
BEFORE INSERT ON sessions
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM goalkeepers g 
    WHERE g.team_id = NEW.team_1_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Team 1 in session must have at least 1 goalkeeper!';
    END IF;
    
    IF (SELECT COUNT(*) FROM goalkeepers g 
    WHERE g.team_id = NEW.team_2_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Team 2 in session must have at least 1 goalkeeper!';
    END IF;
    
END //

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


/*
CREATE TABLE goalkeepers(
	team_id INT,
    goalkeeper_id INT,
    PRIMARY KEY(team_id, goalkeeper_id),
    FOREIGN KEY(team_id) REFERENCES teams(team_id),
    FOREIGN KEY(goalkeeper_id) REFERENCES club_members(club_member_id)
);
*/