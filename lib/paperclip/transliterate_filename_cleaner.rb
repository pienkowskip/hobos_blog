# encoding: utf-8
require 'active_support/inflector/transliterate'

module Paperclip
  class TransliterateFilenameCleaner
    def initialize(invalid_character_regex)
      @invalid_character_regex = invalid_character_regex
    end

    def call(filename)
      filename = if @invalid_character_regex
                   filename.gsub(@invalid_character_regex, '_')
                 else
                   filename
                 end
      filename = ActiveSupport::Inflector.transliterate(filename)
      File.basename(filename, File.extname(filename)) + File.extname(filename).downcase
    end
  end
end
