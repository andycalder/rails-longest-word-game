require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ('A'..'Z').to_a

    10.times do
      @letters << alphabet.sample
    end
  end

  def score
    word = params[:word].upcase
    letters = params[:letters].split
    score = 0
    buildable = true

    # Condition 1: word can be built from letters
    word.split('').each do |letter|
      if letters.include?(letter)
        score += 1
        index = letters.index(letter)
        letters.delete_at(index)
      else
        score = 0
        buildable = false
      end
    end

    # Condition 2: word is a valid english word
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
    hash = JSON.parse(response)
    valid_word = hash['found']

    if !valid_word
      @message = "Sorry, #{word} is not a valid english word"
    elsif !buildable
      @message = "Sorry, #{word} can't be built from #{params[:letters]}"
    else
      session[:total_score] ||= 0
      session[:total_score] += score
      @message = "Congratulations, your score is #{score}!"
    end

    @total_score_message = "Your global score is #{session[:total_score]}"
  end
end
