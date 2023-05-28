require_relative './quiz/question_data'

module LekaYakhnenkoPerevozniy
    class Application
        def initialize
            @testname = "math-grade-5"
        end

        def run
            question_data = QuestionData.new("#{__dir__}/quiz/yml/#{@testname}", ".yml")
            puts question_data.to_json
        end
    end
end

app = LekaYakhnenkoPerevozniy::Application.new

app.run