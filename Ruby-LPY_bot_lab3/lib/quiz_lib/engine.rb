require_relative 'input_reader'
require_relative 'statistics'
require_relative 'file_writer'
require_relative '../validators/string_validators'

class Engine
    attr_accessor :question_collection, :input_reader, :user_name, :current_time, :writer, :statistics;

    def initialize(question_collection)
        @input_reader = InputReader.new
        @question_collection = question_collection
        @writer = FileWriter.new('../quiz_answers', 'answers.text')
    end

    def run
        stats = Statistics.new(@writer)
        i = 0

        while i < @question_collection.length() do
            question = @question_collection[i]
            puts question.question_body
            puts question.display_answers
            puts "\n"

            user_answer = get_answer_by_char question
            is_correct = check user_answer
            if (is_correct)
                stats.correct_answer()
            else
                stats.incorrect_answer()
            end

            i += 1
        end

        puts "\n"
        puts stats.get_report
        stats.save_report
    end

    def get_answer_by_char(question)
        user_answer_chr = @input_reader.read(
            "Ваша відповідь:",
            -> (v) { v[0] },
            Validators::StringValidators.first_char_must_be_one_of(question.get_valid_answers_chars),
            "Формат відповіді некоректний. Ввведіть будь ласка одну із літер: #{question.get_valid_answers_chars}"
        )
        puts "\n"
        user_answer = question.find_answer_by_char(user_answer_chr)
        user_answer
    end

    def check(user_answer)
        user_answer.is_correct
    end

end 

