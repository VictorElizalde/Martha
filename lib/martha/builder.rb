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
      @file_name = ""
    end

    desc 'reveal FILE_NAME', 'It documents code'
    def reveal(file_name)
      @file_name = file_name
      if File.file?(@file_name)
        greetings
        if file_name.split('.')[1] == "cpp"
          puts "I found #{method_quantity_cpp} undocumented method(s)/function(s)\n\n"
          document_methods_cpp
          puts "Finished documenting method(s)/function(s)"
        else
          puts "I found #{method_quantity_rb} undocumented method(s)/function(s)\n\n"
          document_methods_rb
          puts "Finished documenting method(s)/function(s)"
        end
      else
        error
      end
    end

    private

    def document_methods_cpp
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

    def document_methods_rb
      File.open(@file_name, 'w') { |file|
        @file_info.each do |line|
          if rb_function?(line)
            fill_method_info line
            @method_info.each do |line|
              file.write("#{line}")
            end
            file.write("#{line.chop} #method\n")
          else
            file.write("#{line}")
          end
        end
      }
    end

    def fill_method_info(line)
      puts "For the following method/function:\n\n"
      puts "         #{line}"
      print "\nInput Description (What does it receives?)\n\n     Your Answer: "
      @input_description = STDIN.gets.chomp
      print "\nOutput Description (What does it returns?)\n\n     Your Answer: "
      @output_description = STDIN.gets.chomp
      print "\nDescription (What does the method does?)\n\n       Your Answer: "
      @description = STDIN.gets.chomp
      puts "\n"
      if @file_name.split('.')[1] == "cpp"
        write_method_info_cpp line
      else
        write_method_info_rb line
      end
    end

    def write_method_info_rb(line)
      @method_info = []
      if line.include?('(')
        title = line.split('(')[0].split(' ')[1]
        input = line.split('(')[1].chop
        input[input.size-1] = ''
      else
        title = line.split(' ')[1]
        input = "()"
      end
      output = line.split('(')[0].split(' ')[0]
      @method_info << "#Title: #{title}\n"
      @method_info << "#Input: #{input}\n"
      @method_info << "#Input Description: #{@input_description}\n"
      @method_info << "#Output Description: #{@output_description}\n"
      @method_info << "#Description: #{@description}\n"
      @method_info << "#Author: #{@author}\n"
      @method_info
    end

    def write_method_info_cpp(line)
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
      file = File.open(@file_name)
      file.each_line do |line|
        method_quantity += 1 if cpp_function?(line)
        @file_info << line
      end
      method_quantity
    end

    def method_quantity_rb
      method_quantity = 0
      file = File.open(@file_name)
      file.each_line do |line|
        method_quantity += 1 if rb_function?(line)
        @file_info << line
      end
      method_quantity
    end

    def cpp_function?(line)
      if line.include?('(') && !line.include?('//function')
        header = line.split('(')[0]
        header.split(' ').size == 2 && header.split(' ').first != "else" && header.split(' ').last != "main"
      end
    end

    def rb_function?(line)
      line.split(' ')[0] == "def" && !line.include?('#method')
    end

    def error
      puts "I'm sorry, but the file doesn't exist"
    end
  end
end
