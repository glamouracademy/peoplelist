require 'minitest/spec'
require 'minitest/autorun'
require_relative '../app/people'

describe "the script" do
  it "should process the data sorted by females before males last name ascending when 'gender' is passed to the script" do
    proc { process "gender" }.must_output("Hingis Martina Female 4/2/1979 Green
Kelly Sue Female 7/12/1959 Pink
Kournikova Anna Female 6/3/1975 Red
Seles Monica Female 12/2/1973 Black
Abercrombie Neil Male 2/13/1943 Tan
Bishop Timothy Male 4/23/1967 Yellow
Bonk Radek Male 6/3/1975 Green
Bouillon Francis Male 6/3/1975 Blue
Smith Steve Male 3/3/1985 Red
")
  end

  it "should process the data sorted by birthdate ascending when 'birthdate' is passed to the script" do
    proc { process "birthdate" }.must_output("Abercrombie Neil Male 2/13/1943 Tan
Kelly Sue Female 7/12/1959 Pink
Bishop Timothy Male 4/23/1967 Yellow
Seles Monica Female 12/2/1973 Black
Bonk Radek Male 6/3/1975 Green
Bouillon Francis Male 6/3/1975 Blue
Kournikova Anna Female 6/3/1975 Red
Hingis Martina Female 4/2/1979 Green
Smith Steve Male 3/3/1985 Red
")
  end

  it "should process the data sorted by lastname descending when 'lastname' is passed to the script" do
    proc { process "lastname" }.must_output("Smith Steve Male 3/3/1985 Red
Seles Monica Female 12/2/1973 Black
Kournikova Anna Female 6/3/1975 Red
Kelly Sue Female 7/12/1959 Pink
Hingis Martina Female 4/2/1979 Green
Bouillon Francis Male 6/3/1975 Blue
Bonk Radek Male 6/3/1975 Green
Bishop Timothy Male 4/23/1967 Yellow
Abercrombie Neil Male 2/13/1943 Tan
")
  end
end

describe PeopleData do
  it "should return the contents of a given pipe delimited file" do
    PeopleData.new.display_pipers.must_equal("Smith | Steve | D | M | Red | 3-3-1985
Bonk | Radek | S | M | Green | 6-3-1975
Bouillon | Francis | G | M | Blue | 6-3-1975")
  end

  it "should return the contents of a given comma delimited file" do
    PeopleData.new.display_commars.must_equal("Abercrombie, Neil, Male, Tan, 2/13/1943
Bishop, Timothy, Male, Yellow, 4/23/1967
Kelly, Sue, Female, Pink, 7/12/1959")
  end

  it "should return the contents of a given space delimited file" do
    PeopleData.new.display_spacers.must_equal("Kournikova Anna F F 6-3-1975 Red
Hingis Martina M F 4-2-1979 Green
Seles Monica H F 12-2-1973 Black")
  end
end

describe Person do

  describe "should return people information in an array of hashes" do
    
    it "for each of the pipe people" do
      people = Person.from_pipe_people("Smith | Steve | D | M | Red | 3-3-1985
  Bonk | Radek | S | M | Green | 6-3-1975
  Bouillon | Francis | G | M | Blue | 6-3-1975")
      people.first[:lastname].must_equal("Smith")
    end

    it "for each of the comma people" do
      people = Person.from_comma_people("Abercrombie, Neil, Male, Tan, 2/13/1943
  Bishop, Timothy, Male, Yellow, 4/23/1967
  Kelly, Sue, Female, Pink, 7/12/1959")
      people.first[:lastname].must_equal("Abercrombie")
    end

    it "for each of the space people" do
      people = Person.from_space_people("Kournikova Anna F F 6-3-1975 Red
  Hingis Martina M F 4-2-1979 Green
  Seles Monica H F 12-2-1973 Black")
      people.first[:lastname].must_equal("Kournikova")
    end  
  end

  it "should create a person with her/his attributes from his/her hash" do
    params = {
      :lastname => "Bouillon", 
      :firstname => "Francis",
      :middleinitial => "G", 
      :gender => "M", 
      :color => "Blue", 
      :dob => "6-3-1975"
      } 
    person = Person.new(params)        
    person.must_be_instance_of Person
    person.lastname.must_equal("Bouillon")
    person.firstname.must_equal("Francis")
    person.middleinitial.must_equal("G")
    person.color.must_equal("Blue")
  end

  it "should return gender in full text" do
    params = {
      :lastname => "Bouillon", 
      :firstname => "Francis",
      :middleinitial => "G", 
      :gender => "M", 
      :color => "Blue", 
      :dob => "6-3-1975"
    }
    person = Person.new(params)
    person.gender.must_equal("Male")
  end  

  it "should return dob as a date object" do
    params = {
      :lastname => "Abercrombie", 
      :firstname => "Neil",
      :gender => "Male", 
      :color => "Tan", 
      :dob => "2/13/1943"
    } 
    person = Person.new(params)
    person.dob.must_be_instance_of Date
    person.dob.must_equal(Date.new(1943,2,13))
  end
end
