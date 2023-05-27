require 'json'
require 'yaml'

class Question
  attr_accessor :question_body, :question_correct_answer, :question_answers

  def initialize(raw_text, raw_answers)
    @question_body = raw_text
    @question_answers = load_answers(raw_answers)
  end

  def display_answers
    @question_answers.map.with_index { |answer, index| "#{('A'.ord + index).chr}. #{answer}" }
  end

  def to_s
    @question_body
  end

  def to_h
    {
      question_body: @question_body,
      question_correct_answer: @question_correct_answer,
      question_answers: @question_answers
    }
  end

  def to_json
    JSON.generate(to_h)
  end

  def to_yaml
    to_h.to_yaml
  end

  def load_answers(raw_answers)
    shuffled_answers = raw_answers.shuffle
    @question_correct_answer = shuffled_answers.index(raw_answers[0])
    shuffled_answers
  end

  def find_answer_by_char(char)
    index = char.ord - 'A'.ord
    @question_answers[index]
  end
end
