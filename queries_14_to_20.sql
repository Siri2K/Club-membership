USE hoc353_1;

-- Answer to Question 15)
-- Note: Given Location is 1 (Can change this)
SELECT fm.SSN AS membership_number, fm.first_name, fm.last_name, CURDATE() - fm.birthdate as age, fm.phone_number, fm.email_address, l.location_name
FROM family_enrolled_in_locations fel
JOIN family_enrolled_members fem ON fel.family_ssn = fem.family_ssn -- to get club members associated with family_member
JOIN club_member_enrolled_in_locations cmil ON cmil.club_member_id = fem.club_member_id -- to get location of club_members
JOIN family_members fm ON fm.SSN = fem.family_SSN -- to get family_member info
JOIN teams t ON t.head_coach_id = fm.SSN -- to scope for head coaches
JOIN locations l ON l.location_id = fel.location_id
WHERE fel.location_id = 1 -- Change given location by changing this parameter
	AND fem.end_date is null -- Active members
    AND cmil.location_id = 1  -- where club members are scoped to given location
    AND t.location_id = 1 -- where teams are scoped to given location
GROUP BY membership_number

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
		s.team_1_score != s.team_2_score  -- Exclude ties
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
ORDER BY location_name, club_member_id


-- Answer to Question 17)
SELECT personnels.first_name, personnels.last_name, pil.start_date AS start_date_as_president, pil.end_date AS end_date_as_president
FROM personnels
JOIN personnels_in_locations pil ON pil.personnel_SSN = personnels.SSN
JOIN locations l ON l.location_id = pil.location_id
WHERE personnel_role = 'General Manager' AND l.location_type = 'Head'
ORDER BY personnels.first_name, personnels.last_name, start_date_as_president

-- Answer to Question 18)
SELECT p.first_name, p.last_name, p.phone_number, p.email_address, l.location_name, p.personnel_role
FROM personnels p
JOIN personnels_in_locations pil ON pil.personnel_SSN = p.SSN
JOIN locations l ON l.location_id = pil.location_id
WHERE mandate = 'Volunteer' AND p.SSN NOT IN (SELECT SSN from family_members)
ORDER BY l.location_name, p.personnel_role, p.first_name, p.last_name

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
