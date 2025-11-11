

INSERT INTO public.trainer(
	tname, license, start_date)
	VALUES
('coach', TRUE, '2021-10-01'),
('klopp', TRUE, NULL),
('lazy', TRUE, NULL),
('lena', FALSE, NULL),
('nelly', FALSE, NULL);
--

INSERT INTO public.targetgroup(
	targetgroup, description)
	VALUES 
	('all', 'everybody'),
	('fam', 'families'),
	('kid', 'kinds up to 10'),
	('jun', 'young people 10 - 20'),
	('sen', 'seniors'),
	('men', 'courses for men'),
	('wom', 'courses for women');



INSERT INTO public.area(
	area, description, manager)
	VALUES 
('athletics', 'High jump, long jump, decathlon, penthalon, sprint distances and the like', 'nelly'),
('fitness', 'Comprises all courses that encrease healthy lifestyle and fitness', 'lena'),
('martialArt', 'Wrestling, Judo and the like', 'klopp'),
('watersport', 'All sports that have to do with water', 'lazy');

-- --------------------------------------------------------
--

INSERT INTO public.course(
	 course_name, targetgroup, area, trainer)
	VALUES 
('wrestling', 'men', 'martialArt', 'klopp'),
('waterball','men', 'watersport', 'klopp'),
('running', 'men', 'fitness', 'lazy'),
('jogging', 'fam', 'fitness', 'lena'),
('fitnessKids', 'kid', 'fitness', 'klopp'),
('high jump',  'fam', 'athletics', 'lena'),
('obstacle race', 'fam', 'athletics', 'lena'),
('swimming', 'fam', 'watersport', 'lena'),
('free style', 'kid', 'watersport', 'lazy'),
('aerobics', 'fam', 'fitness', 'lena');

-- --------------------------------------------------------
INSERT INTO public.enrollment(
	memname, course_id)
	VALUES
('hope', 1),
('hope', 5),
('hope', 6),
('hope', 7),
('hope', 10),
('lion', 1),
('lion', 4),
('lion', 5),
('lion', 6),
('lion', 7),
('lion', 10),
('lisa', 6),
('lisa', 9),
('nelly', 1),
('nelly', 4),
('nelly', 5),
('nelly', 6),
('nelly', 7),
('nelly', 10),
('robin', 1),
('robin', 4),
('robin', 5),
('robin', 6),
('robin', 7),
('robin', 10),
('rose', 4),
('rose', 5),
('rose', 6),
('rose', 7),
('rose', 10),
('val', 1),
('val', 4),
('val', 5),
('val', 6),
('valerie', 1),
('valerie', 4),
('valerie', 5),
('valerie', 6),
('valerie', 7),
('valerie', 10);
