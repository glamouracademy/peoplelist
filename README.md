peoplelist
==========

This is written in Ruby 1.9.3p448.

This program takes in three delimited files: pipe-delimited, comma-delimited, and space-delimited and outputs consolidated data from those three files. 

There are three outputs available and all outputs require that you type the path to the script: `ruby app/people.rb` from the command line.

Output 1
To return an output where the data is "sorted by gender (females before males) then by last name ascending", from the command line please type "gender" after the script: `ruby app/people.rb gender`

Output 2
To return an output where the data is "sorted by birth date, ascending", from the command line please type "birthdate" after the script: `ruby app/people.rb birthdate`

Output 3
To return an output where the data is "sorted by last name, descending", from the command line please type "lastname" after the script: `ruby app/people.rb lastname`


Lastly, if you would like to run the tests, please type the path to the test script: `ruby test/test.rb` from the command line.