require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << alphabet.sample
    end
    session
    raise
  end

  def score
    @answer = params['answer']
    @letters = params['letters']
    @validity = valid?(@answer)
    @realness = real_word?(@answer)
  end

  private

  # check answer vs letters grid
  def valid?(attempt)
    array = attempt.upcase.chars
    array.all? do |letter|
      @letters.include?(letter) && @letters.count(letter) >= array.count(letter)
    end
  end

  # check answer vs dictionary API
  def real_word?(attempt)
    api = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{attempt}").read)
    api['found']
  end
end
