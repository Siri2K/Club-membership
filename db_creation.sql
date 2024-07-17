-- USE hoc353_1;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS club_members;
DROP TABLE IF EXISTS family_members;
DROP TABLE IF EXISTS personnels;
DROP TABLE IF EXISTS personnels_in_locations;
DROP TABLE IF EXISTS family_enrolled_in_locations;
DROP TABLE IF EXISTS family_enrolled_members;
DROP TABLE IF EXISTS club_member_enrolled_in_locations;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE locations (
	location_id INT NOT NULL auto_increment,
	location_name VARCHAR(20) NOT NULL,
    address VARCHAR(40),
    city VARCHAR(20),
    province VARCHAR(20),
    postal_code VARCHAR(20),
    phone_number VARCHAR(13), -- Can use extra digits for country code
    web_address VARCHAR(75),
    location_type VARCHAR(50),
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
    personnel_role VARCHAR(40),
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