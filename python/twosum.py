class Solution:
     def twoSum(self,nums,target):
          seen={}
          for i,num in enumerate(nums):
              need=target-num
              if need in seen:
                  return [seen[need],i]
              seen[num]=i
  



''''🔹 What does enumerate mean in Python?

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
