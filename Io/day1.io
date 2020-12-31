# evaluate 1+1 and 1 + "one". Is Io strongly or weakly typed? 

# fine
1+1

# error - seems to be strongly typed
1 + "one"

# is 0 true or false? what about the empty string? nil? 

# evaluates to true, hence 0 is true
0 and true

# also evals true, hence all ints are true?
1 and true

# eval false
true not

# evals to nil, interesting
0 not

# eval true, empty string true
"" and true

# eval true, all string true
"false" and true

# How can you tell what slots a prototype supports?

# on a slot by slot basis, use getSlot - nil means the slot isn't supported
true getSlot("type") # true
true getSlot("asdgewrg") # nil

# generally, use proto
true proto

# What is the difference between =, :=, and ::=? When would you use each one?
# from https://iolanguage.org/guide/guide.html (ctrlf ::=):
# ::=	Creates slot, creates setter, assigns value
# :=	Creates slot, assigns value
# =	    Assigns value to slot if it exists, otherwise raises exception
# So, = is used only after ::= or := has been used to create the slot. Not yet sure precisely what a setter does in Io, so the distinction between ::= and := is currently unclear

# run an Io program from a file
# io day1.io 

# execute the code in a slot given its name

# a simple increment of car mileage

# create car object
Car := Object clone

# create mileage property
Car mileage := 0

# create increment mileage method
Car incrementMileage := method(
    Car mileage = Car mileage + 1
)

# call increment mileage method
Car incrementMileage    # Car mileage = 1
Car incrementMileage    # Car mileage = 2
Car incrementMileage    # Car mileage = 3

# and so on