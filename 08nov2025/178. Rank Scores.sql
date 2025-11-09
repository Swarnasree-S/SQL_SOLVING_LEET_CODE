
SELECT
    score,
    DENSE_RANK() OVER (ORDER BY score DESC) AS 'rank'
FROM scores;       type 'rank' dont use rank in alias name

1.💡 Full Syntax Structure
RANK() OVER (
    [PARTITION BY column_name]   -- (optional) group by a category
    ORDER BY column_name [ASC|DESC]  -- required, defines ranking order
)
2.ROW_NUMBER() Syntax
  --------------
ROW_NUMBER() OVER (ORDER BY column_name [ASC|DESC])

3. DENSE_RANK() OVER (ORDER BY column_name [ASC|DESC])


Example 3 — Comparing Different Rank Functions
SELECT
    name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS rank_no,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank_no,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_no
FROM employee;

name	salary	RANK	DENSE_RANK	ROW_NUMBER
Sita	70000	1	      1	            1
Ravi	70000	1	      1          	2
Mani	60000	3	      2          	3
Ram	    50000	4	      3	            4




key notes
-------------
Function	Handles ties	Example ranks for 70000, 70000, 60000, 50000
  ----------------------------------------------------------------------
RANK()	Same rank for ties, skips next	1, 1, 3, 4
DENSE_RANK()	Same rank for ties, no skip	1, 1, 2, 3
ROW_NUMBER()	Unique number always	1, 2, 3, 4
