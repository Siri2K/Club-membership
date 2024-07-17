USE hoc353_1;

-- Answer to Question i)
SELECT 
    cl.location_id, 
    l.location_name,
    l.address,
    l.city,
    l.province,
    l.postal_code,
    l.phone_number,
    l.web_address,
    l.location_type,
    l.capacity,
    COUNT(cl.club_member_id) AS member_count
FROM 
    club_member_enrolled_in_locations cl
JOIN 
    locations l ON cl.location_id = l.location_id
GROUP BY 
    cl.location_id, l.location_name
ORDER BY province, city;