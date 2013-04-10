def levenshtein_distance(s, t)
  m = s.length
  n = t.length
  return m if n == 0
  return n if m == 0
  d = Array.new(m+1) {Array.new(n+1)}
 
  (0..m).each {|i| d[i][0] = i}
  (0..n).each {|j| d[0][j] = j}
  (1..n).each do |j|
    (1..m).each do |i|
      d[i][j] = if s[i-1] == t[j-1]  # adjust index into string
                  d[i-1][j-1]       # no operation required
                else
                  [ d[i-1][j]+1,    # deletion
                    d[i][j-1]+1,    # insertion
                    d[i-1][j-1]+1,  # substitution
                  ].min
                end
    end
  end
  d[m][n]
end

def stringGen(sample)
  counter = 0
  result = "" 
  until counter == sample.length
    result << letterSelect()
    counter += 1
  end
  puts result
  return result
end

def letterSelect()
  letters = ("a".."z").to_a
  letters << " "
  return letters[rand(letters.length)]
end

def multiplier(parent, no_of_children)
  children = []
  counter = 0
  until counter == no_of_children
    children << mutator(parent)
    counter += 1
  end
  return children
end

def mutator(clone)
  counter = 0
  letters = clone.split("")
  until counter == letters.length 
    if rand(19) == 0
      letters[counter] = letterSelect()
    end
    counter += 1
  end
  return letters.join
end

def pickFittest(prev_fit, generation, sample, target)
  fittest = prev_fit
  counter = 0
  until counter == generation.length
    if levenshtein_distance(generation[counter], sample) <= target
      target = levenshtein_distance(generation[counter], sample)
      fittest = generation[counter]
    end
    counter += 1
  end
  return fittest, target
end

SAMPLE = "methinks it is a weasel"

generation = multiplier(stringGen(SAMPLE), 100)

fittest, target = pickFittest(generation[0], generation, SAMPLE, SAMPLE.length)
puts "fittest = #{fittest} - #{levenshtein_distance(fittest, SAMPLE)}"

puts SAMPLE.length
counter = 1
until levenshtein_distance(fittest, SAMPLE) == 0 or counter == 100
  generation = multiplier(fittest, 100)
  fittest, target = pickFittest(fittest, generation, SAMPLE, target)
  puts "fittest = #{fittest} - #{levenshtein_distance(fittest, SAMPLE)} count: #{counter}"
  counter += 1
end
