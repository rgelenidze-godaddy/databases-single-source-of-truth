-- University Database Schema: From 2024, not checked in practice yet

-- PROFESSOR
CREATE TABLE professor (
    prof_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    rank CHAR(2)
);

-- STUDENT
CREATE TABLE student (
    stud_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    semester SMALLINT CHECK (semester >= 1 AND semester <= 12),
    student_email VARCHAR(60)
);

-- COURSE
CREATE TABLE course (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    contact_hours SMALLINT NOT NULL,
    prof_id INTEGER,
    CONSTRAINT course_prof_fk FOREIGN KEY (prof_id)
        REFERENCES professor(prof_id)
);

-- ASSISTANT
CREATE TABLE assistant (
    assistant_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    research_area VARCHAR(80),
    prof_id INTEGER,
    CONSTRAINT assistant_prof_fk FOREIGN KEY (prof_id)
        REFERENCES professor(prof_id)
);

-- ENROLLMENT
CREATE TABLE enrollment (
    stud_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    PRIMARY KEY (course_id, stud_id),
    CONSTRAINT enrollment_stud_fk FOREIGN KEY (stud_id)
        REFERENCES student(stud_id) ON DELETE CASCADE,
    CONSTRAINT enrollment_course_fk FOREIGN KEY (course_id)
        REFERENCES course(course_id) ON DELETE CASCADE
);

-- EXAMINATION
CREATE TABLE examination (
    stud_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    prof_id INTEGER NOT NULL,
    grade VARCHAR NOT NULL,
    points SMALLINT,
    PRIMARY KEY (stud_id, course_id),
    CONSTRAINT exam_course_fk FOREIGN KEY (course_id)
        REFERENCES course(course_id),
    CONSTRAINT exam_prof_fk FOREIGN KEY (prof_id)
        REFERENCES professor(prof_id),
    CONSTRAINT exam_stud_fk FOREIGN KEY (stud_id)
        REFERENCES student(stud_id)
);

-- REQUIREMENT (course prerequisites)
CREATE TABLE requirement (
    predecessor INTEGER NOT NULL,
    successor INTEGER NOT NULL,
    PRIMARY KEY (predecessor, successor),
    CONSTRAINT req_predecessor_fk FOREIGN KEY (predecessor)
        REFERENCES course(course_id),
    CONSTRAINT req_successor_fk FOREIGN KEY (successor)
        REFERENCES course(course_id)
);
