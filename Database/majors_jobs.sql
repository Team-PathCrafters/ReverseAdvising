Use 4702744_advisor;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS 
    Answer_Job_Link,
    Answer_Major_Link,
    Answers,
    Questions,
    Job_Attributes,
    Attributes,
    Major_Jobs,
    Major_Views,
    Jobs,
    Major;

SET FOREIGN_KEY_CHECKS = 1;

create table Major(
	MajorID int auto_increment primary key,
    Major_name varchar(100),
    CreditHrs int,
    focus varchar(100)
    );
    
create table Major_Views(
    MajorID int, 
	Total_views int,
    foreign key (MajorID) references Major(MajorID)
);
create table Jobs(
	JobID int auto_increment primary key,
    Job_name varchar(100),
	Final_degree varchar(20),
    years_needed int, 
    avgCost decimal(10,2),
    Salary decimal(10,2)
    );

create table Major_Jobs(
	JobID int, 
    MajorID int,
    primary key(JobID, MajorID),
    foreign key (MajorID) references Major(MajorID),
    foreign key (JobID) references Jobs(JobID)
    );

create table Attributes(
	AttriID int auto_increment primary key,
    Attri_name varchar(100)
);

create table Job_Attributes(
	AttriID int, 
    JobID int,
    Primary key (AttriID, JobID),
    foreign key (AttriID) references Attributes(AttriID),
    foreign key (JobID) references Jobs(JobID)
    );
    
create table Questions (
	QuestionID Int auto_increment primary key,
    QuestionText text not null
);

create table Answers (
	AnswerID int auto_increment primary key,
    QuestionID int,
    answerText text,
    foreign key (QuestionID) references Questions(QuestionID)
		on delete cascade
        on update cascade
);

Create table Answer_Major_Link(
	AnswerID int,
	MajorID int,
	primary key (AnswerID, MajorID),
	foreign key (AnswerID) references Answers(AnswerID),
	foreign key (MajorID) references Major(MajorID)
);

Create table Answer_Job_link(
	AnswerID int,
	JobID int,
	primary key (AnswerID, JobID),
	foreign key (AnswerID) references Answers(AnswerID),
	foreign key (JobID) references Jobs(JobID)
);
-- add all current Majors 
INSERT INTO Major (Major_name, CreditHrs, focus)
VALUES
('Biochemistry', 120, 'Study of chemical processes within living organisms'),
('Cellular & Molecular Biology', 120, 'Focus on molecular and cellular mechanisms of life'),
('Biology', 120, 'Broad study of living organisms and biological systems'),
('Chemistry', 120, 'Study of matter, reactions, and composition'),
('Nursing', 120, 'Healthcare and patient care studies');

-- add all current jobs 
INSERT INTO Jobs (Job_name, Final_degree, years_needed, avgCost, Salary)
VALUES
('Doctor', 'MD or OD', 11, 300000.00, 375000.00),
('Physician Assistant', 'PA', 4, 107000.00, 130000.00),
('Nurse Practitioner', 'MSN or DNP', 4, 80000.00, 132000.00),
('Pharmacist', 'PharmD', 4, 200000.00, 151000.00),
('Nurse', 'BSN', 0, NULL, 93000.00),
('Dentist', 'DDS', 8, 400000.00, 195000.00),
('Dermatologist', 'MD or OD', 11, 300000.00, NULL),
('Anesthesiologist', 'MD or OD', 11, 300000.00, NULL),
('Surgeon', 'MD or OD', 13, 300000.00, NULL);


INSERT INTO Major_Jobs (JobID, MajorID)
VALUES (1, 1), (1, 2), (1, 3);

-- Physician Assistant
INSERT INTO Major_Jobs (JobID, MajorID)
VALUES (2, 1), (2, 2), (2, 3);

-- Nurse Practitioner
INSERT INTO Major_Jobs (JobID, MajorID)
VALUES (3, 1), (3, 2), (3, 3), (3, 5);

-- Pharmacist
INSERT INTO Major_Jobs (JobID, MajorID)
VALUES (4, 1), (4, 4);

-- Nurse
INSERT INTO Major_Jobs (JobID, MajorID)
VALUES (5, 5);

-- Dentist
INSERT INTO Major_Jobs (JobID, MajorID)
VALUES (6, 1), (6, 2), (6, 3);

-- Dermatologist (same as Doctor)
INSERT INTO Major_Jobs (JobID, MajorID)
VALUES (7, 1), (7, 2), (7, 3);

-- Anesthesiologist (same as Doctor)
INSERT INTO Major_Jobs (JobID, MajorID)
VALUES (8, 1), (8, 2), (8, 3);

-- Surgeon (same as Doctor)
INSERT INTO Major_Jobs (JobID, MajorID)
VALUES (9, 1), (9, 2), (9, 3);


-- in case we need to edit the questions/answers
	-- un comment and run both lines
-- TRUNCATE TABLE Answers;
-- TRUNCATE TABLE Questions;


-- add questions and answers 
INSERT INTO Questions (QuestionText)
VALUES ('What excites you most about working in healthcare?');

INSERT INTO Answers (QuestionID, answerText) VALUES
(1, 'Helping people directly and making a difference in their lives (Nursing, Pre-Medicine, Public Health)'),
(1, 'Investigating and analyzing lab results to solve medical mysteries (Medical Laboratory Sciences, Biochemistry, Chemistry)'),
(1, 'Understanding how the body works at the smallest level (Cellular & Molecular Biology, Biochemistry, Biological Sciences)'),
(1, 'Responding to emergencies and saving lives under pressure (Paramedicine, Pre-Chiropractic, Pre-Dentistry)');

-- 2
INSERT INTO Questions (QuestionText)
VALUES ('How do you prefer to work?');

INSERT INTO Answers (QuestionID, answerText) VALUES
(2, 'Hands-on with patients (Nursing, Radiologic Technology, Exercise Science, Pre-Physical Therapy)'),
(2, 'In a lab running experiments (Chemistry, Biochemistry, Medical Laboratory Sciences)'),
(2, 'Studying nature, health trends, or populations (Ecology & Evolutionary Biology, Public Health, Environmental Science)'),
(2, 'Teaching and mentoring the next generation (Biological Sciences with Secondary Education Certification, Chemistry with Secondary Education Certification)');

-- 3
INSERT INTO Questions (QuestionText)
VALUES ('What subject do you enjoy most?');

INSERT INTO Answers (QuestionID, answerText) VALUES
(3, 'Biology & anatomy (Pre-Medicine, Pre-Optometry, Pre-Veterinary Medicine, Exercise Science)'),
(3, 'Chemistry (Biochemistry, Chemistry, Forensic Chemistry)'),
(3, 'Psychology & understanding the mind (Psychology, Pre-Occupational Therapy)'),
(3, 'Math & problem solving (Pre-Engineering, Applied Science)');

-- 4
INSERT INTO Questions (QuestionText)
VALUES ('How comfortable are you with stressful, fast-paced situations?');

INSERT INTO Answers (QuestionID, answerText) VALUES
(4, 'Very comfortable—I thrive in high-pressure environments (Paramedicine, Nursing, Emergency Care)'),
(4, 'Somewhat comfortable—I prefer structured, controlled environments (Medical Laboratory Sciences, Radiologic Technology)'),
(4, 'I’d rather work behind the scenes and focus on research (Biochemistry, Ecology & Evolutionary Biology, Environmental Science)'),
(4, 'I enjoy teamwork but prefer steady and predictable work (Public Health, Secondary Education Prep programs)');

-- 5
INSERT INTO Questions (QuestionText)
VALUES ('Which of these appeals most to you?');

INSERT INTO Answers (QuestionID, answerText) VALUES
(5, 'Becoming a doctor, dentist, or other healthcare provider (Pre-Medicine, Pre-Dentistry, Pre-Optometry, Pre-Chiropractic)'),
(5, 'Conducting research that leads to medical breakthroughs (Cellular & Molecular Biology, Biochemistry, Chemistry)'),
(5, 'Promoting healthier communities through outreach (Public Health, Psychology, Nursing)'),
(5, 'Using technology to diagnose and treat patients (Radiologic Technology, Medical Laboratory Sciences)');

-- 6
INSERT INTO Questions (QuestionText)
VALUES ('What’s your ideal career environment?');

INSERT INTO Answers (QuestionID, answerText) VALUES
(6, 'Hospital or clinic with direct patient care (Nursing, Radiologic Technology, Pre-Medicine)'),
(6, 'Emergency response team (Paramedicine, Pre-Chiropractic)'),
(6, 'Research lab or academic setting (Biological Sciences, Biochemistry, Chemistry, Environmental Science)'),
(6, 'Community, school, or government setting (Public Health, Psychology, Secondary Education Certification tracks)');

-- 7
INSERT INTO Questions (QuestionText)
VALUES ('How do you like solving problems?');

INSERT INTO Answers (QuestionID, answerText) VALUES
(7, 'By physically treating the issue (Exercise Science, Pre-Physical Therapy, Nursing)'),
(7, 'By researching and finding scientific explanations (Biological Sciences, Chemistry, Biochemistry)'),
(7, 'By educating others and spreading awareness (Public Health, Secondary Education Prep)'),
(7, 'By using technology and data (Radiologic Technology, Medical Laboratory Sciences, Applied Science)');

-- 8
INSERT INTO Questions (QuestionText)
VALUES ('What motivates you most in a career?');

INSERT INTO Answers (QuestionID, answerText) VALUES
(8, 'Caring for individuals and saving lives (Nursing, Paramedicine, Pre-Medicine)'),
(8, 'Discovering new knowledge (Biochemistry, Cellular & Molecular Biology, Ecology & Evolutionary Biology)'),
(8, 'Helping entire communities live healthier lives (Public Health, Psychology, Environmental Science)'),
(8, 'Applying science and technology to solve problems (Medical Laboratory Sciences, Radiologic Technology, Applied Science)');

-- 9
INSERT INTO Questions (QuestionText)
VALUES ('What type of patients or issues would you most want to work with?');

INSERT INTO Answers (QuestionID, answerText) VALUES
(9, 'Human patients in hospitals or clinics (Nursing, Radiology, Pre-Medicine)'),
(9, 'Animals and veterinary health (Pre-Veterinary Medicine)'),
(9, 'Populations facing public health challenges (Public Health, Environmental Science, Psychology)'),
(9, 'Forensic or criminal cases (Forensic Chemistry)');

-- 10
INSERT INTO Questions (QuestionText)
VALUES ('How would you describe your personality at work?');

INSERT INTO Answers (QuestionID, answerText) VALUES
(10, 'Compassionate and empathetic (Nursing, Pre-Occupational Therapy, Pre-Physical Therapy)'),
(10, 'Analytical and detail-oriented (Medical Laboratory Sciences, Chemistry, Applied Science)'),
(10, 'Curious and investigative (Biological Sciences, Ecology, Cellular & Molecular Biology)'),
(10, 'Outgoing and communicative (Secondary Education Prep, Public Health, Psychology)');
