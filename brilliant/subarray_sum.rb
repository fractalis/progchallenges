=begin
https://brilliant.org/problems/computer-science-problem-24346/

Given an array and a number , write a function that determines if there exists a
 contiguous sub-array whose sum is t

Which of the below arrays contains a sub-array whose sum is (316)?

A. {61, 6, 39, 29, 30, 72, 98, 36, 42, 66, 24, 58, 13, 16, 73}
B. {87, 78, 4, 10, 48, 43, 33, 70, 21, 18, 75, 66, 39, 80, 87}
C. {82, 72, 39, 67, 65, 93, 28, 2, 89, 39, 68, 29, 61, 14, 98}
D. {45, 5, 14, 75, 100, 37, 98, 64, 90, 52, 66, 30, 18, 89, 19}
=end

def subarray_contiguous_sum(xs, target)
  sa_start = 0
  sa_sum = 0

  xs.each_with_index do |x,i|
    sa_sum += x
    if sa_sum == target
      return true
    elsif sa_sum > target
      while sa_sum > target and sa_start < xs.length
        sa_sum -= xs[sa_start]
        sa_start += 1
      end
    end
  end
  return sa_sum == target # If last element is equal to target
end
