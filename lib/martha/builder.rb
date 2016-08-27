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
      if File.file?(file_name)
        greetings
        method_quantity file_name
      else
        error
      end
    end

    private

    def greetings
      puts "Martha: Hello I'm Martha!"
      puts "Martha: With whom I have the pleasure?"
      print "You: "
      @author = STDIN.gets.chomp
      puts "Martha: Hello #{@author}!"
      puts "Martha: Let me manage this code for you."
    end

    def method_quantity(file_name)
      file = File.open(file_name)
      file.each_line do |line|
        @file_info << line
      end
      binding.pry
    end

    def error
      puts "Martha: I'm sorry, but the file doesn't exist"
    end
  end
end
