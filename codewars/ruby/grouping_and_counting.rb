def old_group_and_count(input)
    return nil if (input.nil? or input.empty?)
    res = {}
    input.each do |x|
        res[x] = 1 + res.fetch(x,0)
    end
    res
end

def group_and_count(input)
    return nil if (input.nil? or input.empty?)
    input.each_with_object(Hash.new(0)) { |v,o| o[v] += 1 }
end
