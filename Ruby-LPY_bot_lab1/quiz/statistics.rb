require './file_writer.rb'

class Statistics
    def initialize(writer)
      @correct_answers = 0
      @incorrect_answers = 0
      @writer = writer
    end
  
    def correct_answer
      @correct_answers += 1
    end
  
    def incorrect_answer
      @incorrect_answers += 1
    end
  
    def print_report(total_questions)
      success_rate = (@correct_answers.to_f / total_questions) * 100
      report = <<~REPORT
        Test Summary:
        -------------
        Total Questions: #{total_questions}
        Correct Answers: #{@correct_answers}
        Incorrect Answers: #{@incorrect_answers}
        Success Rate: #{success_rate}%
      REPORT
  
      @writer.write(report)
    end
  end
  