USE hoc353_1;

INSERT INTO personnels (first_name,last_name,birthdate,SSN,medicare,phone_number,address, city,province,postal_code, email_address,personnel_role,mandate) VALUES 
    ('Myra', 'Hoeger', Thu Dec 05 1996 09:02:36 GMT+0100 (GMT+01:00), '350-857', '63407124', '+1 (416) 905-6562', '870 Garnet Junctions', 'Bauchville', '693-986', 'Myra91@gmail.com', 'Direct', 'Senior Usability Representative'),
    ('Sherman', 'Schimmel', Sun May 06 2001 02:03:35 GMT+0200 (GMT+02:00), '724-579', '51404101', '+1 (675) 602-7910', '5032 Eden Islands', 'Brockton', '132-319', 'Sherman.Schimmel@yahoo.com', 'Internal', 'Global Solutions Developer'),
    ('Lucy', 'Brakus', Fri Mar 17 2000 07:20:37 GMT+0100 (GMT+01:00), '142-767', '53635616', '+1 (830) 909-6224', '107 Emilio Land', 'South Kailee', '138-296', 'Lucy_Brakus39@hotmail.com', 'National', 'Principal Brand Consultant'),
    ('Aaron', 'Harvey', Sat Mar 25 2000 05:38:17 GMT+0100 (GMT+01:00), '320-150', '05056278', '+1 (718) 519-6680', '4085 Kuphal Greens', 'Esmeraldahaven', '471-310', 'Aaron.Harvey@hotmail.com', 'Customer', 'Senior Research Agent'),
    ('Nadine', 'Gislason', Sat Jul 23 2005 06:24:07 GMT+0200 (GMT+02:00), '324-203', '53958091', '+1 (731) 582-6391', '95463 Jenkins Coves', 'West Eusebio', '673-745', 'Nadine.Gislason@yahoo.com', 'Corporate', 'Forward Marketing Executive'),
    ('Bonnie', 'Parisian', Wed Sep 15 2004 15:51:00 GMT+0200 (GMT+02:00), '944-799', '25021098', '+1 (175) 352-8388', '3986 Corkery Keys', 'Fort Abigale', '918-165', 'Bonnie_Parisian3@yahoo.com', 'Senior', 'Central Web Supervisor'),
    ('Nettie', 'Anderson', Sat Jun 11 2005 13:21:46 GMT+0200 (GMT+02:00), '264-300', '16954750', '+1 (370) 855-4543', '539 Cecil Course', 'New Titoton', '901-656', 'Nettie.Anderson@gmail.com', 'Global', 'Regional Accountability Technician'),
    ('Everett', 'Ryan', Fri May 19 2006 09:15:34 GMT+0200 (GMT+02:00), '223-830', '13844426', '+1 (394) 488-9177', '11027 Bauch Mills', 'Gerardoboro', '526-589', 'Everett.Ryan@hotmail.com', 'Corporate', 'Chief Accountability Developer'),
    ('Karla', 'Mohr-Bode', Mon Aug 10 1998 03:06:21 GMT+0200 (GMT+02:00), '868-725', '15190479', '+1 (764) 924-6672', '99529 Yundt Pine', 'Moline', '949-866', 'Karla_Mohr-Bode@hotmail.com', 'Central', 'District Group Director'),
    ('Dallas', 'Orn', Thu Dec 07 2000 18:37:56 GMT+0100 (GMT+01:00), '389-433', '88213237', '+1 (698) 076-1271', '28678 Izaiah Ways', 'Fort Emelia', '230-329', 'Dallas42@hotmail.com', 'National', 'Chief Optimization Administrator');
    
INSERT INTO locations (location_name,address,city,province,postal_code,phone_number,web_address,is_head_office,capacity) VALUES 
	('Curacao', '6855 Little Port', 'South Miles', 'Minnesota', '083-712', '+1 (133) 869-5823', 'https://tremendous-hammer.name', false, 5),
    ('United Arab Emirates', '382 Bosco Gateway', 'Elgin', 'Maine', '256-858', '+1 (960) 438-7366', 'https://mammoth-blind.net', false, 0),
    ('Tokelau', '6993 Robert Crescent', 'Fort Billy', 'Louisiana', '738-514', '+1 (594) 148-6622', 'https://traumatic-wasp.net', false, -4),
    ('Cote d\'Ivoire', '83368 Hayes Forest', 'Arnefurt', 'Connecticut', '025-527', '+1 (350) 595-5437', 'https://active-zoo.org/', true, 2),
    ('Maldives', '953 Antonetta Squares', 'South Adelle', 'Kentucky', '060-130', '+1 (653) 100-1279', 'https://buzzing-girlfriend.net/', false, 5),
    ('Portugal', '2540 Ewell Rapids', 'Montgomery', 'Michigan', '091-129', '+1 (622) 537-0876', 'https://colorless-arrow.name', false, 3),
    ('Mongolia', '80138 Jannie Ways', 'West Valley City', 'Virginia', '356-999', '+1 (380) 629-9137', 'https://improbable-collar.biz/', false, 4),
    ('Ecuador', '9917 Quigley Brooks', 'Littelmouth', 'Florida', '254-187', '+1 (601) 056-4641', 'https://illiterate-tail.name', true, -3),
    ('Morocco', '6219 Moises Flats', 'Franeckitown', 'Massachusetts', '881-526', '+1 (658) 790-4717', 'https://disastrous-pick.net/', false, -4),
    ('Montenegro', '273 Goodwin Club', 'North Juston', 'Georgia', '242-634', '+1 (505) 439-3579', 'https://admired-itinerary.org/', true, 2);
    
INSERT INTO club_members (first_name,last_name,birthdate,SSN,medicare,phone_number, address,city,province,postal_code) VALUES 
	('Marta', 'Fay', '2024-07-15', '238-099-655', '615728201', '+1 (705) 307-7934', '12608 Reilly Streets', 'Aniyahtown', 'Maryland', '891-140'),
    ('Casey', 'Schmidt', '2024-07-15', '584-720-710', '817216211', '+1 (952) 707-7744', '2322 Antwan Ramp', 'North Kiarrafield', 'Kentucky', '932-457'),
    ('Megan', 'Lesch', '2024-07-15', '289-762-538', '108973728', '+1 (636) 194-9947', '49332 Breitenberg Forest', 'Satterfieldport', 'Louisiana', '232-256'),
    ('Moses', 'Hilpert', '2024-07-15', '695-576-126', '825837302', '+1 (485) 240-9455', '2008 Spinka Rue', 'Schinnerfort', 'Georgia', '052-055'),
    ('Sara', 'Mills', '2024-07-15', '286-345-582', '155370333', '+1 (576) 701-3602', '81985 Heller Avenue', 'West Alexanderview', 'New Hampshire', '639-632'),
    ('Harry', 'Sanford', '2024-07-15', '763-103-281', '670872637', '+1 (773) 896-1236', '51823 Hane Harbor', 'Donnellyside', 'Oregon', '284-967'),
    ('Marianne', 'Rosenbaum', '2024-07-15', '403-023-999', '147563065', '+1 (745) 983-6994', '4916 Watsica Mews', 'South Nona', 'Mississippi', '088-012'),
    ('Manuel', 'Armstrong', '2024-07-15', '821-708-856', '933440329', '+1 (437) 029-5107', '185 Jonathan Meadows', 'Catonsville', 'Kansas', '346-459'),
    ('Alicia', 'O\'Connell', '2024-07-15', '268-910-184', '598742068', '+1 (871) 340-4312', '49359 Gene Extensions', 'Miramar', 'North Carolina', '410-135'),
    ('Ruth', 'Treutel', '2024-07-15', '507-130-047', '668407810', '+1 (578) 082-3315', '421 Delphia Mill', 'Denisboro', 'Hawaii', '324-317');
    
INSERT INTO family_members (first_name,last_name,birthdate,SSN,medicare,phone_number,address,city,province,postal_code,email_address) VALUES 
	('Faith', 'Lubowitz', 'Jul 15th 24', '106-201-399', '4778-2236-8285', '+1 (333) 107-3230', 'G]>aof7sB%', 'Elmirafort', 'Wisconsin', '928-492', 'Faith.Lubowitz@yahoo.com'),
    ('Joshua', 'Murphy', 'Jul 15th 24', '985-496-281', '5214-3881-7445', '+1 (014) 263-5201', 'SgkX$?I>`q', 'Lake Leathaland', 'Connecticut', '722-179', 'Joshua_Murphy@gmail.com'),
    ('Irving', 'Spinka', 'Jul 15th 24', '528-237-260', '4899-3407-2030', '+1 (191) 155-8198', '*H_<GpQf}d', 'Bartellside', 'Pennsylvania', '837-734', 'Irving.Spinka@gmail.com'),
    ('Sergio', 'Emmerich', 'Jul 15th 24', '163-472-843', '3270-7051-6669', '+1 (263) 466-9949', '-W7DQzTu8&', 'Pedroland', 'Alabama', '408-212', 'Sergio90@hotmail.com'),
    ('Manuel', 'Lowe', 'Jul 15th 24', '599-284-139', '7240-3907-2321', '+1 (564) 043-2401', ')7KzRL<kLV', 'Port Bellechester', 'Oklahoma', '363-067', 'Manuel.Lowe28@yahoo.com'),
    ('Ada', 'Romaguera', 'Jul 15th 24', '923-930-728', '5070-7004-1331', '+1 (425) 760-7116', '-Nwotp82X/', 'Port Lorineton', 'Kentucky', '955-215', 'Ada_Romaguera@hotmail.com'),
    ('Pedro', 'Jenkins', 'Jul 15th 24', '448-645-522', '3946-0599-8542', '+1 (595) 506-2647', '?S]_%ne?Tm', 'West Trudieborough', 'Virginia', '883-548', 'Pedro74@gmail.com'),
    ('Sophia', 'Barton', 'Jul 15th 24', '808-311-919', '2145-2888-3015', '+1 (456) 095-0365', '!\'*<cY:.g)', 'Rathborough', 'Idaho', '820-469', 'Sophia_Barton@hotmail.com'),
    ('Susie', 'Windler', 'Jul 15th 24', '103-354-394', '6721-7310-8332', '+1 (717) 161-4682', '$S{ic0lvv&', 'Janickfield', 'Kentucky', '443-654', 'Susie.Windler@yahoo.com'),
    ('Erin', 'Daugherty', 'Jul 15th 24', '203-851-803', '4563-2379-2334', '+1 (767) 542-2816', 'C8!0S-r%bu', 'Jerdestad', 'California', '511-306', 'Erin18@yahoo.com');
    