-- creating retirment_titles table 

SELECT DISTINCT (e.emp_no), first_name, last_name, title, from_date, to_date
into retirement_titles
from employees e inner join titles t on e.emp_no = t.emp_no
where (e.birth_date between '1952-01-01' and '1955-12-31');

select * from retirement_titles;

-- creating unique titles table to store employees titles who are about to retire
select distinct (emp_no),first_name, last_name, title 
into unique_titles
from retirement_titles
where to_date='9999-01-01'
order by emp_no;

-- Retrieving title count for each unique title of retiring employees.

select count(title) as no_of_titles,title 
into retiring_titles
from unique_titles
group by title order by no_of_titles desc;

-- filtering data to determine mentorship eligibility

select distinct(e.emp_no), e.first_name, e.last_name, e.birth_date, 
de.from_date, de.to_date, t.title
into mentorship_eligibilty
from employees e inner join dept_emp de on e.emp_no=de.emp_no
inner join titles t on e.emp_no=t.emp_no
where (t.to_date='9999-01-01' and de.to_date='9999-01-01')
and (e.birth_date BETWEEN '1965-01-01' and '1965-12-31')
order by e.emp_no
