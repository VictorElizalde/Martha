require 'thor'
require 'pry'
require 'nokogiri'

module Martha
  class Builder < Thor
    include Martha
    include Thor::Actions

    def initialize(args = [], local_options = {}, config = {})
      super
      @author = "Victor Elizalde"
      @file_info = []
      @description = ""
      @output_description = ""
      @input_description = ""
      @method_info = []
    end

    desc 'manage FILE_NAME', 'It documents code'
    def reveal(file_name)
      @file_name = file_name
      if File.file?(@file_name)
        greetings
        puts "I found #{method_quantity_cpp} undocumented methods/functions\n\n"
        document_methods
      else
        error
      end
    end

    private

    def document_methods
      File.open(@file_name, 'w') { |file|
        @file_info.each do |line|
          if function?(line)
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

    def fill_method_info(line)
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

    def write_method_info(line)
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

    def greetings
      puts "Hello I'm Martha!\n\n"
      puts "With whom I have the pleasure?\n\n"
      print "Your Name: "
      @author = STDIN.gets.chomp
      puts "\n"
    end

    def method_quantity_cpp
      method_quantity = 0
      before_line = ""
      file = File.open(@file_name)
      file.each_line do |line|
        method_quantity += 1 if function?(line)
        @file_info << line
      end
      method_quantity
    end

    def function?(line)
      if line.include?('(') && !line.include?('//function')
        header = line.split('(')[0]
        header.split(' ').size == 2 && header.split(' ').first != "else" && header.split(' ').last != "main"
      end
    end

    def error
      puts "I'm sorry, but the file doesn't exist"
    end
  end
end
