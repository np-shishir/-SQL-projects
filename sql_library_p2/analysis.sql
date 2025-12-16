use sql_project2;
select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from return_status;
select * from members;

-- create a book
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- update a members address
update members
set member_address = '980 Ktm'
where member_id = 'C101';


-- delete a record from issued status table
delete from issued_status
where issued_id = 'IS106';

-- all books issued by a specific employee
select * from issued_status
where issued_emp_id = 'E104';

-- members who have issued more than one book
select issued_member_id, count(*) as issued_books_no
from issued_status
group by issued_member_id
having issued_books_no>1
order by issued_books_no;

-- employees who have issued multiple books
select issued_status.issued_emp_id, employees.emp_name, count(*) as issue_count
from issued_status
join employees
on employees.emp_id = issued_status.issued_emp_id
group by issued_status.issued_emp_id, employees.emp_name
having issue_count>1;


-- total books in each category
select category, count(category) as total_books
from books
group by category
order by total_books desc;


-- total rental income by each book
select * from books;
select* from issued_status;
select b.book_title, sum(b.rental_price) as income_per_book
from books as b
join issued_status as ist
on b.book_title = ist.issued_book_name
group by b.book_title
order by income_per_book desc;


-- total rental income by each category
select * from books;
select* from issued_status;
select b.category, sum(b.rental_price) as income_per_category
from books as b
join issued_status as ist
on b.isbn = ist.issued_book_isbn
group by b.category
order by income_per_category desc;


-- members registered in the last 180 days
select * from members
where reg_date >= current_date - interval 180 day;


-- list employees with their branch manager's name and branch details
select * from employees;
select * from branch;

select e.emp_name, b.manager_id, b.branch_address, b.contact_no
from employees as e
right join branch as b
on e.branch_id = b.branch_id;


-- create a table for books with rental price above 7usd
create table expensive_books
as
select * from books
where rental_price>7;

select * from expensive_books;


-- list of books not returned yet
select * from books;
select * from return_status;
SELECT DISTINCT ist.issued_book_isbn
FROM issued_status ist
LEFT JOIN return_status rs
    ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;
