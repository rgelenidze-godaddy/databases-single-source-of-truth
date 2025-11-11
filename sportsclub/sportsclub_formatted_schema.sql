CREATE TYPE public.gender AS ENUM ('f', 'm', 'd');

CREATE TABLE public.member (
    memname VARCHAR(20) PRIMARY KEY,
    is_trainer BOOLEAN NOT NULL DEFAULT false,
    email VARCHAR(50) NOT NULL,
    postalcode INTEGER NOT NULL,
    birthday DATE,
    gender public.gender NOT NULL,
    entry_date DATE,
    parent VARCHAR(20),
    CONSTRAINT member_parent_fk FOREIGN KEY (parent)
        REFERENCES public.member(memname) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE public.trainer (
    tname VARCHAR(20) PRIMARY KEY,
    license BOOLEAN DEFAULT false,
    start_date DATE,
    CONSTRAINT trainer_tname_fk FOREIGN KEY (tname)
        REFERENCES public.member(memname) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE public.area (
    area CHAR(10) PRIMARY KEY,
    description VARCHAR(80),
    manager VARCHAR(20),
    CONSTRAINT area_manager_fk FOREIGN KEY (manager)
        REFERENCES public.trainer(tname) ON UPDATE SET NULL ON DELETE SET NULL,
    CONSTRAINT area_manager_unique UNIQUE (manager)
);

CREATE TABLE public.targetgroup (
    targetgroup CHAR(3) PRIMARY KEY,
    description VARCHAR(60)
);

CREATE TABLE public.course (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR NOT NULL,
    targetgroup CHAR(3) NOT NULL,
    area CHAR(10),
    trainer VARCHAR(20) NOT NULL,
    CONSTRAINT course_area_fk FOREIGN KEY (area)
        REFERENCES public.area(area) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT course_targetgroup_fk FOREIGN KEY (targetgroup)
        REFERENCES public.targetgroup(targetgroup),
    CONSTRAINT course_trainer_fk FOREIGN KEY (trainer)
        REFERENCES public.trainer(tname)
);


CREATE TABLE public.device (
    device_id SERIAL PRIMARY KEY,
    description VARCHAR(50) NOT NULL
);

CREATE TABLE public.enrollment (
    memname VARCHAR(20) NOT NULL,
    course_id INTEGER NOT NULL,
    PRIMARY KEY (memname, course_id),
    CONSTRAINT enrollment_memname_fk FOREIGN KEY (memname)
        REFERENCES public.member(memname) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT enrollment_course_fk FOREIGN KEY (course_id)
        REFERENCES public.course(course_id)
);

CREATE TABLE public.reservation (
    memname VARCHAR(20) NOT NULL,
    timeslot TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    device_id INTEGER NOT NULL,
    PRIMARY KEY (memname, timeslot),
    CONSTRAINT reservation_device_unique UNIQUE (timeslot, device_id),
    CONSTRAINT reservation_memname_fk FOREIGN KEY (memname)
        REFERENCES public.member(memname) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT reservation_device_fk FOREIGN KEY (device_id)
        REFERENCES public.device(device_id)
);
