require 'date'

class PeopleData
  def file_reader(datafile)
    File.open(datafile).read 
  end

  def display_pipers
    file_reader("inputdata/pipe.txt")
  end

  def display_commars 
    file_reader("inputdata/comma.txt")
  end

  def display_spacers 
    file_reader("inputdata/space.txt")
  end
end

class Person
  attr_accessor :lastname, :firstname, :middleinitial, :gender, :color, :dob

  def initialize(params)
    params.each do |key,value|
      instance_variable_set("@#{key}",value)
    end

    @dob = @dob.strip.gsub(/[\/]/,'-')
    @dob = Date.strptime(@dob, '%m-%d-%Y')
    
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
  if sort_order != "gender" && sort_order != "birthdate" && sort_order != "lastname" 
    return puts "Howdy! Please type a sort order: gender, birthdate, or lastname."
  end
  
  peoplehash = []

  peoplehash.concat(Person.from_pipe_people(PeopleData.new.display_pipers))
  peoplehash.concat(Person.from_comma_people(PeopleData.new.display_commars))
  peoplehash.concat(Person.from_space_people(PeopleData.new.display_spacers))

  person = peoplehash.map do |peoplehash|
    Person.new(peoplehash)
  end

  if sort_order == "gender" 
    person.sort_by! { |personentry| [personentry.gender, personentry.lastname] }
    person.each do |personentry|
    end

  elsif sort_order == "birthdate"
    person.sort_by! { |personentry| [personentry.dob, personentry.lastname] }
    person.each do |personentry|
    end

  else sort_order == "lastname"
    person.sort_by! { |personentry| personentry.lastname }
    person.reverse!
    person.each do |personentry|
    end
  end

  person.each do |personentry|
    formatted_date = personentry.dob.strftime("%-m/%-d/%Y")
    puts "#{personentry.lastname} #{personentry.firstname} #{personentry.gender} #{formatted_date} #{personentry.color}"
  end
end

if __FILE__==$0
  process ARGV[0]
end

