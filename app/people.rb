
##collection
# put data hashes into people hash in process (figure out what the syntax is)
# refactor how respective data gets into the peoplehash
# combine above steps 
## make peoplehash new people

# space.txt

# method display input - three methods, internal method that calls filename
# output display


require 'date'

class PeopleData
  def initialize
  end

  def display_pipers 
    File.open("inputdata/pipe.txt").read
  end

  def display_commars 
    File.open("inputdata/comma.txt").read
  end

  def display_spacers 
    File.open("inputdata/space.txt").read
  end
end

# blargh
class Date
  def initialize(params)
    params.each do |key,value|
      instance_variable_set("@#{key}",value)
    end
  end

  def format
    @dob = Date.strptime(@dob, '%m-%d-%Y')
    @dob.gsub!(/[-]/,'/')
    puts @dob
  end
end

class Person
  attr_accessor :lastname, :firstname, :middleinitial, :gender, :color, :dob

  def initialize(params)
    params.each do |key,value|
      instance_variable_set("@#{key}",value)
    end

    if @gender == "F" || @gender == "Female"
    @gender = "Female"
    elsif @gender == "M" || @gender == "Male"
    @gender = "Male"
    else
      "Whoops!  A person in your file does not have a gender."
    end
  end

  def self.from_pipe_people(pipe_people)
    pipehash = []
    pipe_people.each_line do |line|      
      params = line.split(" | ") 
      pipehash << {
      :lastname => params[0], 
      :firstname => params[1],
      :middleinitial => params[2], 
      :gender => params[3], 
      :color => params[4], 
      :dob => params[5]
      }
    end
    return pipehash
  end

  def self.from_comma_people(comma_people)
    commahash = []
    comma_people.each_line do |line|
      params = line.split(", ")
      commahash << {
        :lastname => params[0],
        :firstname => params[1],
        :gender => params[2],
        :color => params[3],
        :dob => params[4]
      }
    end
    return commahash
  end

  def self.from_space_people(space_people)
    spacehash = []
    space_people.each_line do |line|
      params = line.split(" ")
      spacehash << {
        :lastname => params[0],
        :firstname => params[1],
        :middleinitial => params[2],
        :gender => params[3],
        :dob => params[4],
        :color => params[5]
      }
    end
    return spacehash
  end
end

def process(sort_order)

#1. get data in --> array of hashes
  # pipehash = Person.from_pipe_people(PeopleData.new.display_pipers)
  # people = Person.from_comma_people(PeopleData.new.display_commars)

#2. get data together --> array of hashes

  peoplehash = []

  peoplehash.concat(Person.from_pipe_people(PeopleData.new.display_pipers))
  peoplehash.concat(Person.from_comma_people(PeopleData.new.display_commars))
  peoplehash.concat(Person.from_space_people(PeopleData.new.display_spacers))
  
#3. create Persons 

  person = peoplehash.map do |peoplehash|
    Person.new(peoplehash)
  end

  if sort_order == "gender" 
    person.sort_by! { |personentry| [personentry.gender, personentry.lastname] }
    person.each do |personentry|
      puts personentry.inspect
    end

  elsif sort_order == "birthdate"
    person.sort_by! { |personentry| personentry.dob }
    person.each do |personentry|
      puts personentry.inspect
    end

  elsif sort_order == "lastname"
    person.sort_by! { |personentry| personentry.lastname }
    person.reverse!
    person.each do |personentry|
      puts personentry.inspect
    end
    
  else
    puts "Howdy! Please type a sort order: gender, birthdate, or lastname."
  end

  person.each do |personentry|
    puts "#{personentry.lastname} #{personentry.firstname} #{personentry.gender} #{personentry.dob} #{personentry.color}"
  end
end

process ARGV[0]






# for array list item,regex the info out into a hash (line 13-15)
