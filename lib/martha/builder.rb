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
    end

    desc 'manage FILE_NAME', 'It documents code'
    def reveal(file_name)
      @file_name = file_name
      if File.file?(@file_name)
        greetings
        puts "I found #{method_quantity_cpp} methods/functions\n\n"
        puts "Documenting methods/functions...\n\n"
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
            file.write(method_info)
            file.write("#{line}")
          else
            file.write("#{line}")
          end
        end
      }
    end

    def method_info

    end

    def greetings
      puts "Martha: Hello I'm Martha!\n\n"
      puts "Martha: With whom I have the pleasure?\n\n"
      print "You: "
      @author = STDIN.gets.chomp
      puts "Martha: Hello #{@author}!\n\n"
      puts "Martha: Let me reveal this code for you.\n\n"
      puts "Revealing...\n\n"
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
      puts "Martha: I'm sorry, but the file doesn't exist"
    end
  end
end
