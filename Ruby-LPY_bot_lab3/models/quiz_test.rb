require 'active_record'

class QuizTest < ActiveRecord::Base
    belongs_to :user
  
    enum status: [:pending, :in_progress, :completed]
  
    validates :current_question, :status, :correct_answers, :incorrect_answers, :percent, presence: true
    validates :current_question, :correct_answers, :incorrect_answers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :percent, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  end
  