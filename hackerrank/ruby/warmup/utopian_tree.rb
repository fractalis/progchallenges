=begin
Problem Statement

The Utopian Tree goes through 2 cycles of growth every year. The first growth cy
cle occurs during the spring, when it doubles in height. The second growth cycle
 occurs during the summer, when its height increases by 1 meter.

Now, a new Utopian Tree sapling is planted at the onset of spring. Its height is
 1 meter. Can you find the height of the tree after N growth cycles?

Input Format

The first line contains an integer, T, the number of test cases.
T lines follow; each line contains an integer, N, that denotes the number of cyc
les for that test case.

Constraints
1≤T≤10
0≤N≤60
Output Format

For each test case, print the height of the Utopian Tree after N cycles. Each line
thus has to contain a single integer, only.
=end

t = gets.to_i
(0...t).each do |i|
  cycles = gets.to_i
  height = 1
  (1..cycles).each do |c|
    height = (c%2==0) ? height+1 : (height*2)
  end

  puts height
end

