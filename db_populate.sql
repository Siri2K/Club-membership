USE hoc353_1;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE locations;
TRUNCATE TABLE club_members;
TRUNCATE TABLE club_member_enrolled_in_locations;
TRUNCATE TABLE defenders;
TRUNCATE TABLE email_logs;
TRUNCATE TABLE family_enrolled_in_locations;
TRUNCATE TABLE family_enrolled_members;
TRUNCATE TABLE family_members;
TRUNCATE TABLE forwards;
TRUNCATE TABLE goalkeepers;
TRUNCATE TABLE midfielders;
TRUNCATE TABLE personnels;
TRUNCATE TABLE personnels_in_locations;
TRUNCATE TABLE secondary_family_members;
TRUNCATE TABLE sessions;
TRUNCATE TABLE teams;
SET FOREIGN_KEY_CHECKS = 1;

-- Locations table
INSERT INTO locations (location_name, address, city, province, postal_code, phone_number, web_address, location_type, capacity) VALUES
    ('Elite Soccer Minnesota', '6855 Little Port', 'South Miles', 'Minnesota', '083712', '+1 1338695823', 'https://tremendous-hammer.name', 'Head', 5),
    ('Elite Soccer Maine', '382 Bosco Gateway', 'Elgin', 'Maine', '256858', '+1 9604387366', 'https://mammoth-blind.net', 'Branch', 3),
    ('Soccer Stars Louisiana', '6993 Robert Crescent', 'Fort Billy', 'Louisiana', '738514', '+1 5941486622', 'https://traumatic-wasp.net', 'Branch', 3),
    ('Elite Soccer Conneticut', '83368 Hayes Forest', 'Arnefurt', 'Connecticut', '025527', '+1 3505955437', 'https://active-zoo.org/', 'Branch', 3),
    ('Soccer Giants Kentucky', '953 Antonetta Squares', 'South Adelle', 'Kentucky', '060130', '+1 6531001279', 'https://buzzing-girlfriend.net/', 'Branch', 5),
    ('Soccer Stars Michigan', '2540 Ewell Rapids', 'Montgomery', 'Michigan', '091129', '+1 6225370876', 'https://colorless-arrow.name', 'Branch', 3),
    ('Ultimate Soccer Virginia', '80138 Jannie Ways', 'West Valley City', 'Virginia', '356999', '+1 3806299137', 'https://improbable-collar.biz/', 'Branch', 4),
    ('Soccer Stars Florida', '9917 Quigley Brooks', 'Littelmouth', 'Florida', '254187', '+1 6010564641', 'https://illiterate-tail.name', 'Branch', 3),
    ('Soccer Giants', '6219 Moises Flats', 'Franeckitown', 'Massachusetts', '881526', '+1 6587904717', 'https://disastrous-pick.net/', 'Branch', 3),
    ('Soccer Stars Georgia', '273 Goodwin Club', 'North Juston', 'Georgia', '242634', '+1 5054393579', 'https://admired-itinerary.org/', 'Branch', 4);

-- Club members table
INSERT INTO club_members (first_name, last_name, birthdate, SSN, medicare, phone_number, address, city, province, gender, postal_code) VALUES
    ('Marta', 'Fay', '2018-07-15', '238099655', '615728201', '+1 7053077934', '12608 Reilly Streets', 'Aniyahtown', 'Maryland', 'Male', '891140'),
    ('Casey', 'Fay', '2019-07-15', '584720710', '817216211', '+1 9527077744', '12608 Reilly Streets', 'Aniyahtown', 'Maryland', 'Male', '891140'),
    ('Megan', 'Lesch', '2018-07-15', '289762538', '108973728', '+1 6361949947', '49332 Breitenberg Forest', 'Satterfieldport', 'Louisiana', 'Male', '232256'),  -- Added comma here
    ('Moses', 'Hilpert', '2017-07-12', '695576126', '825837302', '+1 4852409455', '2008 Spinka Rue', 'Schinnerfort', 'Georgia', 'Male', '052055'),
    ('Sara', 'Mills', '2016-07-10', '286345582', '155370333', '+1 5767013602', '81985 Heller Avenue', 'West Alexanderview', 'New Hampshire', 'Male', '639632'),
    ('Harry', 'Sanford', '2016-07-22', '763103281', '670872637', '+1 7738961236', '51823 Hane Harbor', 'Donnellyside', 'Oregon', 'Male', '284967'),
    ('Marianne', 'Rosenbaum', '2015-07-15', '403023999', '147563065', '+1 7459836994', '4916 Watsica Mews', 'South Nona', 'Mississippi', 'Male', '088012'),
    ('Manuel', 'Armstrong', '2017-07-15', '821708856', '933440329', '+1 4370295107', '185 Jonathan Meadows', 'Catonsville', 'Kansas', 'Male', '346459'),
    ('Alicia', 'O\'Connell', '2018-07-15', '268910184', '598742068', '+1 8713404312', '49359 Gene Extensions', 'Miramar', 'North Carolina', 'Female', '410135'),
    ('Ruth', 'Treutel', '2019-07-15', '507130047', '668407810', '+1 5780823315', '421 Delphia Mill', 'Denisboro', 'Hawaii', 'Female', '324317'),
    ('Mart', 'Fay', '2018-07-15', '138099655', '115728201', '+1 4053077934', '12608 Reilly Streets', 'Aniyahtown', 'Maryland', 'Male', '891140'),
    ('Cake', 'Fay', '2019-07-15', '284720710', '117216211', '+1 4527077744', '12608 Reilly Streets', 'Aniyahtown', 'Maryland', 'Male', '891140'),
    ('Megatron', 'Lesch', '2018-07-15', '389762538', '208973728', '+1 4361949947', '49332 Breitenberg Forest', 'Satterfieldport', 'Louisiana', 'Male', '232256'),  -- Added comma here
    ('Mosses', 'Hilpert', '2017-07-12', '495576126', '125837302', '+1 5852409455', '2008 Spinka Rue', 'Schinnerfort', 'Georgia', 'Male', '052055'),
    ('Sarah', 'Mills', '2016-07-10', '486345582', '255370333', '+1 6767013602', '81985 Heller Avenue', 'West Alexanderview', 'New Hampshire', 'Male', '639632'),
    ('Harold', 'Sanford', '2016-07-22', '563103281', '270872637', '+1 6738961236', '51823 Hane Harbor', 'Donnellyside', 'Oregon', 'Male', '284967'),
    ('Mary', 'Rosenbaum', '2015-07-15', '603023999', '247563065', '+1 6459836994', '4916 Watsica Mews', 'South Nona', 'Mississippi', 'Male', '088012'),
    ('Mandeep', 'Armstrong', '2017-07-15', '721708856', '333440329', '+1 7370295107', '185 Jonathan Meadows', 'Catonsville', 'Kansas', 'Male', '346459'),
    ('Ali', 'O\'Connell', '2018-07-15', '868910184', '398742068', '+1 7713404312', '49359 Gene Extensions', 'Miramar', 'North Carolina', 'Female', '410135'),
    ('Rudolf', 'Treutel', '2019-07-15', '007130047', '368407810', '+1 8780823315', '421 Delphia Mill', 'Denisboro', 'Hawaii', 'Female', '324317'),
    ('Bart', 'Fay', '2018-07-15', '138099656', '115728202', '+1 4053077934', '12608 Reilly Streets', 'Aniyahtown', 'Maryland', 'Male', '891140'),
    ('Jake', 'Fay', '2019-07-15', '284720716', '117216212', '+1 4527077744', '12608 Reilly Streets', 'Aniyahtown', 'Maryland', 'Male', '891140'),
    ('Begatron', 'Lesch', '2018-07-15', '389762536', '208973729', '+1 4361949947', '49332 Breitenberg Forest', 'Satterfieldport', 'Louisiana', 'Male', '232256'),  -- Added comma here
    ('Wosses', 'Hilpert', '2017-07-12', '495576127', '125837303', '+1 5852409455', '2008 Spinka Rue', 'Schinnerfort', 'Georgia', 'Male', '052055'),
    ('Narah', 'Mills', '2016-07-10', '486345587', '255370334', '+1 6767013602', '81985 Heller Avenue', 'West Alexanderview', 'New Hampshire', 'Male', '639632');


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
    ('Nettie', 'Anderson', '2024-07-15', '264300000', '456323792334', '+1 7675422816', 'C8!0S-r%bu', 'Jerdestad', 'California', '511306', 'Erin18@yahoo.com');

-- Personnels table
INSERT INTO personnels (first_name, last_name, birthdate, SSN, medicare, phone_number, address, city, province, postal_code, email_address, personnel_role, mandate) VALUES
    ('Myra', 'Hoeger', '1996-12-05', '350857000', '63407124', '+1 4169056562', '870 Garnet Junctions', 'Bauchville', 'ON', '693986', 'Myra91@gmail.com', 'Trainer', 'Salaried'),
    ('Sherman', 'Schimmel', '2001-05-06', '724579000', '51404101', '+1 6756027910', '5032 Eden Islands', 'Brockton', 'ON', '132319', 'Sherman.Schimmel@yahoo.com', 'General Manager', 'Salaried'),
    ('Lucy', 'Brakus', '2000-03-17', '142767000', '53635616', '+1 8309096224', '107 Emilio Land', 'South Kailee', 'ON', '138296', 'Lucy_Brakus39@hotmail.com', 'Trainer', 'Salaried'),
    ('Aaron', 'Harvey', '2000-03-25', '320150000', '05056278', '+1 7185196680', '4085 Kuphal Greens', 'Esmeraldahaven', 'ON', '471310', 'Aaron.Harvey@hotmail.com', 'General Manager', 'Salaried'),
    ('Nadine', 'Gislason', '2005-07-23', '324203000', '53958091', '+1 7315826391', '95463 Jenkins Coves', 'West Eusebio', 'ON', '673745', 'Nadine.Gislason@yahoo.com', 'Trainer', 'Salaried'),
    ('Bonnie', 'Parisian', '2004-09-15', '944799000', '25021098', '+1 1753528388', '3986 Corkery Keys', 'Fort Abigale', 'ON', '918165', 'Bonnie_Parisian3@yahoo.com', 'General Manager', 'Salaried'),
    ('Nettie', 'Anderson', '2005-06-11', '264300000', '16954750', '+1 3708554543', '539 Cecil Course', 'New Titoton', 'ON', '901656', 'Nettie.Anderson@gmail.com', 'Trainer', 'Volunteer'),
    ('Everett', 'Ryan', '2006-05-19', '223830000', '13844426', '+1 3944889177', '11027 Bauch Mills', 'Gerardoboro', 'ON', '526589', 'Everett.Ryan@hotmail.com', 'General Manager', 'Salaried'),
    ('Karla', 'Mohr-Bode', '1998-08-10', '868725000', '15190479', '+1 7649246672', '99529 Yundt Pine', 'Moline', 'ON', '949866', 'Karla_Mohr-Bode@hotmail.com', 'Trainer', 'Salaried'),
    ('Dallas', 'Orn', '2000-12-07', '389433000', '88213237', '+1 6980761271', '28678 Izaiah Ways', 'Fort Emelia', 'ON', '230329', 'Dallas42@hotmail.com', 'Trainer', 'Salaried'),
    ('Clark', 'Parisian', '2004-09-15', '344799000', '45021098', '+1 1753528388', '3986 Corkery Keys', 'Fort Abigale', 'ON', '918165', 'Clark_Parisian3@yahoo.com', 'Intern', 'Volunteer'),
    ('Nile', 'Anderson', '2005-06-11', '364300000', '26954750', '+1 3708554543', '539 Cecil Course', 'New Titoton', 'ON', '901656', 'Nettie.Anderson@gmail.com', 'Intern', 'Volunteer'),
    ('Andy', 'Ryan', '2006-05-19', '323830000', '03844426', '+1 3944889177', '11027 Bauch Mills', 'Gerardoboro', 'ON', '526589', 'Everett.Ryan@hotmail.com', 'Intern', 'Volunteer'),
    ('Samantha', 'Mohr-Bode', '1998-08-10', '168725000', '15140472', '+1 7649246672', '99529 Yundt Pine', 'Moline', 'ON', '949866', 'Karla_Mohr-Bode@hotmail.com', 'Intern', 'Volunteer'),
    ('Derek', 'Orn', '2000-12-07', '589433000', '38213237', '+1 6980761271', '28678 Izaiah Ways', 'Fort Emelia', 'ON', '230329', 'Dallas42@hotmail.com', 'Intern', 'Volunteer'),
    ('Jordan', 'Michael', '2006-05-19', '223835000', '13344426', '+1 3944889177', '11027 Bauch Mills', 'Gerardoboro', 'ON', '526589', 'Everett.Ryan@hotmail.com', 'General Manager', 'Salaried');

-- Personnels in locations table
INSERT INTO personnels_in_locations (personnel_SSN, location_id, start_date, end_date) VALUES
	('223830000', 1, '2014-06-27', '2017-03-20'),
    ('944799000', 1, '2020-05-04', '2021-03-20'),
    ('320150000', 1, '2021-04-25', '2022-02-20'), 
    ('223835000', 1, '2022-04-25', '2023-02-20'), 
    ('350857000', 1, '2024-05-05', null),
    ('724579000', 1, '2024-05-05', null),
    ('142767000', 2, '2024-01-30', '2024-04-24'),
    ('320150000', 2, '2023-04-25', '2024-02-20'), -- Aaron
    ('324203000', 3, '2022-07-17', null),
    ('944799000', 3, '2024-05-04', null), -- Bonnie
    ('264300000', 3, '2022-04-03', '2024-03-28'),
    ('223830000', 4, '2021-06-27', '2024-03-20'), -- Ryan
    ('868725000', 4, '2016-01-12', null),
    ('389433000', 4, '2015-10-19', null),
	('344799000', 1, '2020-03-21', null),
    ('364300000', 2, '2022-04-03', null),
    ('323830000', 3, '2021-06-27', null),
    ('168725000', 4, '2016-01-12', null),
    ('589433000', 5, '2015-10-19', null);

-- Family enrolled in locations table
INSERT INTO family_enrolled_in_locations (family_SSN, location_id, start_date, end_date) VALUES
     ('106201399', 1, '2015-05-24', null),
    ('985496281', 1, '2015-04-29', null),
    ('528237260', 1, '2015-05-04', null),
    ('163472843', 1, '2015-08-27', null),
    ('599284139', 5, '2015-09-05', null),
    ('923930728', 6, '2015-12-14', '2019-12-19'),
    ('448645522', 7, '2015-07-16', '2016-10-07'),
    ('808311919', 8, '2015-06-13', '2022-05-28'),
    ('103354394', 9, '2015-08-11', '2024-01-16'),
    ('264300000', 10, '2015-06-07', '2018-12-21');

-- Family enrolled members table
INSERT INTO family_enrolled_members (family_SSN, club_member_id, start_date, end_date, relation) VALUES
    ('106201399', 1, '2015-10-02', null, 'Father'),
    ('106201399', 2, '2015-08-01', null, 'Father'),
    ('985496281', 3, '2015-06-03', null, 'Grandfather'),
    ('163472843', 4, '2015-10-31', null, 'Mother'),
    ('599284139', 5, '2015-12-15', null, 'Father'),
    ('923930728', 6, '2015-01-07', null, 'Mother'),
    ('448645522', 7, '2015-04-04', null, 'Mother'),
    ('808311919', 8, '2015-02-09', null, 'Friend'),
    ('103354394', 9, '2015-06-15', '2018-06-19', 'Father'),
    ('264300000', 10, '2015-12-20', null, 'Mother');

-- Club member enrolled in locations table
INSERT INTO club_member_enrolled_in_locations (club_member_id, location_id, start_date, end_date) VALUES
	(1, 1, '2024-04-09', null),
    (3, 1, '2024-03-08', null),
    (4, 1, '2024-06-20', null),
    (5, 4, '2023-05-08', '2023-06-10'),
    (5, 2, '2023-07-08', '2023-08-10'),
    (5, 3, '2023-10-08', '2023-05-10'),
    (5, 1, '2024-05-08', null),
    (8, 1, '2023-03-26', '2024-05-14'),
    (9, 4, '2022-10-03', '2024-05-11'),
    (10, 5, '2023-11-16', null),
    (1, 4, '2023-05-08', '2023-06-10'),
    (1, 2, '2023-07-08', '2023-08-10'),
    (1, 3, '2023-10-08', '2023-05-10'),
    (2, 4, '2023-05-08', '2023-06-10'),
    (2, 2, '2023-07-08', '2023-08-10'),
    (2, 3, '2023-10-08', '2023-05-10'),
    (2, 1, '2024-05-08', null),
    (6, 4, '2023-05-08', '2023-06-10'),
    (6, 2, '2023-07-08', '2023-08-10'),
    (6, 3, '2023-10-08', '2023-05-10'),
    (6, 1, '2024-05-08', null),
    (7, 4, '2023-05-08', '2023-06-10'),
    (7, 2, '2023-07-08', '2023-08-10'),
    (7, 3, '2023-10-08', '2023-05-10'),
    (7, 1, '2024-05-08', null),
    (11, 1, '2023-05-08', null),
    (12, 1, '2023-07-08', null),
    (13, 1, '2023-10-08', null),
    (14, 1, '2024-05-08', null),
    (15, 1, '2023-05-08', null),
    (16, 1, '2023-07-08', null),
    (17, 1, '2023-10-08', null),
    (18, 1, '2024-05-08', null),
    (19, 2, '2023-05-08', null),
    (20, 2, '2023-07-08', null),
    (21, 2, '2023-10-08', null),
    (22, 2, '2024-05-08', null),
    (23, 2, '2023-05-08', null);
    

INSERT INTO teams (team_id, location_id, team_name, head_coach_id, gender) VALUES
	(1, 1, 'Blazers', '106201399', 'Male'),
    (2, 1, 'Anacondas', '985496281', 'Male'),
    (3, 4, 'Minnesota Stars', '448645522', 'Female'),
    (4, 2, 'Elite Warriors', '448645522', 'Male'),
    (5, 4, 'Warrior Legends', '985496281', 'Female'),
    (6, 1, 'Another team wow', '528237260', 'Male'),
    (7, 1, 'Yet another team wow', '163472843', 'Male'),
    (8, 1, 'Yet another another team wow', '599284139', 'Male'),
    (9, 1, 'Yet another another another team wow', '163472843', 'Male'),
    (10, 1, 'Yet another another another team wow', '163472843', 'Male');

INSERT INTO goalkeepers (team_id, goalkeeper_id) VALUES
	(1, 1),
    (2, 5),
    (3, 9),
    (5, 9),
    (1, 11), 
    (1, 12), 
    (1, 13), 
    (1, 14),
    (1, 15), -- Casey Fay as Defender for team 1
    (1, 16), -- Moses Hilpert as Defender for team 2
    (1, 17), -- Nettie Anderson as Defender for team 3
    (1, 18),
    (6, 11),
    (7, 12),
    (8, 13),
    (9, 14);-- Marta Fay as Goalkeeper for team 1

INSERT INTO forwards (team_id, forward_id) VALUES
	(1, 2),
    (2, 6),
    (1, 7), -- Marianne Rosenbaum as Forward for team 1
    (2, 8), -- Manuel Armstrong as Forward for team 2
    (3, 9), -- Manuel Armstrong as Forward for team 3 (shared player from another team)
	  (1, 1),
      (1, 15), -- Casey Fay as Defender for team 1
    (1, 16), -- Moses Hilpert as Defender for team 2
    (1, 17), -- Nettie Anderson as Defender for team 3
    (1, 18); -- Marta Fay as Goalkeeper for team 1-- Marta Fay as Goalkeeper for team 1

INSERT INTO defenders (team_id, defender_id) VALUES
	(1, 3),
    (2, 7),
    (1, 2), -- Casey Fay as Defender for team 1
    (2, 4), -- Moses Hilpert as Defender for team 2
    (3, 9), -- Nettie Anderson as Defender for team 3
    (1, 1),
    (1, 15), -- Casey Fay as Defender for team 1
    (1, 16), -- Moses Hilpert as Defender for team 2
    (1, 17), -- Nettie Anderson as Defender for team 3
    (1, 18); -- Marta Fay as Goalkeeper for team 1

INSERT INTO midfielders (team_id, midfielder_id) VALUES
	(1, 4),
    (2, 8),
    (2, 6), -- Harry Sanford as Midfielder for team 2
    (3, 9), -- Nettie Anderson as Midfielder for team 3
	(1, 1),
    (1, 15), -- Casey Fay as Defender for team 1
    (1, 16), -- Moses Hilpert as Defender for team 2
    (1, 17), -- Nettie Anderson as Defender for team 3
    (1, 18); -- Marta Fay as Goalkeeper for team 1 -- Marta Fay as Goalkeeper for team 1

INSERT INTO sessions (team_1_id, team_2_id, session_time, address, team_1_score, team_2_score, session_type) VALUES
    (1, 2, '2024-08-03 18:00:00', '444 West', 5, 7, 'Game'),
    (1, 2, '2024-01-12 18:20:00', '444 West', 5, 5, 'Training'),
    (1, 2, '2024-02-10 18:00:00', '444 West', 5, 5, 'Game'),
    (1, 2, '2024-04-09 08:00:00', '6855 Little Port, South Miles, Minnesota', 3, 2, 'Game'),
    (2, 1, '2024-04-09 11:00:00', '6855 Little Port, South Miles, Minnesota', NULL, NULL, 'Training'),
    (1, 3, '2024-04-09 14:00:00', '6855 Little Port, South Miles, Minnesota', 2, 1, 'Game'),
    (3, 2, '2024-04-09 17:00:00', '6855 Little Port, South Miles, Minnesota', 1, 3, 'Training'),
    (3, 1, '2024-04-09 20:00:00', '6855 Little Port, South Miles, Minnesota', 0, 2, 'Game'),
    (2, 3, '2024-03-01 15:00:00', '6855 Little Port, South Miles, Minnesota', NULL, NULL, 'Training'),
    (1, 3, '2024-03-05 10:00:00', '6855 Little Port, South Miles, Minnesota', 1, 2, 'Game'),
    (2, 3, '2024-03-10 15:00:00', '6855 Little Port, South Miles, Minnesota', 2, 2, 'Game'),
    (3, 1, '2024-03-20 10:00:00', '6855 Little Port, South Miles, Minnesota', 3, 1, 'Game'),
    (5, 1, '2022-03-20 10:00:00', '6855 Little Port, South Miles, Minnesota', 3, 1, 'Game'),
    (1, 2, '2024-04-01 10:00:00', '382 Bosco Gateway, Elgin, Maine', 3, 2, 'Game'),
    (2, 1, '2023-08-07 15:00:00', '382 Bosco Gateway, Elgin, Maine', NULL, NULL, 'Game'),
    (5, 1, '2022-03-21 10:00:00', '382 Bosco Gateway, Elgin, Maine', 3, 1, 'Game'),
    (1, 3, '2024-02-17 10:00:00', '6993 Robert Crescent, Fort Billy, Louisiana', 2, 1, 'Game'),
    (3, 2, '2024-02-12 15:00:00', '6993 Robert Crescent, Fort Billy, Louisiana', 1, 3, 'Game'),
    (3, 1, '2022-02-24 10:00:00', '6993 Robert Crescent, Fort Billy, Louisiana', 0, 2, 'Game'),
    
    (3, 2, '2021-04-01 10:00:00', '83368 Hayes Forest, Arnefurt, Connecticut', 3, 2, 'Game'),
    (2, 1, '2021-08-07 15:00:00', '83368 Hayes Forest, Arnefurt, Connecticut', NULL, NULL, 'Game'),
    (3, 1, '2021-03-21 10:00:00', '83368 Hayes Forest, Arnefurt, Connecticut', 3, 1, 'Game'),
    (5, 3, '2021-02-17 10:00:00', '953 Antonetta Squares, South Adelle, Kentucky', 2, 1, 'Game'),
    (1, 2, '2021-02-12 15:00:00', '953 Antonetta Squares, South Adelle, Kentucky', 1, 3, 'Game'),
    (3, 1, '2021-02-24 10:00:00', '953 Antonetta Squares, South Adelle, Kentucky', 0, 2, 'Game'),
    (6, 1, '2023-04-01 10:00:00', '382 Bosco Gateway, Elgin, Maine', 3, 2, 'Game'),
    (7, 1, '2023-05-01 10:00:00', '382 Bosco Gateway, Elgin, Maine', 3, 2, 'Game'),
    (8, 1, '2023-06-01 10:00:00', '382 Bosco Gateway, Elgin, Maine', 3, 2, 'Game'),
    (9, 1, '2023-07-01 10:00:00', '382 Bosco Gateway, Elgin, Maine', 3, 2, 'Game');
      
INSERT INTO secondary_family_members VALUES
	("985496281", 1, "Grandfather"),
	("985496281", 5, "Grandfather"),
    ("599284139", 1, "Cousin"),
    ("448645522", 1, "Cousin"),
    ("106201399", 1, "Cousin"),
    ("103354394", 1, "Cousin");

    