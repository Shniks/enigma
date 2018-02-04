require_relative 'rotator'
require 'pry'

class Encryptor

  attr_reader :dictionary,
              :message,
              :key,
              :date

  def initialize(message, key, date)
    @dictionary = [*('a'..'z'),*('0'..'9'),(" "),("."),(",")] * 4
    @message = message
    @key = Rotator.new(date, key).key
    @date = Rotator.new(date, key).date
  end

  def encrypted_message(message, key, date)
    input_message(message).map do |characters|
      encrypt_quad_characters(characters)
    end.flatten.join("")
  end

  def input_message(message)
    message.split("").each_slice(4).map { |slice| slice }
  end

  def encrypt_quad_characters(characters)
    characters.each_with_index.map do |character, index|
      actual_index = dictionary.find_index(character)
      dictionary[actual_index + Rotator.new.generate_rotation[index]]
    end
  end

end
