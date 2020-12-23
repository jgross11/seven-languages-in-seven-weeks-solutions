# Find out how to access files with and without code blocks

# with - seems less obvious what is going on, as 'for each' is occuring in the block,
# but only one element is being used, which makes for *each* redundant
File.open('test.txt', 'w'){|f| f.write('hello file written from block')}

# without - much clearer what is going on, easier to read
File.open('test2.txt', 'w').write('hello file written from without block')



# Translate a hash to an array

# given hash, key => value
hash = {1 => 'one', 2 => 'two'}

# initially empty array
arr = []

# array value whose index will be this key in hash
index = 0

# for each key, value in hash
hash.each do
    # take value from hash pair and place in array at index
    |x| arr[index] = x[1]

    # increment index value
    index+=1
end

# print initial hash
puts hash

# print created array
puts arr

# custom array print
# arr.each{|x| puts x}

# custom hash print
# hash.each{|x| puts "#{x[0]} maps to #{x[1]}"}



# Can you translate arrays to hashes?
# yes, but unless the keys are specified somehow, the most immediate way involves making the array index the key...

# array to translate
arr = ['one', 'two']

# hash to translate to
hash = {}

# for each element in the array, find its index, and make that index the key in the hash, 
# storing the element as the value in the hash
arr.each{|x| hash[arr.find_index(x)] = x}

# print translated hash
puts hash



# Can you iterate through a hash?
# Yes...
hash = {0=>'zero', 'one'=>1, 'two'=>'two', 3=>3}
puts hash
hash.each{|pair| puts "#{pair[0]}------->#{pair[1]}"}

# or alternatively
hash.each{|k, v| puts "#{k}--->#{v}"}



# Print the contents of an array, four numbers at a time, using just each

# populate array
(0..15).each{|x| arr[x] = x}

# current number of elements printed on this line
count=1
string = ''

# for each element in array
arr.each do |x|

    # add element to print string
    string += "#{x } "

    # if time for new line
    if count % 4 == 0

        # print current line
        puts string

        # reset print string
        string = ''
    end

    # increment number for line end detection
    count += 1
end



# Print the contents of an array, four numbers at a time, using each_slice in Enumerable

# for each subarray of size 4 
(0..15).to_a.each_slice(4) do |x| 

    # print each element with space to current line
    x.each{|y| print "#{y} "}

    # new line
    puts
end

# Modify the example Tree class to allow the initializer to a nested structure of hashes
class Tree
    attr_accessor :children, :node_name

    def initialize(hash)

        # first hash key is node name
        @node_name = hash.keys.first

        # children are initially empty
        @children = []

        # for each subhash in hash value,  create new 'tree' from subhash key => value and append to this node's children
        hash[@node_name].each{|key, value| @children.append(Tree.new( key=>value ))}
    end

    def visit_all(&block)
        visit &block
        children.each{|c| c.visit_all &block}
    end

    def visit(&block)
        block.call self
    end
end

# create tree from problem description
test = Tree.new({  "Grandpa"=> 
                        {
                        "Father"=> 
                            {"Child 1"=>{}, "Child 2"=>{} }, 
                        "Uncle"=> 
                            {"Child 3"=>{}, "Child 4"=>{} } 
                        } 
                })
# print each node's name in recursive order
test.visit_all{|node| puts node.node_name}



# Write a simple grep that will print the lines of a file having any occurence of a phrase occurring anywhere in that line

# phrase to search for
pattern = /a/

# start on line #1
line_count = 1;

# read each line in the text file
File.foreach("rtwpchapt1.txt") do |line| 
    # indicate that phrase exists in the current line if the pattern is found in the line
    puts "Line #{line_count} contains #{pattern}: #{line}" if line.match(pattern)

    # increment line count 
    line_count += 1
end


