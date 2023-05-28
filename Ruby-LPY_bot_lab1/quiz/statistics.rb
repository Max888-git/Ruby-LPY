class Statistics
    def initialize(writer)
      @correct_answers = 0
      @incorrect_answers = 0
      @total_questions = 0
      @writer = writer
    end
  
    def correct_answer
      @correct_answers += 1
      @total_questions += 1
    end
  
    def incorrect_answer
      @incorrect_answers += 1
      @total_questions += 1
    end
  
    def get_report
      success_rate = (@correct_answers.to_f / @total_questions) * 100
      report = <<~REPORT
        Test Summary:
        -------------
        Total Questions: #{@total_questions}
        Correct Answers: #{@correct_answers}
        Incorrect Answers: #{@incorrect_answers}
        Success Rate: #{success_rate}%
      REPORT
  
      report
    end

    def save_report
      report = get_report
  
      @writer.write report
    end

  end
  