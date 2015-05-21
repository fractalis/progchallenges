=begin
Description:

Simple sort, but this time sort regardless of upper / lower case.

So the input of

[ "Hello", "there", "I'm", "fine"]
is translated to

["fine", "Hello", "I'm", "there" ]

=end

# Original solution
def sortme(names)
  names.sort do |a,b|
    a.downcase <=> b.downcase
  end
end

# Submission by other
def sortme_alt(names)
  names.sort_by(&:downcase)
end

def srotme_oneline(names)
  names.sort { |a,b| a.downcase <=> b.downcase }
end

