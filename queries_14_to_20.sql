USE hoc353_1;

-- Answer to Question 15)
-- Note: Given Location is 1 (Can change this)
SELECT fm.SSN AS membership_number, fm.first_name, fm.last_name, CURDATE() - fm.birthdate as age, fm.phone_number, fm.email_address, l.location_name
FROM family_enrolled_in_locations fel
JOIN family_enrolled_members fem ON fel.family_ssn = fem.family_ssn -- to get club members associated with family_member
JOIN club_member_enrolled_in_locations cmil ON cmil.club_member_id = fem.club_member_id -- to get location of club_members
JOIN club_members cm ON cm.club_member_id = cmil.club_member_id
JOIN family_members fm ON fm.SSN = fem.family_SSN -- to get family_member info
JOIN teams t ON t.head_coach_id = fm.SSN -- to scope for head coaches
JOIN locations l ON l.location_id = fel.location_id
WHERE fel.location_id = 1 -- Change given location by changing this parameter
	AND fem.end_date is null AND FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) >= 4 AND FLOOR(DATEDIFF(CURDATE(), cm.birthdate) / 365) <= 10-- Active members
    AND cmil.location_id = 1  -- where club members are scoped to given location
    AND t.location_id = 1 -- where teams are scoped to given location
GROUP BY membership_number;

-- Answer to Question 16)
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
	JOIN teams t ON ( -- To only include winning teams
			CASE
				WHEN s.team_1_score > s.team_2_score THEN s.team_1_id
				ELSE s.team_2_id
			END = t.team_id
		)
	WHERE
		s.team_1_score != s.team_2_score AND
        t.team_id NOT IN
        (SELECT
        CASE
            WHEN s.team_1_score < s.team_2_score THEN s.team_1_id
            ELSE s.team_2_id
        END AS losing_team_id
	FROM
		sessions s
	JOIN teams t ON ( -- To only include losing teams
			CASE
				WHEN s.team_1_score < s.team_2_score THEN s.team_1_id
				ELSE s.team_2_id
			END = t.team_id
		)
	WHERE
		s.team_1_score != s.team_2_score  -- Exclude ties)-- Exclude ties
))
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


-- Answer to Question 17)
SELECT personnels.first_name, personnels.last_name, pil.start_date AS start_date_as_president, pil.end_date AS end_date_as_president
FROM personnels
JOIN personnels_in_locations pil ON pil.personnel_SSN = personnels.SSN
JOIN locations l ON l.location_id = pil.location_id
WHERE personnel_role = 'General Manager' AND l.location_type = 'Head'
ORDER BY personnels.first_name, personnels.last_name, start_date_as_president;

-- Answer to Question 18)
SELECT p.first_name, p.last_name, p.phone_number, p.email_address, l.location_name, p.personnel_role
FROM personnels p
JOIN personnels_in_locations pil ON pil.personnel_SSN = p.SSN
JOIN locations l ON l.location_id = pil.location_id
WHERE mandate = 'Volunteer' AND p.SSN NOT IN (SELECT SSN from family_members)
ORDER BY l.location_name, p.personnel_role, p.first_name, p.last_name;

-- Answer to Question 19)
-- We employed triggers quite often in this application. The reason for this is that this application requires a lot of complex logic and constraints that cannot be handled by basic SQL code. Triggers are an extremely useful tool for implementing more advanced or complex constraints. The following triggers are used in this system are:
-- 1. check_club_member_age: This trigger checks if a club member that is about to be inserted is in the allowable age range (4-10) and if so stops the insertion
-- 2. check_team_formation_conflict: This trigger checks if a new training or game session will result in any two club members being assigned two matches within 3 hours on the same day (an illegal assignment). If this occurs, the insertion of the game session is stopped
-- 3. check_personnel_location_assignment: This trigger checks to see if a personnel of the club is being assigned to a second location in personnels_in_locations. If so, the insertion is stopped.
-- 4. check_club_member_location_assignment: This trigger checks to see if a club member is being assigned to a second location in club_member_enrolled_in_locations. If so, the insertion is stopped.
-- 5. check_family_member_location_assignment: This trigger checks to see if a club member is being assigned to a second location in family_member_enrolled_in_locations. If so, the insertion is stopped.
-- 6. Triggers to disallow insertion of club members on teams of the opposite gender:
--     - check_member_gender
--     - check_member_gender_defender
--     - check_member_gender_midfielder
--     - check_member_gender_forward


-- Answer to Question 20)
-- The following are queries that purposefully fail in order to demonstrate the integrity of the requirements.
-- Make sure to run the db_populate script first as this relies on the data there to check the integrity.

-- Checking that only one location can be the head location (a head location is already present):
INSERT INTO locations (location_name, address, city, province, postal_code, phone_number, web_address, location_type, capacity) VALUES
    ('Elite Soccer Minnesota', '6855 Little Port', 'South Miles', 'Minnesota', '083712', '+1 1338695823', 'https://tremendous-hammer.name', 'Head', 5);
    
-- There can only be one general manager per location:
INSERT INTO personnels_in_locations (personnel_SSN, location_id, start_date, end_date) VALUES
    ('223830000', 1, '2024-05-05', null);
    
-- Each personnel having a unique medicare # and SSN is ensure in the table definition
-- Having only one role at a time is ensured by the fact that the role field must be only one of General Manager, Administrator, trainer, other (by enum)

-- Showing that a personnel can only operate at one location at a time:
INSERT INTO personnels_in_locations (personnel_SSN, location_id, start_date, end_date) VALUES
    ('350857000', 2, '2024-05-05', null);
    
-- Showing family members can only be associated with one location at a time:
INSERT INTO family_enrolled_in_locations (family_SSN, location_id, start_date, end_date) VALUES
     ('106201399', 2, '2024-05-24', null);
	
-- Showing club members can only be associated with one primary family at a time
INSERT INTO family_enrolled_members (family_SSN, club_member_id, start_date, end_date, relation) VALUES
    ('163472843', 1, '2020-10-02', null, 'Mother');
    
-- Showing club members must between 4 and 10 years old at the time of registration
INSERT INTO club_members (first_name, last_name, birthdate, SSN, medicare, phone_number, address, city, province, gender, postal_code) VALUES
    ('Marta', 'Fay', '2010-07-15', '238099655', '615728201', '+1 7053077934', '12608 Reilly Streets', 'Aniyahtown', 'Maryland', 'Male', '891140');
    
-- The constraint of each session needing 2 teams is ensured by the id's of both being in the primary key of the table

-- Showing that all players on a team must be associate with the same location:
-- (this is the same for the other positions as well)
INSERT INTO forwards (team_id, forward_id) VALUES
    (4, 7);
INSERT INTO midfielders (team_id, midfielder_id) VALUES
    (3, 6);
INSERT INTO defenders (team_id, defender_id) VALUES
    (4, 2);
INSERT INTO goalkeepers (team_id, goalkeeper_id) VALUES
	(3, 3);

-- Showing that each team must have at least one goalkeeper:
INSERT INTO sessions (team_1_id, team_2_id, session_time, address, team_1_score, team_2_score, session_type) VALUES
    (1, 6, '2024-09-02 18:00:00', '444 West', 5, 7, 'Game');

-- Shwoing that there must be at least a 3 hour difference between two formations for a member:
INSERT INTO sessions (team_1_id, team_2_id, session_time, address, team_1_score, team_2_score, session_type) VALUES
    (1, 3, '2024-08-02 19:00:00', '444 West', 5, 7, 'Game');
    
-- Showing gender must be the same for all members in a team:
INSERT INTO forwards (team_id, forward_id) VALUES
    (4, 9);