class PeopleData
  def initialize
  end

  def display
    File.foreach("inputdata/pipe.txt") { |line| print line } 
  end
end

class Person
  def self.from_pipe_people(pipe_people)
    people = []
    pipe_people.each_line do |line|
    people << Person.new
    end
    return people
  end
end

