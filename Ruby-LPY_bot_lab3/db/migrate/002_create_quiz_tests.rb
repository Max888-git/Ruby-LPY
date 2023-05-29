class CreateQuizTests < ActiveRecord::Migration[5.1]
    def change
      create_table :quiz_tests do |t|
        t.integer :current_question, default: 0
        t.integer :status, default: 0
        t.integer :correct_answers, default: 0
        t.integer :incorrect_answers, default: 0
        t.decimal :percent, precision: 10, scale: 2, default: 0
        t.references :user, foreign_key: true
      end
    end
  end
  