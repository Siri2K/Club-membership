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
