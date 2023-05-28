require 'json'
require 'yaml'
require_relative 'answer'

class Question
  attr_accessor :question_body, :question_correct_answer, :question_answers

  def initialize(raw_text, raw_answers, correct_answer_index)
    @question_body = raw_text
    @question_correct_answer = correct_answer_index
    @question_answers = init_answers(raw_answers)

    @question_answers.each do |a|
      puts 'Answers'
      puts a.text
      puts a.is_correct
      puts "\n"
    end
  end

  def display_answers
    @question_answers.map.with_index { |answer, index| "#{('A'.ord + index).chr}. #{answer.text}" }
  end

  def get_valid_answers_chars
    @question_answers.map.with_index { |answer, index| ('A'.ord + index).chr }
  end

  def to_s
    @question_body
  end

  def to_hash
    {
      question_body: @question_body,
      question_correct_answer: @question_correct_answer,
      question_answers: @question_answers
    }
  end

  def to_json
    JSON.pretty_generate(to_hash, {})
  end

  def to_yaml
    to_hash.to_yaml
  end

  def shuffle_answers(raw_answers)
    shuffled_answers = raw_answers.shuffle
    shuffled_answers
  end

  def init_answers(raw_answers)
    @question_answers = shuffle_answers raw_answers.each_with_index.map { |answer, index| Answer.new(answer, index == @question_correct_answer )}
  end

  def find_answer_by_char(char)
    index = char.ord - 'A'.ord
    @question_answers[index]
  end
end
