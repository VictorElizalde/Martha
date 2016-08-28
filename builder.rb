require 'thor'
require 'pry'
require 'nokogiri'

module Martha
  class Builder < Thor
    include Martha
    include Thor::Actions

#Title: initialize
#Input: args = [], local_options = {}, config = {}
#Input Description: a
#Output Description: a
#Description: a
#Author: Victor
    def initialize(args = [], local_options = {}, config = {}) #method
      super
      @author = "Victor Elizalde"
      @file_info = []
      @description = ""
      @output_description = ""
      @input_description = ""
      @method_info = []
    end

    desc 'manage FILE_NAME', 'It documents code'
#Title: reveal
#Input: file_name
#Input Description: a
#Output Description: a
#Description: a
#Author: Victor
    def reveal(file_name) #method
      @file_name = file_name
      if File.file?(@file_name)
        greetings
        if file_name.split('.')[1] == "cpp"
          puts "I found #{method_quantity_cpp} undocumented method(s)/function(s)\n\n"
          document_methods_cpp
        else
          puts "I found #{method_quantity_rb} undocumented method(s)/function(s)\n\n"
          document_methods_rb
        end

      else
        error
      end
    end

    private

#Title: document_methods_cpp
#Input: ()
#Input Description: a
#Output Description: a
#Description: a
#Author: Victor
    def document_methods_cpp #method
      File.open(@file_name, 'w') { |file|
        @file_info.each do |line|
          if cpp_function?(line)
            fill_method_info line
            @method_info.each do |line|
              file.write("#{line}")
            end
            file.write("#{line.chop} //function\n")
          else
            file.write("#{line}")
          end
        end
      }
    end

#Title: document_methods_rb
#Input: ()
#Input Description: a
#Output Description: a
#Description: a
#Author: Victor
    def document_methods_rb #method
      File.open(@file_name, 'w') { |file|
        @file_info.each do |line|
          if rb_function?(line)
            fill_method_info line
            @method_info.each do |line|
              file.write("#{line}")
            end
            file.write("#{line.chop} //function\n")
          else
            file.write("#{line}")
          end
        end
      }
    end

#Title: fill_method_info
#Input: line
#Input Description: a
#Output Description: a
#Description: a
#Author: Victor
    def fill_method_info(line) #method
      puts "For the following method/function:\n\n"
      puts "         #{line}"
      print "\nInput Description (What does it receives?)\nYour Answer: "
      @input_description = STDIN.gets.chomp
      print "\nOutput Description (What does it returns?)\nYour Answer: "
      @output_description = STDIN.gets.chomp
      print "\nDescription (What does the method does?)\nYour Answer: "
      @description = STDIN.gets.chomp
      puts "\n"
      write_method_info line
    end

#Title: write_method_info
#Input: line
#Input Description: a
#Output Description: a
#Description: a
#Author: Victor
    def write_method_info(line) #method
      @method_info = []
      @method_info << "/*\n"
      title = line.split('(')[0].split(' ')[1]
      input = line.split('(')[1].chop
      input[input.size-1] = ''
      output = line.split('(')[0].split(' ')[0]
      @method_info << "Title: #{title}\n"
      @method_info << "Input: #{input}\n"
      @method_info << "Input Description: #{@input_description}\n"
      @method_info << "Output: #{output}\n"
      @method_info << "Output Description: #{@output_description}\n"
      @method_info << "Description: #{@description}\n"
      @method_info << "Author: #{@author}\n"
      @method_info << "*/\n"
      @method_info
    end

#Title: greetings
#Input: ()
#Input Description: a
#Output Description: a
#Description: a
#Author: Victor
    def greetings #method
      puts "Hello I'm Martha!\n\n"
      puts "With whom I have the pleasure?\n\n"
      print "Your Name: "
      @author = STDIN.gets.chomp
      puts "\n"
    end

#Title: method_quantity_cpp
#Input: ()
#Input Description: a
#Output Description: a
#Description: a
#Author: Victor
    def method_quantity_cpp #method
      method_quantity = 0
      file = File.open(@file_name)
      file.each_line do |line|
        method_quantity += 1 if cpp_function?(line)
        @file_info << line
      end
      method_quantity
    end

#Title: method_quantity_rb
#Input: ()
#Input Description: a
#Output Description: a
#Description: a
#Author: Victor
    def method_quantity_rb #method
      method_quantity = 0
      file = File.open(@file_name)
      file.each_line do |line|
        method_quantity += 1 if rb_function?(line)
        @file_info << line
      end
      method_quantity
    end

#Title: cpp_function?
#Input: line
#Input Description: 
#Output Description: a
#Description: aa
#Author: Victor
    def cpp_function?(line) #method
      if line.include?('(') && !line.include?('//function')
        header = line.split('(')[0]
        header.split(' ').size == 2 && header.split(' ').first != "else" && header.split(' ').last != "main"
      end
    end

#Title: rb_function?
#Input: line
#Input Description: a
#Output Description: a
#Description: 
#Author: Victor
    def rb_function?(line) #method
      line.split(' ')[0] == "def"
    end

#Title: error
#Input: ()
#Input Description: a
#Output Description: aa
#Description: 
#Author: Victor
    def error #method
      puts "I'm sorry, but the file doesn't exist"
    end
  end
end
