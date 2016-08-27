require 'thor'
require 'pry'
require 'nokogiri'

module Vicky
  # Vicky Commandline App
  class Builder < Thor
    include Vicky
    include Thor::Actions

    def initialize(args = [], local_options = {}, config = {})
      super
      @author = ""
    end

    desc 'hola', 'It documents code'
    def hola
      puts "Wasup"
    end
  end
end
