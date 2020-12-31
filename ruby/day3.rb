class ActsAsCsv

    # reads file as csv
    def read
        file = File.new(self.class.to_s.downcase + '.txt')
        @headers = file.gets.chomp.split(', ')

        file.each do |row|
            # append new csv row object to this file's row variable
            @rows << CsvRow.new(@headers, row.chomp.split(', '))
        end
    end

    def headers 
        @headers
    end

    def csv_contents
        @rows
    end

    def initialize
        @rows = []
        read
    end

    # each must iterate each row in row variable
    def each(&block)
        @rows.each do |row| block.call row end
    end
end

class CsvRow
    def initialize(header, row)
        # create initial row, header arrays (sloppy)
        # in other class, perhaps creating a hash with key of header and value of all row items with that header would be better, but oh well
        @result = []
        @header = []

        # insert each item and its corresponding header into object arrays
        header.each_with_index{|element,index|
            @result[index] = row[index]
            @header[index] = element
        }
    end

    def result
        @result
    end

    def print
        puts @result
    end

    # assumes [name] is actually a header
    # finds all row elements under that header
    def method_missing name, *args

        # attempt to find index of header name in column array
        index = @header.find_index(name.to_s)

        # return value of that column in given row unless index not found
        return @result[index] unless index.nil?

        # if index is invalid, return error message
        "Header not found"
    end
end

class RubyCsv < ActsAsCsv
end

# create new csv object
m = RubyCsv.new

# find all row elements under header header1
m.each do |x|
    puts x.header1
end