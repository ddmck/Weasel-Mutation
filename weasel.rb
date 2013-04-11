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
    if donLeven(generation[counter], sample) <= target
      target = donLeven(generation[counter], sample)
      fittest = generation[counter]
    end
    counter += 1
  end
  return fittest, target
end

def donLeven(attempt, target)
  counter = 0
  score = 0
  until counter == target.length
    unless attempt[counter] == target[counter]
      score +=1
    end
    counter += 1
  end
  return score
end

SAMPLE = "methinks it is a weasel"

generation = multiplier(stringGen(SAMPLE), 100)

fittest, target = pickFittest(generation[0], generation, SAMPLE, SAMPLE.length)
puts "fittest = #{fittest} - #{donLeven(fittest, SAMPLE)}"

puts SAMPLE.length
counter = 1

puts donLeven(generation[0], SAMPLE)

until donLeven(fittest, SAMPLE) == 0 or counter == 100
  generation = multiplier(fittest, 100)
  fittest, target = pickFittest(fittest, generation, SAMPLE, target)
  puts "fittest = #{fittest} - #{donLeven(fittest, SAMPLE)} count: #{counter}"
  counter += 1
end
