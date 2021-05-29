# enhance the XML program to add spaces to show the indentation structure

# enhance the XML program to handle attributes: 
# if the first argument is a map (use curly brace syntax), add attributes to the XML program
# for example, book({"author":"Tate"}) would print <book author="Tate">

Builder := Object clone
Builder tabTimes := 0

# string concat not in language guide???
# found after the fact: "hello, " .. "world" = "hello, world"...
# why .. and not +, a la 
# Sequence + := method(other, self .. other)
# seriously, wtf

# print a predetermined amount of tabs 
Builder format := method(
    for(i, 0, tabTimes - 1, "\t" print)
)

/*
TODO day 3 exercise 3
OperatorTable addAssignOperator(":", "attributePairing")

Sequence attributePairing := method(
    "no" println
)
curlyBrackets := method(
    result := Map clone
    call message arguments foreach(
        arg, 
        arg println;
        result doMessage(arg)
    )
    result
)

# {"author": "tate"} println
*/
Builder forward := method(
    # indent opening tag
    self format()
    writeln("<", call message name, ">")
    # increment number of indents
    tabTimes = tabTimes + 1
    call message arguments foreach(
        arg, 
        content := self doMessage(arg);
        if(content type == "Sequence", 
        
        # indent before writing
        self format() writeln(content)))

        # decrement number of indents
        tabTimes = tabTimes - 1

    # indent closing tag
    self format()
    writeln("</", call message name, ">"))

Builder ul(
    li("Io"),
    li("Lua"),
    li("Javascript")
)

# Builder book({"author": "Tate"})


# Create a list syntax that uses brackets

# not immediately certain how to mimic a[i] = 4, as a[i] will return a Number...
# so this acts as both a get and set 
# a[i] returns the value at index i
# a[i, x] puts the value x at index i
List squareBrackets := method(index, newValue, 
    
    # if valid index is given
    if(index type == Number type and index > -1 and index < self size) then(
        
        # if no new value is given
        if(call message arguments size == 1) then(
            
            # get mode, just return value at index
            return at(index)
        ) else(
            
            # set mode, put new value at index
            atPut(index, newValue)
        )
    ) else(

        # invalid index exception
        Exception raise("invalid index: #{index}" interpolate)
    )
)
test := List clone
test append(1)
test append(2)
test append(3)

# populate list
for(i, 0, test size - 1, 
    test[i] println
)

# double elements in list
for(i, 0, test size - 1, 
    test[i, test[i] * 2]
    test[i] println
)

