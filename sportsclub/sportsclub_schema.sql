CREATE TABLE target_group(
    target_group varchar(100) PRIMARY KEY,
    description varchar(100)
);

CREATE TABLE device(
    device_id SERIAL PRIMARY KEY,
    dev_name VARCHAR(100)
);

CREATE TYPE gender AS ENUM ('m', 'f');

CREATE TABLE member (
    memname VARCHAR(100) PRIMARY KEY,
    is_trainer BOOLEAN,
    email VARCHAR(100),
    postal_code INTEGER
    birthday DATE,
    gender gender
    entry_date DATE,
    parent VARCHAR(100),
    CONSTRAINT fk_parent_child FOREIGN KEY (parent) 
        REFERENCES member(memname)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);

CREATE TABLE trainer (
    memname VARCHAR(100) PRIMARY KEY,
    CONTRAINT fk_trainer_member FOREIGN KEY (memname) 
        REFERENCES member(memname)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
    license BOOLEAN NOT NULL,
    start_date DATE
    );
    
    

CREATE TABLE reservation(
    device_id INT,
    memname VARCHAR(100),
    timeslot TIMESTAMP,
    PRIMARY(device_id, timeslot),
    CONTRAINT fk_reservation_member FOREIGN KEY (memname) 
        REFERENCES member(memname)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
    CONTRAINT fk_reservation_device FOREIGN KEY (device_id) 
        REFERENCES device(device_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
