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
      @output = ""
      @method_info = []
    end

    desc 'manage FILE_NAME', 'It documents code'
    def reveal(file_name)
      @file_name = file_name
      if File.file?(@file_name)
        greetings
        puts "I found #{method_quantity_cpp} methods/functions\n\n"
        document_methods
      else
        error
      end
    end

    private

    def write_on(file: '', mode: 'a')
      if block_given?
        File.open(file, mode) do |file_|
          file_.write yield
        end
      end
    end

    def document_methods
      File.open(@file_name, 'w') { |file|
        @file_info.each do |line|
          if function?(line)
            fill_method_info line
            @method_info.each do |line|
              file.write("#{line}")
            end
            @method_info
            file.write("#{line}")
          else
            file.write("#{line}")
          end
        end
      }
    end

    def fill_method_info(line)
      puts "For the following method/function:\n\n"
      puts "         #{line}"
      puts "\nWrite your method/function description(What does it do?)\n"
      print "Description: "
      @description = STDIN.gets.chomp
      puts "\nWrite your method/function output(what does it returns?)\n"
      print "Output:"
      @output = STDIN.gets.chomp
      write_method_info line
    end

    def write_method_info(line)
      @method_info = []
      @method_info << "/*\n"
      title = line.split('(')[0].split(' ')[1]
      input = line.split('(')[1].chop
      input[input.size-1] = ''
      @method_info << "Title: #{title}\n"
      @method_info << "Input: #{input}\n"
      @method_info << "Output: #{@output}\n"
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
    end

    def method_quantity_cpp
      method_quantity = 0
      file = File.open(@file_name)
      file.each_line do |line|
        @file_info << line
        method_quantity += 1 if function?(line)
      end
      method_quantity
    end

    def function?(line)
      if line.include?('(')
        header = line.split('(')[0]
        header.split(' ').size == 2 && header.split(' ').first != "else"
      end
    end

    def error
      puts "I'm sorry, but the file doesn't exist"
    end
  end
end
