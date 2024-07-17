USE hoc353_1;

-- Answer to Question i)
SELECT cl.location_id, l.location_name, l.address, l.city, l.province,
l.postal_code, l.phone_number, l.web_address, l.location_type, l.capacity,
COUNT(cl.club_member_id) AS member_count
FROM club_member_enrolled_in_locations cl
JOIN locations l ON cl.location_id = l.location_id
GROUP BY  cl.location_id, l.location_name
ORDER BY province, city;

-- Answer to Question ii)
-- Note: Given Location is 1 
SELECT fm.first_name, fm.last_name, COUNT(fem.club_member_id) AS related_active_members 
FROM family_enrolled_in_locations fel 
JOIN family_enrolled_members fem 
ON fel.family_ssn = fem.family_ssn
JOIN family_members fm
ON fm.SSN = fem.family_SSN
WHERE fel.location_id = 1 -- Change given location by changing this parameter
GROUP BY fem.family_SSN;

-- Answer to Question iii)
-- Note: Given Location is 1 
SELECT p.first_name, p.last_name, p.birthdate, p.ssn, p.medicare, p.phone_number, p.address,
p.city, p.province, p.postal_code, p.email_address, p.personnel_role, p.mandate
FROM personnels_in_locations pil 
JOIN personnels p ON p.ssn = pil.personnel_SSN
WHERE pil.location_id = 1; -- Change given location by changing this parameter

-- Answer to Question iv)
SELECT l.location_name, cm.club_member_id, cm.first_name, cm.last_name, 
TIMESTAMPDIFF(YEAR, cm.birthdate, CURDATE()) AS age, cm.city, cm.province
FROM club_members cm
JOIN club_member_enrolled_in_locations cmel
ON cmel.club_member_id = cm.club_member_id
JOIN locations l
ON l.location_id = cmel.location_id
ORDER BY l.location_name, age;

-- Answer to Question v)
-- Note: SSN are taken from the club members
SELECT cm.club_member_id, cm.first_name, cm.last_name, cm.birthdate, cm.SSN, cm.medicare, cm.phone_number, cm.address, cm.city, cm.province, cm.postal_code, fem.relation
FROM club_members cm
JOIN family_enrolled_members fem ON cm.club_member_id = fem.club_member_id
WHERE fem.family_SSN = 106201399;

-- Answer to Question vi)
SELECT l.location_name, l.province, l.city, fel.start_date, fel.end_date
FROM locations l
JOIN family_enrolled_in_locations fel ON l.location_id = fel.location_id
WHERE fel.family_SSN = 106201399
ORDER BY fel.start_date ASC;

-- Answer to Question vii)
SELECT fm.first_name, fm.last_name, fm.phone_number
FROM family_members fm
JOIN club_members cm ON fm.SSN = cm.SSN
JOIN family_enrolled_members fem ON cm.club_member_id = fem.club_member_id
JOIN personnels_in_locations pil ON fm.SSN = pil.personnel_SSN
WHERE pil.location_id = 1 AND pil.end_date IS NULL; -- Change given location by changing this parameter

-- Answer to Question viii)
SELECT cm.club_member_id, loc1.location_name AS first_location_name, loc2.location_name AS second_location_name, cel1.start_date AS first_location_start_date, cel2.start_date AS second_location_start_date
FROM club_members cm
JOIN club_member_enrolled_in_locations cel1 ON cm.club_member_id = cel1.club_member_id
JOIN club_member_enrolled_in_locations cel2 ON cm.club_member_id = cel2.club_member_id
JOIN locations loc1 ON cel1.location_id = loc1.location_id
JOIN locations loc2 ON cel2.location_id = loc2.location_id
WHERE cel1.location_id <> cel2.location_id AND cel1.end_date IS NULL AND cel2.end_date IS NULL
ORDER BY cm.first_name ASC, cm.last_name ASC, cel1.start_date ASC;
