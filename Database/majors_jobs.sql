
drop database if exists Advisor;
create database Advisor;
Use Advisor;

create table Major(
	MajorID int auto_increment primary key,
    Major_name varchar(100),
    Description text,
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


