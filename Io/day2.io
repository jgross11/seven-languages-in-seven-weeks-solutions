# fib sequence as loop and also recursion

# container object
Fib := Object clone

# looper method
Fib looper := method(n,
    if(n < 3, return 1, 
        currentTerm := 0
        temp := 0
        nextTerm := 1
        for(counter, 1, n-1, 1, 
            temp = nextTerm
            nextTerm = nextTerm + currentTerm
            currentTerm = temp
        )
        return nextTerm
    ) 
)

# recursion method
Fib recurse := method(n,
    if (n < 3) then (return 1) else (return Fib recurse(n-1) + Fib recurse(n-2))
)

# test
Fib looper(6) println
Fib recurse(6) println

# change / to return 0 if denom is 0

# copy division as it stands
Number baseDiv := Number getSlot("/")

# new definition based on old definition
# question: how to find code explanation for what / currently does?
Number / = method(n, if (n==0, return 0, self baseDiv(n)))

# tests
(4 / 1.2) println
(2 / 0) println

# print all numbers in a two dimensional array

# create row 0
myList := List clone

# create arbitrary size array
listSize := 5
listDepth := 7

# populate 2 dimensional array with numbers

# for 0.. listSize - 1
for(counter, 0, listSize-1, 

    # create new list element
    element := List clone

    # for 0.. listDepth - 1
    for(counter2, 0, listDepth-1,

        # insert counter2 into list
        element append(counter2)
    )

    # add populated list to OG list
    myList append (element)
)

# iterate over array and print results

# for 0.. listSize - 1
for(counter, 0, listSize-1, 

    # get list at index
    element := myList at(counter)

    # for 0.. counter2
    for(counter2, 0, listDepth-1,

        # print element
        element at(counter2) print
    )

    # new line
    "" println
)

# add a slot called myAverage to a list that computes the average of all the numbers in the list

List myAverage := method(
    # if list is empty, print error message and return
    if(self size < 1) then(
        "No elements in list" println
        return
    )

    # init sum to 0
    sum := 0

    # for each element in list
    for(counter, 0, (self size) - 1, 1, 
        # if element is not a number
        if(self at(counter) type != 2 type) then (
            # print error message and return
            ("Element in list not a number at index #{counter}" interpolate) println
            return

        # otherwise add element to sum
        ) else(
            sum = sum + (self at(counter))
        )
    )

    # print average
    (sum / self size) println
)
# test non-number element
errorList := list(1, 2, 3, "he", 5, 6)
errorList myAverage

# test valid list
validList := list(1, 2, 3, 4, 5, 6)
validList myAverage

# test empty list
emptyList := list()
emptyList myAverage

# write a prototype for a 2-dimensional list. dim(x, y) method should create a list of y lists that are x elements long. set(x,y) sets, get(x,y) gets

# create object clone
2DList := Object clone

# upon cloning of this proto, init base list to be used in other methods
2DList init := method(
    self baseList := list clone
)

# create the x by y list from the given x, y vals
2DList dim := method(x, y, 
    for(counter, 0, y-1, 
        self newList := list clone
        for(counter2, 0, x-1,
            self newList append(0)
        )
        self baseList append(newList)
    )
)

# get the value at the given x, y index
2DList get := method(x, y,
    if (y > -1 and y < (self baseList size) and x > -1 and x < (self baseList at(0) size)) then(
        return self baseList at (y) at(x)
    ) else (
        "Invalid position given" println
    )
)

# set the given value at the given x, y index
2DList set := method(value, x, y,  
    if (y > -1 and y < (self baseList size) and x > -1 and x < (self baseList at(0) size)) then(
        baseList at (y) atPut(x, value)
    ) else (
        "Invalid position given" println
    )
)

# bonus: write a transpose method so transpose get(x, y) == get(y, x) 
2DList transpose := method(
    # create list that will be transposed copy
    result := 2DList clone

    # init to correct (swapped) dimensions
    result dim(self baseList size, self baseList at(0) size)

    # iterate through this list and place elements in appropriate transpose index
    for(x, 0, baseList size - 1, 
        for(y, 0, baseList at(0) size -1, 
            result set(get(y, x), x, y)
        )
    )

    return result
)

# print contents of list 
2DList printList := method(
    for(x, 0, self baseList size - 1, 
        for(y, 0, self baseList at(0) size - 1, 
            get(y, x) print
            "\t" print
        )
        "" println
    )
)

# write the list to a file
# NOTE: list values cannot contain | as it is used as the value delimiter
2DList writeToFile := method(filename, 

    # open file
    file := File with(filename)
    
    # delete any existing contents in file
    file remove

    # set update capability
    file openForUpdating

    # iterate through list
    for(x, 0, self baseList size - 1, 
        for(y, 0, self baseList at(0) size - 1, 
            
            # write list content as string
            file write(get(y, x) asString)
            file write("|")
        )

        # end of row
        file write("\n")
    )

    # close file
    file close
)

# read the list from a file
# NOTE: file values cannot contain | as it is used as the value delimiter
2DList readFromFile := method(filename, 

    # attempt to open file
    file := File with(filename)

    # set read capability
    file openForReading

    # read contents
    fileContents := file contents

    # delimiter code
    delimiter := "|" at(0)

    # assume first character is part of a value
    trimStart := 0

    # create list to return
    result := 2DList clone

    # create row
    row := list clone

    # iterate file contents
    for(i, 0, fileContents size -1,

        # obtain character at current position
        val := fileContents at(i) 

        # if newline character
        if(val == "\n" at (0))then(

            # row is totally read, so append row to new list
            result baseList append(row)

            # previous character is |, so first value on next line will contain "\n"
            # so, simply move start of next value past this character
            trimStart = i+1

            # reset row
            row = list clone
        ) else(

            # if | (value separator)
            if(val == delimiter)then(

                # reached the end of a value, so extract value from fileContents
                row append(fileContents exSlice(trimStart, i))

                # place start of new value at next index in fileContents
                trimStart = i+1
            ) else( continue )
        )
    )

    # return constructed list
    return result
)

# testing
test2DList := 2DList clone
test2DList dim(3, 3)
test2DList get(1,2) println
test2DList set("hello", 0, 0)
test2DList set("middle", 1, 1)
test2DList set("top right", 2, 0)
test2DList set("bottom left", 0, 2)
test2DList set("world", 2, 2)
test2DList get(1,2) println

"\nPrinting original list\n" println
test2DList printList

"\nPrinting transpose list\n" println
transposeList := test2DList transpose
transposeList printList

/*transposeList set (0, 0, 0)
transposeList set (2, 1, 1)
transposeList set (4, 2, 0)
transposeList set ("hello", 0, 2)
transposeList set (7, 2, 2)*/

# writing
transposeList writeToFile("test.txt")
a := 2DList readFromFile("test.txt")

"\nPrinting list read from file\n" println
a printList


# write a program that gives ten tries to guess a random number between 1 and 100
# give a hint of hotter / colder after the first guess

# generate random number between 0 and 100
value := (Random value * 100) round

guess := 0
prevGuess := 0

# can guess 10 times
for(guessNumber, 0, 9,

    # get user input
    "\nEnter guess #{guessNumber + 1}: " interpolate println
    guess = File standardInput readLine asNumber

    # print input
    "Entered: " print
    guess println

    # if guess is correct
    if(guess == value) then(

        # alert user, end game
        "You guessed correctly! " println
        break
    ) else(

        # if guess is closer to value than last guess,
        # alert user accordingly
        if((guess - value) abs < (prevGuess - value) abs) then(
            "Warmer" println
        ) else(
            "Colder" println
        )
    )

    # make current guess previous guess for next guess
    prevGuess = guess
)

# print value
"Value = #{value}" interpolate println