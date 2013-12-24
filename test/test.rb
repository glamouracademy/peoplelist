require 'minitest/spec'
require 'minitest/autorun'
require_relative '../app/people'

describe PeopleData do
  it "should be created" do
    PeopleData.new.must_be_instance_of PeopleData
  end

  it "should print the contents of a given file" do
    proc { PeopleData.new.display }.must_output("Smith | Steve | D | M | Red | 3-3-1985
Bonk | Radek | S | M | Green | 6-3-1975
Bouillon | Francis | G | M | Blue | 6-3-1975")
  end
end

describe Person do
  it "should create 3 people from a file with 3 lines" do
   people = Person.from_pipe_people("Smith | Steve | D | M | Red | 3-3-1985
Bonk | Radek | S | M | Green | 6-3-1975
Bouillon | Francis | G | M | Blue | 6-3-1975")
   people.wont_be_empty
   people.size.must_equal 3
  end

  it "should return the pipe people information for each person in an array of hashes" do
    people = Person.from_pipe_people("Smith | Steve | D | M | Red | 3-3-1985
Bonk | Radek | S | M | Green | 6-3-1975
Bouillon | Francis | G | M | Blue | 6-3-1975")
    people.first[:lastname].must_equal("Smith")
  end

end


# option1
# - line delination as 3 objects
# - break down each line into components (array, hash)
# - each collection of components is a person


 
# (TRANSFORM) Get all three files to output

# (TRANSFORM) Get all three files to output the fields are in the same order (last name, first name, gender, date of birth, favorite color)

# (TRANSFORM) Display dates in the format M/D/YYYY



# describe People do
#   it "should" do
#     People.new.must_include(other)
#   end
# end

# get file, read file, for each instance of person create new instance of people

# (INPUT) Get comma file to output records and info

# (INPUT) Get space file to output records and info



# Output 1 – sorted by gender (females before males) then by last name ascending

# Output 2 – sorted by birth date, ascending.

# Output 3 – sorted by last name, descending.

# what command should we do?  1 for all options or corresponding command per option
