


1.💡 Full Syntax Structure
RANK() OVER (
    [PARTITION BY column_name]   -- (optional) group by a category
    ORDER BY column_name [ASC|DESC]  -- required, defines ranking order
)
2.ROW_NUMBER() Syntax
  --------------
ROW_NUMBER() OVER (ORDER BY column_name [ASC|DESC])

3. DENSE_RANK() OVER (ORDER BY column_name [ASC|DESC])







key notes
-------------
Function	Handles ties	Example ranks for 70000, 70000, 60000, 50000
  ----------------------------------------------------------------------
RANK()	Same rank for ties, skips next	1, 1, 3, 4
DENSE_RANK()	Same rank for ties, no skip	1, 1, 2, 3
ROW_NUMBER()	Unique number always	1, 2, 3, 4
