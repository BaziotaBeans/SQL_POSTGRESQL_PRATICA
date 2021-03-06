create table regions(
    region_id serial primary key,
    region_name varchar(25)
);


insert into regions(region_id, region_name) values (1, 'Europe'), (2, 'Americas'), (3, 'Asia'), (4, 'Middle East and Africa');


create table countries(
    country_id char(2) primary key,
    country_name varchar(40),
    region_id int,
    constraint country_regions foreign key (region_id) references regions(region_id) on delete cascade on update cascade
);


insert into countries(country_id, country_name, region_id) values
('CA', 'Canada', 2),
('DE', 'Germany', 1),
('UK', 'United Kingdom', 1),
('US', 'United States of America', 2);


create table locations(
    location_id serial primary key,
    street_address varchar(40),
    postal_code varchar(12),
    city varchar(30) not null,
    state_province varchar(25),
    country_id char(2),
    constraint locations_countries foreign key (country_id) references countries(country_id) on delete cascade on update cascade
);


insert into locations(location_id, street_address, postal_code, city, state_province, country_id) values 
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas','US'),
(1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US'),
(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
(1800, '460 Bloor St. W', 'ON M5S 1X8', 'Toronto', 'Ontario', 'CA'),
(2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');


create table departments(
    department_id serial primary key,
    department_name varchar(30) not null,
    manager_id int,
    location_id int,
    constraint department_locations foreign key (location_id) references locations(location_id) on delete cascade on update cascade
);

insert into departments(department_id, department_name, manager_id, location_id) values
(10, 'Administration',200,1700),
(20, 'Marketing',201, 1800),
(50, 'Shipping',124,1500),
(60, 'IT',103,1400),
(80, 'Sales', 149, 2500),
(90, 'Executive', 100, 1700),
(110, 'Accounting',205,1700),
(190, 'Contracting',null,1700);


create table jobs(
    job_id varchar(10) primary key,
    job_title varchar(35) not null,
    min_salary int,
    max_salary int
);


insert into jobs(job_id, job_title, min_salary, max_salary) values
('AD_PRES','President',20000,40000),
('AD_VP', 'Administration Vice President', 15000, 30000),
('AD_ASST', 'Administration Assistant', 3000, 6000),
('AC_MGR','Accounting Manager', 8200, 16000),
('AC_ACCOUNT','Public Accountant', 4200, 9000),
('SA_MAN', 'Sales Manager', 10000, 20000),
('SA_REP', 'Sales Representative', 6000, 12000),
('ST_MAN', 'Stock Manager', 5500, 8500),
('ST_CLERK', 'Stock Clerk', 2000, 5000),
('IT_PROG', 'Programmer', 4000, 10000),
('MK_MAN', 'Marketing Manager', 9000, 15000),
('MK_REP', 'Marketing Representative',4000, 9000);


create table employees(
    employee_id serial primary key,
    first_name varchar(20),
    last_name varchar(25) not null,
    email varchar(25) not null,
    phone_number varchar(20),
    hire_date date not null,
    job_id varchar(10) not null,
    salary decimal(8,2),
    commission_pct decimal(2,2),
    manager_id int,
    department_id int,
    constraint employees_jobs foreign key (job_id) references jobs(job_id) on delete cascade on update cascade,
    constraint employees_departments foreign key (department_id) references departments(department_id) on delete cascade on update cascade
);


insert into employees (employee_id, first_name, last_name, email, 
phone_number, hire_date, job_id, salary, commission_pct, 
manager_id, department_id) values

(100, 'Steven', 'King', 'Sking', '515.123.4567', '1987-06-17', 'AD_PRES', 24000, null, null, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP',17000, null, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1993-01-13', 'AD_VP',17000, null, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1990-01-03','IT_PROG', 9000, null, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1991-05-21','IT_PROG', 600, null, 103, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '1999-02-07','IT_PROG', 4200, null, 103, 60),
(124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', '1999-11-16','ST_MAN', 5800, null, 100, 50),
(141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', '1995-10-17','ST_CLERK', 3500, null, 124, 50),
(142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', '1997-01-29','ST_CLERK', 3100, null, 124, 50),
(143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', '1998-03-15','ST_CLERK', 2600, null, 124, 50),
(144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', '1998-06-09','ST_CLERK', 2500, null, 124, 50),
(149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '2000-01-29', 'SA_MAN', 10500, .2, 100, 80),
(174, 'Ellen', 'Abel', 'EABEL','011.44.1644.429267', '1996-05-11','SA_REP', 11000, .3, 149, 80),
(176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265','1998-03-24','SA_REP', 8600, .2, 149, null),
(178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263','1999-05-24','SA_REP', 7000, .15, 149, null),
(200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', '1987-09-17', 'AD_ASST', 4400, null, 101, 10),
(201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', '1996-02-17', 'MK_MAN', 13000, null, 100, 20),
(202, 'Pat', 'Fay', 'PFAY', '603.123.6666', '1997-08-17', 'MK_REP', 6000, null, 201, 20),
(205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', '1994-06-07', 'AC_MGR', 12000, null, 101, 110 ),
(206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', '1994-06-07','AC_ACCOUNT', 8300, null, 205, 110);


create table job_grades(
    grade_level varchar(3),
    lowest_sal int,
    highest_sal int
);


insert into job_grades(grade_level, lowest_sal, highest_sal) values
('A', 1000, 2999),
('B', 3000, 5999),
('C', 6000, 9999),
('D', 10000, 14999),
('E', 15000, 24999),
('F', 25000, 40000);


create table job_history(
    employee_id int not null,
    start_date date not null,
    end_date date not null,
    job_id varchar(20) not null,
    department_id int,
    constraint job_history_employees foreign key (employee_id) references employees(employee_id) on delete cascade on update cascade,
    constraint job_history_jobs foreign key (job_id) references jobs(job_id) on delete cascade on update cascade,
    constraint job_history_departments foreign key (department_id) references departments(department_id) on delete cascade on update cascade,
    constraint pk_job_history_employees_jobs_departments primary key(employee_id, job_id, department_id)  
);

insert into job_history (employee_id, start_date, end_date, job_id, department_id) values
(102, '1993-01-13', '1998-07-24', 'IT_PROG', 60),
(101, '1989-09-21', '1993-10-27', 'AC_ACCOUNT', 110),
(101, '1993-10-28', '1997-03-15', 'AC_MGR', 110),
(201, '1996-02-17', '1999-12-19', 'MK_REP', 20),
(200, '1997-09-17', '1993-06-17', 'AD_ASST', 90),
(176, '1999-03-24', '1998-12-31', 'SA_REP', 80),
(176, '1999-01-01', '1999-12-31', 'SA_MAN', 80),
(200, '1994-07-01', '1998-12-31', 'AC_ACCOUNT', 90);