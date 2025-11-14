-- Sportsclub Database Schema: R. Gelenidze


CREATE TYPE public.gender AS ENUM ('f', 'm', 'd');

-- {[t_code:char(3), description: char varying(50)]}
CREATE TABLE public.targetgroup (
    targetgroup CHAR(3) PRIMARY KEY,
    description VARCHAR(50)
);

/* 
{[memname: string, is_trainer:boolean, email:string, postal_code: integer, birthday: 
date, gender: custom type: enum, entrydate:date; parent: string]}

- entrydate must be > 2015-01-01 (opening of the club)
- possible value in parent field must not be the same as in memname field. (prevents self-referencing)
*/
CREATE TABLE public.member (
    memname VARCHAR(20) PRIMARY KEY,
    is_trainer BOOLEAN NOT NULL DEFAULT false,
    email VARCHAR(50) NOT NULL,
    postal_code INTEGER NOT NULL,
    birthday DATE,
    gender public.gender NOT NULL,
    entry_date DATE,

    -- Recursive relationship
    parent VARCHAR(20),
    
    CONSTRAINT member_parent_fk FOREIGN KEY (parent)
        REFERENCES public.member(memname) ON UPDATE CASCADE ON DELETE SET NULL,

    -- Constraints
    CONSTRAINT member_entry_date_check CHECK (entry_date > '2015-01-01'),
    CONSTRAINT member_parent_not_self CHECK (parent IS NULL OR parent != memname)
);

-- {[tname: string, license: boolean, startdate:date]}
--- a trainer row can only be deleted if the trainer does not teach courses.
CREATE TABLE public.trainer (
    tname VARCHAR(20) PRIMARY KEY,
    license BOOLEAN DEFAULT false,
    start_date DATE,
    CONSTRAINT trainer_tname_fk FOREIGN KEY (tname)
        REFERENCES public.member(memname) ON UPDATE CASCADE ON DELETE CASCADE
);

-- {[area:string, description: string, manager: string]}
/*
- additional unique constraint on manager column. Why? Explain!
- it is allowed that an area is temporarily without trainer/manager if the trainer/manager is deleted (trainer leaves the club).
*/
CREATE TABLE public.area (
    area CHAR(10) PRIMARY KEY,
    description VARCHAR(80),
    manager VARCHAR(20),
    CONSTRAINT area_manager_fk FOREIGN KEY (manager)
        REFERENCES public.trainer(tname) ON UPDATE SET NULL ON DELETE SET NULL,
    CONSTRAINT area_manager_unique UNIQUE (manager)
);


-- {[course_id: integer, course_name: string, targetgroup(3), area: string, trainer: string]}
/*
- course_id is datatype serial
- it is allowed that a course temporarily does not belong to any area.
- a course needs a trainer at any time
- a course may belong to the default targetgroup "all" if the original targetgroup is
deleted.
- does any of the FKs in table course have a unique constraint as the FK in area?
Why or why not?
*/
CREATE TABLE public.course (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR NOT NULL,
    targetgroup CHAR(3) NOT NULL,
    area CHAR(10),
    trainer VARCHAR(20) NOT NULL,

    CONSTRAINT course_area_fk FOREIGN KEY (area)
        REFERENCES public.area(area) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT course_targetgroup_fk FOREIGN KEY (targetgroup)
        REFERENCES public.targetgroup(targetgroup) ON DELETE SET DEFAULT,
    CONSTRAINT course_trainer_fk FOREIGN KEY (trainer)
        REFERENCES public.trainer(tname)
        ON UPDATE CASCADE ON DELETE RESTRICT -- Must not delete trainer if assigned to course
);


-- {[memname:string, course_id: integer]}
/*
- if a member leaves the club (member row deleted), all enrollments are to be deleted
- if a course is cancelled (course row deleted), enrollments are to be kept
*/
CREATE TABLE public.enrollment (
    memname VARCHAR(20) NOT NULL,
    course_id INTEGER NOT NULL,
    PRIMARY KEY (memname, course_id),
    CONSTRAINT enrollment_memname_fk FOREIGN KEY (memname)
        REFERENCES public.member(memname) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT enrollment_course_fk FOREIGN KEY (course_id)
        REFERENCES public.course(course_id) ON UPDATE CASCADE ON DELETE NO ACTION
);

-- {[device_id:int, description:string]}
CREATE TABLE public.device (
    device_id SERIAL PRIMARY KEY,
    description VARCHAR(50) NOT NULL
);

--  {[timeslot:timestamp, memname:string, device_id:int]}
/*
- with additional unique constraint on {timeslot, device_id}
- if a member row is deleted (member leaves the club), all the rreservations
of the member need to be deleted
- if a device is not available anymore, the reservations of this device need to stay
*/
CREATE TABLE public.reservation (
    memname VARCHAR(20) NOT NULL,
    timeslot TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    device_id INTEGER NOT NULL,
    PRIMARY KEY (memname, timeslot),
    CONSTRAINT reservation_device_unique UNIQUE (timeslot, device_id),
    CONSTRAINT reservation_memname_fk FOREIGN KEY (memname)
        REFERENCES public.member(memname) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT reservation_device_fk FOREIGN KEY (device_id)
        REFERENCES public.device(device_id) ON UPDATE CASCADE ON DELETE NO ACTION
);
