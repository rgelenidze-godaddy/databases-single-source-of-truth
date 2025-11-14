--- Waterbody Database Schema: R. Gelenidze
--- Used horizontall partitioning to separate running and standing waterbodies
--- for vertical we could factor out water(w_id, w_name and w_quality)

CREATE TYPE w_quality as ENUM('1', '2', '3', '4', '5', '6', '7', '8', '9', '10');

/*
{[`rw_id: integer NOT NULL, `rw_name` varchar(50) NOT
NULL, `rw_quality` quality) NOT NULL, `length` integer
DEFAULT NULL, `flowsInto` integer DEFAULT NULL]}
forgot mileage_point

*/
CREATE TABLE r_water (
    rw_id            SERIAL PRIMARY KEY,
    rw_name          VARCHAR(50) NOT NULL,
    rw_quality       w_quality NOT NULL,
    length           INT DEFAULT NULL,

    -- Recursive relationship with attribute
    -- Relationship is smallRiver --N--flows_into--1--> largeRiver
    mileage_point   INT,
    flows_into      INT DEFAULT NULL REFERENCES r_water(rw_id)
);

/*
{[`sw_id: integer NOT NULL, `sw_name` varchar(50) NOT
NULL, `sw_quality` quality NOT NULL, `surface` integer DEFAULT NULL]}
*/
CREATE TABLE s_water (
    sw_id            SERIAL PRIMARY KEY,
    sw_name          VARCHAR(50) NOT NULL,
    sw_quality       w_quality NOT NULL,
    surface          INT DEFAULT NULL
);


/* Alternative: Vertical Partitioning
CREATE TABLE water(
    w_id            SERIAL PRIMARY KEY,
    w_name          TEXT NOT NULL,
    w_quality       w_quality
);

CREATE TABLE r_water (
    w_id            INT PRIMARY KEY REFERENCES water(w_id),
    length          INT,

    -- Recursive relationship with attribute
    -- Relationship is smallRiver --N--flows_into--1--> largeRiver
    mileage_point   INT,
    flows_into      INT REFERENCES r_water(w_id)
);

CREATE TABLE s_water (
    w_id            INT PRIMARY KEY REFERENCES water(w_id),
    surface         INT
);
*/


-- {[`p_id` serial NOT NULL, `p_title` varchar(150) NOT NULL, `t_cost` decimal(12,2) NOT NULL, startdate: date, enddate: date]}
CREATE TABLE project (
    p_id            SERIAL PRIMARY KEY,
    p_title         VARCHAR(150) NOT NULL,
    t_cost          DECIMAL(12,2),
    startdate       DATE,
    enddate         DATE
);


-- {[`org_id` serial NOT NULL, `org_name` varchar(80) NOT NULL]}
CREATE TABLE organization (
    org_id          SERIAL PRIMARY KEY,
    name            VARCHAR(80) NOT NULL
);


-- {[`r_email` varchar(80) NOT NULL, `r_name` varchar(80) NOT NULL, `org_id` int(10) UNSIGNED NOT NULL]}
CREATE TABLE researcher (
    r_email         VARCHAR(80) PRIMARY KEY,
    r_name          VARCHAR(80) NOT NULL,
    org_id  INT NOT NULL REFERENCES organization(org_id)
);


-- {[`r_email: varchar, p_id : integer, weekly_hours: INT, `function` varchar NOT NULL]}
CREATE TABLE works_on (
    p_id            INT NOT NULL REFERENCES project(p_id),
    r_email         VARCHAR(80) NOT NULL REFERENCES researcher(r_email),
    function        VARCHAR(100) NOT NULL,
    weekly_hours    INT,

    PRIMARY KEY (p_id, r_email)
);


-- {[org_id:integer, p_id: integer,  int(10) UNSIGNED NOT, amount: numeric]}
CREATE TABLE finances (
    org_id          INT NOT NULL REFERENCES organization(org_id),
    p_id            INT NOT NULL REFERENCES project(p_id),
    amount          INT,
    PRIMARY KEY (org_id, p_id)
);



-- {[`p_id` integer NOT NULL, `rw_id integer NOT NULL]}
CREATE TABLE rw_research (
    p_id            INT NOT NULL REFERENCES project(p_id),
    rw_id           INT NOT NULL REFERENCES r_water(rw_id),
    PRIMARY KEY (p_id, rw_id)
);


-- {[`p_id` integer NOT NULL, `sw_id integer NOT NULL]}
CREATE TABLE sw_research (
    p_id            INT NOT NULL REFERENCES project(p_id),
    sw_id           INT NOT NULL REFERENCES s_water(sw_id),
    PRIMARY KEY (p_id, sw_id)
);