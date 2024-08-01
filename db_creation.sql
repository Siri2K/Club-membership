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
    -- CONSTRAINT CHK_Member_Age CHECK (birthdate >= (date_add(CURRENT_DATE(), INTERVAL -4 YEAR)) AND birthdate <= (date_add(CURRENT_DATE(), INTERVAL -10 YEAR)))
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
    location_id INT,
    team_name VARCHAR(100),
    head_coach_id INT,
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
    receiver VARCHAR(100),
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
    WHERE p.personnel_role = "General Manager" AND l.location_id = NEW.location_id ) > 0 AND (SELECT COUNT(*) FROM personnels p WHERE p.personnel_role = "General Manager" AND p.SSN = NEW.personnel_SSN) > 0 THEN
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
/*
-- Checking that each club member is between 4 and 10 at registration
CREATE TRIGGER check_club_member_eligibility BEFORE INSERT ON club_member_enrolled_in_locations
FOR EACH ROW
BEGIN
	IF (SELECT COUNT(*) FROM club_members c
    WHERE c.club_member_id = NEW.club_member_id
    AND (c.birthdate >= (date_add(CURRENT_DATE(), INTERVAL -10 YEAR)) OR c.birthdate <= (date_add(CURRENT_DATE(), INTERVAL -4 YEAR)))) > 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ERROR! Club member is not of age to register!';
	END IF;
END;
$$


CREATE TABLE club_member_enrolled_in_locations(
    club_member_id INT,
    location_id INT,
    start_date DATE,
    end_date DATE,
    
    PRIMARY KEY(club_member_id, location_id, start_date),
    
    FOREIGN KEY(club_member_id) REFERENCES club_members(club_member_id),
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);
*/