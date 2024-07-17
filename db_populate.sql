USE hoc353_1;

-- Locations table
INSERT INTO locations (location_name, address, city, province, postal_code, phone_number, web_address, location_type, capacity) VALUES
    ('Curacao', '6855 Little Port', 'South Miles', 'Minnesota', '083712', '+1 1338695823', 'https://tremendous-hammer.name', 'Head', 5),
    ('United Arab Emirates', '382 Bosco Gateway', 'Elgin', 'Maine', '256858', '+1 9604387366', 'https://mammoth-blind.net', 'Branch', 3),
    ('Tokelau', '6993 Robert Crescent', 'Fort Billy', 'Louisiana', '738514', '+1 5941486622', 'https://traumatic-wasp.net', 'Branch', 3),
    ('Cote d\'Ivoire', '83368 Hayes Forest', 'Arnefurt', 'Connecticut', '025527', '+1 3505955437', 'https://active-zoo.org/', 'Branch', 3),
    ('Maldives', '953 Antonetta Squares', 'South Adelle', 'Kentucky', '060130', '+1 6531001279', 'https://buzzing-girlfriend.net/', 'Branch', 5),
    ('Portugal', '2540 Ewell Rapids', 'Montgomery', 'Michigan', '091129', '+1 6225370876', 'https://colorless-arrow.name', 'Branch', 3),
    ('Mongolia', '80138 Jannie Ways', 'West Valley City', 'Virginia', '356999', '+1 3806299137', 'https://improbable-collar.biz/', 'Branch', 4),
    ('Ecuador', '9917 Quigley Brooks', 'Littelmouth', 'Florida', '254187', '+1 6010564641', 'https://illiterate-tail.name', 'Branch', 3),
    ('Morocco', '6219 Moises Flats', 'Franeckitown', 'Massachusetts', '881526', '+1 6587904717', 'https://disastrous-pick.net/', 'Branch', 3),
    ('Montenegro', '273 Goodwin Club', 'North Juston', 'Georgia', '242634', '+1 5054393579', 'https://admired-itinerary.org/', 'Branch', 4);

-- Club members table
INSERT INTO club_members (first_name, last_name, birthdate, SSN, medicare, phone_number, address, city, province, postal_code) VALUES
    ('Marta', 'Fay', '2024-07-15', '238099655', '615728201', '+1 7053077934', '12608 Reilly Streets', 'Aniyahtown', 'Maryland', '891140'),
    ('Casey', 'Schmidt', '2024-07-15', '584720710', '817216211', '+1 9527077744', '2322 Antwan Ramp', 'North Kiarrafield', 'Kentucky', '932457'),
    ('Megan', 'Lesch', '2024-07-15', '289762538', '108973728', '+1 6361949947', '49332 Breitenberg Forest', 'Satterfieldport', 'Louisiana', '232256'),
    ('Moses', 'Hilpert', '2024-07-15', '695576126', '825837302', '+1 4852409455', '2008 Spinka Rue', 'Schinnerfort', 'Georgia', '052055'),
    ('Sara', 'Mills', '2024-07-15', '286345582', '155370333', '+1 5767013602', '81985 Heller Avenue', 'West Alexanderview', 'New Hampshire', '639632'),
    ('Harry', 'Sanford', '2024-07-15', '763103281', '670872637', '+1 7738961236', '51823 Hane Harbor', 'Donnellyside', 'Oregon', '284967'),
    ('Marianne', 'Rosenbaum', '2024-07-15', '403023999', '147563065', '+1 7459836994', '4916 Watsica Mews', 'South Nona', 'Mississippi', '088012'),
    ('Manuel', 'Armstrong', '2024-07-15', '821708856', '933440329', '+1 4370295107', '185 Jonathan Meadows', 'Catonsville', 'Kansas', '346459'),
    ('Alicia', 'O\'Connell', '2024-07-15', '268910184', '598742068', '+1 8713404312', '49359 Gene Extensions', 'Miramar', 'North Carolina', '410135'),
    ('Ruth', 'Treutel', '2024-07-15', '507130047', '668407810', '+1 5780823315', '421 Delphia Mill', 'Denisboro', 'Hawaii', '324317');

-- Family members table
INSERT INTO family_members (first_name, last_name, birthdate, SSN, medicare, phone_number, address, city, province, postal_code, email_address) VALUES
    ('Faith', 'Lubowitz', '2024-07-15', '106201399', '477822368285', '+1 3331073230', 'G]>aof7sB%', 'Elmirafort', 'Wisconsin', '928492', 'Faith.Lubowitz@yahoo.com'),
    ('Joshua', 'Murphy', '2024-07-15', '985496281', '521438817445', '+1 0142635201', 'SgkX$?I>`q', 'Lake Leathaland', 'Connecticut', '722179', 'Joshua_Murphy@gmail.com'),
    ('Irving', 'Spinka', '2024-07-15', '528237260', '489934072030', '+1 1911558198', '*H_<GpQf}d', 'Bartellside', 'Pennsylvania', '837734', 'Irving.Spinka@gmail.com'),
    ('Sergio', 'Emmerich', '2024-07-15', '163472843', '327070516669', '+1 2634669949', '-W7DQzTu8&', 'Pedroland', 'Alabama', '408212', 'Sergio90@hotmail.com'),
    ('Manuel', 'Lowe', '2024-07-15', '599284139', '724039072321', '+1 5640432401', ')7KzRL<kLV', 'Port Bellechester', 'Oklahoma', '363067', 'Manuel.Lowe28@yahoo.com'),
    ('Ada', 'Romaguera', '2024-07-15', '923930728', '507070041331', '+1 4257607116', '-Nwotp82X/', 'Port Lorineton', 'Kentucky', '955215', 'Ada_Romaguera@hotmail.com'),
    ('Pedro', 'Jenkins', '2024-07-15', '448645522', '394605998542', '+1 5955062647', '?S]_%ne?Tm', 'West Trudieborough', 'Virginia', '883548', 'Pedro74@gmail.com'),
    ('Sophia', 'Barton', '2024-07-15', '808311919', '214528883015', '+1 4560950365', '!\'*<cY:.g)', 'Rathborough', 'Idaho', '820469', 'Sophia_Barton@hotmail.com'),
    ('Susie', 'Windler', '2024-07-15', '103354394', '672173108332', '+1 7171614682', '$S{ic0lvv&', 'Janickfield', 'Kentucky', '443654', 'Susie.Windler@yahoo.com'),
    ('Erin', 'Daugherty', '2024-07-15', '203851803', '456323792334', '+1 7675422816', 'C8!0S-r%bu', 'Jerdestad', 'California', '511306', 'Erin18@yahoo.com');

-- Personnels table
INSERT INTO personnels (first_name, last_name, birthdate, SSN, medicare, phone_number, address, city, province, postal_code, email_address, personnel_role, mandate) VALUES
    ('Myra', 'Hoeger', '1996-12-05', '350857000', '63407124', '+1 4169056562', '870 Garnet Junctions', 'Bauchville', 'ON', '693986', 'Myra91@gmail.com', 'Direct', 'Senior Usability Rep'),
    ('Sherman', 'Schimmel', '2001-05-06', '724579000', '51404101', '+1 6756027910', '5032 Eden Islands', 'Brockton', 'ON', '132319', 'Sherman.Schimmel@yahoo.com', 'Internal', 'Global Solutions Dev'),
    ('Lucy', 'Brakus', '2000-03-17', '142767000', '53635616', '+1 8309096224', '107 Emilio Land', 'South Kailee', 'ON', '138296', 'Lucy_Brakus39@hotmail.com', 'National', 'Principal Brand Con'),
    ('Aaron', 'Harvey', '2000-03-25', '320150000', '05056278', '+1 7185196680', '4085 Kuphal Greens', 'Esmeraldahaven', 'ON', '471310', 'Aaron.Harvey@hotmail.com', 'Customer', 'Senior Research Age'),
    ('Nadine', 'Gislason', '2005-07-23', '324203000', '53958091', '+1 7315826391', '95463 Jenkins Coves', 'West Eusebio', 'ON', '673745', 'Nadine.Gislason@yahoo.com', 'Corporate', 'Forward Marketing Ex'),
    ('Bonnie', 'Parisian', '2004-09-15', '944799000', '25021098', '+1 1753528388', '3986 Corkery Keys', 'Fort Abigale', 'ON', '918165', 'Bonnie_Parisian3@yahoo.com', 'Senior', 'Central Web Superv'),
    ('Nettie', 'Anderson', '2005-06-11', '264300000', '16954750', '+1 3708554543', '539 Cecil Course', 'New Titoton', 'ON', '901656', 'Nettie.Anderson@gmail.com', 'Global', 'Regional Account Te'),
    ('Everett', 'Ryan', '2006-05-19', '223830000', '13844426', '+1 3944889177', '11027 Bauch Mills', 'Gerardoboro', 'ON', '526589', 'Everett.Ryan@hotmail.com', 'Corporate', 'Chief Account Dev'),
    ('Karla', 'Mohr-Bode', '1998-08-10', '868725000', '15190479', '+1 7649246672', '99529 Yundt Pine', 'Moline', 'ON', '949866', 'Karla_Mohr-Bode@hotmail.com', 'Central', 'District Group Dir'),
    ('Dallas', 'Orn', '2000-12-07', '389433000', '88213237', '+1 6980761271', '28678 Izaiah Ways', 'Fort Emelia', 'ON', '230329', 'Dallas42@hotmail.com', 'National', 'Chief Optim Admin');

-- Personnels in locations table
INSERT INTO personnels_in_locations (personnel_SSN, location_id, start_date, end_date) VALUES
    ('350857000', 1, '2016-05-05', '2023-06-04'),
    ('724579000', 2, '2016-03-03', '2022-05-20'),
    ('142767000', 3, '2015-11-30', '2021-04-24'),
    ('320150000', 4, '2015-04-25', '2022-12-20'),
    ('324203000', 5, '2016-07-17', '2020-02-17'),
    ('944799000', 6, '2016-05-04', '2019-11-09'),
    ('264300000', 7, '2016-08-24', '2020-03-28'),
    ('223830000', 8, '2015-06-27', '2024-03-20'),
    ('868725000', 9, '2016-01-12', '2023-10-24'),
    ('389433000', 10, '2015-10-19', '2020-01-29');

-- Family enrolled in locations table
INSERT INTO family_enrolled_in_locations (family_SSN, location_id, start_date, end_date) VALUES
    ('106201399', 1, '2015-05-24', '2021-12-24'),
    ('985496281', 2, '2015-04-29', '2019-05-07'),
    ('528237260', 3, '2015-05-04', '2017-01-03'),
    ('163472843', 4, '2015-08-27', '2020-08-01'),
    ('599284139', 5, '2015-09-05', '2016-02-13'),
    ('923930728', 6, '2015-12-14', '2019-12-19'),
    ('448645522', 7, '2015-07-16', '2016-10-07'),
    ('808311919', 8, '2015-06-13', '2022-05-28'),
    ('103354394', 9, '2015-08-11', '2024-01-16'),
    ('203851803', 10, '2015-06-07', '2018-12-21');

-- Family enrolled members table
INSERT INTO family_enrolled_members (family_SSN, club_member_id, start_date, end_date, relation) VALUES
    ('106201399', 1, '2015-10-02', '2017-08-05', 'Spouse'),
    ('985496281', 2, '2015-08-01', '2018-03-31', 'Child'),
    ('528237260', 3, '2015-06-03', '2016-03-16', 'Parent'),
    ('163472843', 4, '2015-10-31', '2023-04-12', 'Sibling'),
    ('599284139', 5, '2015-12-15', '2020-08-16', 'Spouse'),
    ('923930728', 6, '2015-01-07', '2024-05-07', 'Child'),
    ('448645522', 7, '2015-04-04', '2024-01-22', 'Parent'),
    ('808311919', 8, '2015-02-09', '2018-06-19', 'Sibling'),
    ('103354394', 9, '2015-06-15', '2022-01-31', 'Spouse'),
    ('203851803', 10, '2015-12-20', '2023-11-15', 'Child');

-- Club member enrolled in locations table
INSERT INTO club_member_enrolled_in_locations (club_member_id, location_id, start_date, end_date) VALUES
	  (1, 1, '2015-04-09', '2021-01-26'),
    (2, 1, '2015-06-16', '2017-11-23'),
    (3, 2, '2015-03-08', '2023-02-03'),
    (4, 2, '2015-06-20', '2020-04-23'),
    (5, 3, '2015-05-08', '2023-03-27'),
    (6, 3, '2015-02-01', '2022-12-03'),
    (7, 4, '2015-12-16', '2018-04-20'),
    (8, 4, '2015-03-26', '2022-11-14'),
    (9, 4, '2015-10-03', '2018-05-11'),
    (10, 5, '2015-11-16', '2016-08-06');
