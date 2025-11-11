INSERT INTO public.member(
	memname, is_trainer, email, postalcode, birthday, gender, entry_date, parent)
VALUES 
('coach', TRUE, 'coach@xx.ge', 4565,'1988-12-01', 'm', NULL,  NULL),
('figaro',  FALSE, 'figaro@xx.ge',3674,'1989-05-07', 'm', NULL,  NULL),
('hope',  FALSE, 'hope@xx.ge',4565, '1965-09-14', 'f', '2016-03-01',  NULL),
('klopp',  TRUE,'klopp@xx.ge',4600, '1980-12-24', 'm', NULL,  NULL),
('lazy',  TRUE,'lazy@xx.ge', 4600, '1996-11-25', 'm', NULL,  NULL),
('lena',  TRUE, 'lena@xx.ge',0105, '1995-01-25', 'f', NULL,  NULL),
('lion',  FALSE, 'lion@xxx.ge',0103,  '1990-10-10', 'm', NULL, NULL),
('nelly',  TRUE,'luke@xx.ge',4565, '1990-04-21', 'f', NULL,  NULL),
('valerie', FALSE, 'val@xx.ge',0105,  '1970-03-20', 'f', NULL, NULL),
('robin',  FALSE, 'nelly@xx.ge',4600, '2012-09-16', 'm', '2017-01-01', 'nelly'),
('rose',  FALSE, 'lion@xx.ge', 0107, '2015-02-10', 'f', NULL, 'lion'),
('val',  FALSE, 'val@xx.ge', 0103, '2013-07-12', 'm', '2020-05-01', 'figaro'),
('aron',  FALSE, 'klopp@xx.ge', 0103,'2013-11-06', 'm', '2020-01-01', 'klopp'),
('lisa',  FALSE, 'figaro@xx.ge', 4600,'2015-11-19', 'f', NULL, 'figaro'),
('luke',  FALSE, 'luke@xxx.ge', 4565,'1998-11-22', 'm', NULL,  'hope');