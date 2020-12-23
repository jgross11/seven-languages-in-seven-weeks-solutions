# Print the string "Hello, world."
puts 'Hello, world.'

# For the string "Hello, Ruby," find the index of the string "Ruby."
puts "The index of 'Ruby' in 'Hello, Ruby' is #{'Hello, Ruby'.index('Ruby')}"

# Print your name ten times.
for i in 1..10
    puts 'Josh G'
end

# Print the string "This is a sentence number 1," where the number 1 changes from 1 to 10.
for i in 1..10
    puts "This is a sentence number #{i}"
end

# Run a Ruby program from a file.
puts "command to run this program: ruby day1.rb"

# Bonus: Write a program that picks a random number. Let a player guess the number, telling the player whether the guess is too low or too high.

# generated random number
num = rand(10)

# get guess
puts "Enter guess"
guess = gets().to_i

# repeat until guess is correct
until guess == num do

    # guess is too high
    puts "Guess is too high" if guess > num
    
    # guess is too low
    puts "Guess is too low" if guess < num
    
    # get next guess
    puts "Enter next guess"
    guess = gets().to_i
end

# correct guess achieved
puts "Correct!"