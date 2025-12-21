class Solution:
     def twoSum(self,nums,target):
          seen={}
          for i,num in enumerate(nums):
              need=target-num
              if need in seen:
                  return [seen[need],i]
              seen[num]=i
  



''''
A method is a function that belongs to a class.

So:

Function → written outside a class

Method → function written inside a class

🔹 Example
Function
def add(a, b):
    return a + b

Method
class Math:
    def add(self, a, b):
        return a + b


👉 Same logic, but:

Function stands alone

Method belongs to an object/class

📌 Interview Answer: What is an Object?

An object is a real instance of a class.
It represents a specific entity that can access the class’s methods and variables.

🔹 What does enumerate mean in Python?

📌 Interview Answer: What is enumerate in Python?

enumerate is a built-in Python function that allows us to loop over an iterable while keeping track of both the index and the value at the same time.
It improves code readability and avoids manual index handling.

🧠 Why interviewers like enumerate

Cleaner than range(len())

Reduces indexing mistakes

Pythonic and readable

Efficient (no extra overhead)

enumerate() lets you loop through a list and get both:

Index (position)

Value (element)

👉 At the same time.
🔹 Basic Example
nums = [10, 20, 30]

for i, num in enumerate(nums):
    print(i, num)

Output:
0 10
1 20
2 30


i → index (0, 1, 2)

num → value (10, 20, 30)'''
