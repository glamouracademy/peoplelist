class PeopleData
  def initialize
  end

  def display
    File.foreach("inputdata/pipe.txt") { |line| print line } 
  end
end

class Person
  attr_accessor :lastname, :firstname, :middleinitial, :gender, :color, :dob

  def self.from_pipe_people(pipe_people)
    people = []
    pipe_people.each_line do |line|
      attributes = line.split(/ | /)
      people << {
      :lastname => attributes[0], 
      :firstname => attributes[1],
      :middleinitial => attributes[2], 
      :gender => attributes[3], 
      :color => attributes[4], 
      :dob => attributes[5],
      }
    end
    return people
  end
end

# for array list item,regex the info out into a hash (line 13-15)

