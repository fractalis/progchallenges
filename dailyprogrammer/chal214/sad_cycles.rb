=begin
/r/dailyprogramming: http://www.reddit.com/r/dailyprogrammer/comments/36cyxf/20150518_challenge_215_easy_sad_cycles/
=end

def n_to_digits(n)
  digits = []
  while n > 0
    digits = digits + [n%10]
    n /= 10
  end
  digits
end

def sad_cycle(base, n)
  cycle = []
  while not cycle.include?(n)
    cycle = cycle + [n]
    n = n_to_digits(n).map { |x| x**base }.reduce(&:+)
  end
  cycle[cycle.index(n)..-1]
end

while true
  print "base: "; base = $stdin.gets.chomp.to_i
  exit if base==-1
  print "n: "; n = $stdin.gets.chomp.to_i

  puts sad_cycle(base,n).join(',')
end
