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

