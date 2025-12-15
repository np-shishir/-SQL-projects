create database sql_project2;
use sql_project2;

/*create tables*/
drop table if exists branch;
create table branch(
	branch_id varchar(10) primary key,
	manager_id varchar(10),
    branch_address	varchar(50),
    contact_no varchar(15)
);

drop table if exists employees;
create table employees(
	emp_id varchar(15) primary key,
	emp_name varchar(30),
	position varchar(25),
	salary int,
	branch_id varchar(25) -- fk
);

drop table if exists books;
create table books(
	isbn varchar(30) primary key,
    book_title varchar(80),
    category varchar(30),
    rental_price float,
    status varchar(30),
    author varchar(80),
    publisher varchar(60)
);

drop table if exists members;
create table members(
	member_id varchar(20) primary key,
	member_name varchar(35),
	member_address varchar(60),
	reg_date date

);

drop table if exists issued_status;
create table issued_status(
	issued_id varchar(20) primary key,
	issued_member_id varchar(20), -- fk
    issued_book_name varchar(75),
    issued_date date,
	issued_book_isbn varchar(25), -- fk
	issued_emp_id varchar(25) -- fk
);


drop table if exists return_status;
create table return_status(
	return_id varchar(20) primary key,
	issued_id varchar(15),
	return_book_name varchar(75),
	return_date	date,
    return_book_isbn varchar(25)

);

/*add foreign keys*/
alter table issued_status
add constraint fk_members
foreign key (issued_member_id)
references members(member_id);

alter table issued_status
add constraint fk_books
foreign key (issued_book_isbn)
references books(isbn);

alter table issued_status
add constraint fk_employees
foreign key (issued_emp_id)
references employees(emp_id);

alter table employees
add constraint fk_branch
foreign key (branch_id)
references branch(branch_id);

alter table return_status
add constraint fk_issued_status
foreign key (issued_id)
references issued_status(issued_id);
