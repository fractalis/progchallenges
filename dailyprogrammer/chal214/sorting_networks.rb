=begin

/r/dailyprogrammer : http://www.reddit.com/r/dailyprogrammer/comments/36m83a/20150520_challenge_215_intermediate_validating/

=end

$valid_network = true

wires, comparators = $stdin.readline.chomp.split(" ").map(&:to_i)
network = Array.new

comparators.times do
  wireA, wireB = $stdin.readline.chomp.split(" ").map(&:to_i)
  network.push([wireA,wireB])
end

def sort_network(network, seq)
  network.each do |cA, cB|
    if seq[cB] < seq[cA]
      seq[cA], seq[cB] = seq[cB], seq[cA]
    end
  end
  return seq == seq.sort
end

permutations = [1,0].repeated_permutation(wires)
permutations.each do |seq|
  if not sort_network(network, seq)
    $valid_network = false
    break
  end
end

if not $valid_network
  puts "Invalid network"
else
  puts "valid network"
end
