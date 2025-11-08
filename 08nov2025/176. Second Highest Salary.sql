176. Second Highest Salary


ans:1.
----
select (
    select salary from employee group by salary order by salary desc limit 1 offset 1
)as SecondHighestSalary

we are using subqueries to display null values,without subquery select we will get empty for no values record while using subquery we will receive null instead empty


ans:2.
---------


# Write your MySQL query statement below
select max(salary) as secondhighestsalary from employee where (salary<(select max(salary) from employee)) 
