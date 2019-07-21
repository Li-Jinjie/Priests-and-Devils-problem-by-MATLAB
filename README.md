### part 1. Introduction

---

To solve Priests and Devils problem(传教士与野人过河问题) in MATLAB. This is the assignment of lesson 'Pattern recognition and intelligent system technology'.

 See more about this problem from [this page](https://www.geeksforgeeks.org/puzzle-3-priests-3-devils-puzzle/). In this repo I finished several functions as follows:

- [x] Exhaustive algorithm
- [x] Depth-First-Search and Breadth-First-Algorithm
- [x] A algorithm and A* algorithm
- [x] The number of Priests, Devils and people on the boat can be changed
- [x] In the end show the search process

### part 2. Quick start

---

1. Clone this file

   ```
   git clone https://github.com/Li-Jinjie/Priests-and-Devils-problem-by-MATLAB.git
   ```

2. Open main.m, and run

3. You can change method by selecting different values in main.m

   isqfs=  1 启发式 heuristic algorithm；0 穷举式 Exhaustive algorithm;   
   
   method=1.不在位个数; 2.相差绝对值; 3.A*; 4.不包含船的相差绝对值 
   
   isdeep=1 深度优先DFS; 0 广度优先BFS  如果选了启发式这个选项没用

   num_cjs=8;  %传道士人数 the number of Priests
   num_yr=8;   %野人人数  the number of Devils
   num_boat=4;  %船上人数  the number of people one boat can carry
