def stringGen(sample)
  result = "" 
  (0...sample.length).each do
    result << letterSelect()
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
  (0..no_of_children).each do |count|
    children << mutator(parent)
  end
  return children
end

def mutator(clone)
  letters = clone.split("")
  (0...letters.length).each do |count| 
    if rand(19) == 0
      letters[count] = letterSelect()
    end
  end
  return letters.join
end

def pickFittest(prev_fit, generation, sample, target)
  fittest = prev_fit
  (0...generation.length).each do |count|
    if donLeven(generation[count], sample) <= target
      target = donLeven(generation[count], sample)
      fittest = generation[count]
    end
  end
  return fittest, target
end

def donLeven(attempt, target)
  score = 0
  (0...target.length).each do |count|
    unless attempt[count] == target[count]
      score +=1
    end
  end
  return score
end

SAMPLE = "methinks it is a weasel"

generation = multiplier(stringGen(SAMPLE), 100)
fittest, target = pickFittest(generation[0], generation, SAMPLE, SAMPLE.length)
puts "fittest = #{fittest} score: #{donLeven(fittest, SAMPLE)} step: 1"
step = 2

until donLeven(fittest, SAMPLE) == 0 or step == 100
  generation = multiplier(fittest, 100)
  fittest, target = pickFittest(fittest, generation, SAMPLE, target)
  puts "fittest = #{fittest} score: #{donLeven(fittest, SAMPLE)} step: #{step}"
  step += 1
end
