=begin

/r/dailyprogrammer : http://www.reddit.com/r/dailyprogrammer/comments/36m83a/20150520_challenge_215_intermediate_validating/

=end

class SortingNetworks
  attr_reader :wires, :num_comparators, :comparators

  def initialize(wires, num_comparators)
    @comparators = Array.new
    @wires = wires
    @num_comparators = num_comparators
    @valid = true

    load_comparators
    process
  end

  def is_valid?; @valid; end

  private

  def process
    permutations = [1,0].repeated_permutation(@wires)
    permutations.each do |seq|
      if not sort_network(seq)
        @valid = false
        break
      end
    end
  end

  def sort_network(seq)
    @comparators.each do |cA, cB|
      if seq[cB] < seq[cA]
        seq[cA], seq[cB] = seq[cB], seq[cA]
      end
    end
    return seq == seq.sort
  end

  def load_comparators
    num_comparators.times do
      wA, wB = $stdin.readline.chomp.split(" ").map(&:to_i)
      @comparators.push([wA,wB])
    end
  end
end

wires, num_comparators = $stdin.readline.chomp.split(" ").map(&:to_i)

sn = SortingNetworks.new(wires, num_comparators)

puts sn.is_valid? ? "Valid Network" : "Invalid Network"
