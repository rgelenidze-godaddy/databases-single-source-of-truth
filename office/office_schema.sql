-- Room Reservation Schema. Revazi Gelenidze

CREATE TABLE building (
    building_id CHAR(1) PRIMARY KEY,
    year_constr INT
);



-- ATTENTION:Lecturer's requested notation composite_key has order: (STRONG, WEAK) ანუ (BUILDING, ROOM), (AIRPLINE, SEAT_NO)...
CREATE TABLE room (
    building_id CHAR(1),
	room_id INT,
    size INT,
    PRIMARY KEY (building_id, room_id),
    FOREIGN KEY (building_id) REFERENCES building(building_id) 
        ON DELETE CASCADE -- If, building is removed, all rooms must CASCADE
);

-- Vertical partitioning entities
CREATE TABLE office (
    building_id CHAR(1),
	room_id INT,
    desk_no INT,
    locker_no INT,
    PRIMARY KEY (building_id, room_id),
    FOREIGN KEY (building_id, room_id) REFERENCES room(building_id, room_id) 
        ON DELETE CASCADE
	-- ATTENTION: in composite key do the order: (STRONG_ENTITY_KEY, WEAK_ENTITY_KEY), ex: (building_id, room_id)
	-- ATTENTION: Some reference to building(building_id), but its cleaner ; )
);


CREATE TABLE meeting_room (
    building_id CHAR(1),
	room_id INT,
    capacity INT,
    catering BOOLEAN,

	-- ATTENTION: Recursive relationship with composite key:
    combines_with_room_id INT,
    combines_with_building_id CHAR(1),
	
    PRIMARY KEY (building_id, room_id),
    FOREIGN KEY (building_id, room_id) REFERENCES room(building_id, room_id) 
        ON DELETE CASCADE,

	-- ATTENTION: my assumption that if A is combined with B, not any other X can combine with B
    UNIQUE (combines_with_building_id, combines_with_room_id) ,
    FOREIGN KEY (combines_with_building_id, combines_with_room_id) 
        REFERENCES meeting_room(building_id, room_id)
        ON DELETE SET NULL
);


CREATE TABLE department (
    dep_id INT PRIMARY KEY,
    depname VARCHAR(100),
    manager_id INT UNIQUE 
	-- SUPER ATTENTION FOR MIDTERM ABOUT ALTER commands: FK added below due to circular dependency
);


CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    function VARCHAR(100),

	-- office composite key (room, building)
    office_no INT,
    office_building CHAR(1),
	
    dep_id INT,
    mentor_id INT,
    FOREIGN KEY (office_building, office_no) REFERENCES office(building_id, room_id)
        ON DELETE SET NULL,
    FOREIGN KEY (dep_id) REFERENCES department(dep_id)
        ON DELETE SET NULL,
    FOREIGN KEY (mentor_id) REFERENCES employee(emp_id)
        ON DELETE SET NULL,
		
    -- Additional constraint to prevent self-mentoring (OPTIONAL)
    CONSTRAINT no_self_mentor CHECK (mentor_id IS DISTINCT FROM emp_id)
);

-- SUPER ATTENTION UECHVELI CHAARTYAMS GAMOCDAZE ALTERebs (sharshan aruqnia)
-- Add FK constraint here due to circular dependency
ALTER TABLE department
ADD CONSTRAINT fk_dept_manager 
    FOREIGN KEY (manager_id) REFERENCES employee(emp_id)
    ON DELETE SET NULL;

-- ანუ რა ვქენი: დეპარტამენტს ვერ ვუთითებდი მენეჯერ აიდის როგორც employee FK
-- რადგან გამოცხადებული არიყო ჯერ (LINE 64), ამიტო როგორც რიცხვი გამოვაცხადე
-- და მერე დავამატე დეტალი რო აი ეს ატტრიბუტი არის FK (LINE 88)


CREATE TABLE parking_space (
    park_id INT PRIMARY KEY,
    licence_no VARCHAR(50),
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employee(emp_id)
        ON DELETE SET NULL
);


CREATE TABLE skill (
    skill VARCHAR(100) PRIMARY KEY,
    description VARCHAR(200)
);


-- M-2-M relationship between employee and skill
CREATE TABLE employee_has_skill (
    emp_id INT,
    skill VARCHAR(100),
    PRIMARY KEY (emp_id, skill),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (skill) REFERENCES skill(skill) 
        ON DELETE CASCADE
);

-- Reservation table for specific meeting room in a timeslot
-- AXIOM: Timeslot არის ბუტაფორია ენთითი, რათა cardinality გამოვხატოთ
-- SQL ში მაინც ატრიბუტად გავასაღებთ ;)
CREATE TABLE reservation (
    building_id CHAR(1),
	room_id INT,
	
    timeslot TIMESTAMP NOT NULL,
    employee_id INT,
	
    occasion VARCHAR(100),
    no_guests INT,
	-- ATTENTION employee_id რო მივამატო მეოთხე კომპოზიტად მაგით გამეპარება შემდეგი შეცდომა:
	-- ეს ადამიანი ვერა, მაგრამ სხვა დაჯავშნის ამ შენობის ამ ოთახს იგივე დროს
	-- (K, 201, დღეს, რეზი)
	-- (K, 201, დღეს, თემო)

	-- ამიტომ გვაქვს სამიანი PK (NON_NULL, UNIQUE, MINIMAL, იფიფფფფ)
	-- (K, 201, დღეს)
	-- (K, 201, ხვალ)
	PRIMARY KEY (building_id, room_id, timeslot),
    FOREIGN KEY (building_id, room_id) REFERENCES meeting_room(building_id, room_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employee(emp_id)
        ON DELETE SET NULL -- მენეჯერი თუ მოკვდა, ივენთი მაინც მოხდეს my dummy assumption
);
