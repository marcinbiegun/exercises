#!/bin/ruby

require 'pry'
require 'json'
require 'stringio'
require 'ostruct'

def minimum_bribes(q)
  bribes = 0

  reverse_index = (0..q.size-1).to_a.reverse
  reverse_index.each do |index|
    person = q[index]
    distance = person - (index + 1)

    if distance > 2
      return "Too Chaotic"
    end

    # How many persons in needs to skip over (that are above current persons number)
    # to be at it's own position

    indices_up_to_valid_position = ([0, person - 2].max..index)
    indices_up_to_valid_position.each do |index_check|
      has_to_jump_over person = q[index_check] > person
      if has_to_jump_over_persion
        bribes += 1
      end
    end
  end

  bribes
end

#t = gets.to_i

#t.times do |t_itr|
    #n = gets.to_i

    #q = gets.rstrip.split(' ').map(&:to_i)
    #puts 22

    #puts minimum_bribes2(q)
#end


# 3
# q = '2 1 5 3 4'.split(' ').map(&:to_i)

# Too chaotic
# q = '2 5 1 3 4'.split(' ' ).map(&:to_i)

# 8
q = '1 2 5 3 7 8 6 4'.split(' ' ).map(&:to_i)

result = minimum_bribes(q)


puts "\n\n"
puts result
