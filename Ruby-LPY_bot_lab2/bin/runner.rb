require_relative '../lib/load_libraries'

quizname = 'math-grade-5'

QuizBot.config do |quiz_bot|
    quiz_bot.yaml_dir = File.join(__dir__, '../config/quiz_yml', quizname)
    quiz_bot.log_dir = File.join(__dir__, '../log')
end

engine = EngineBot.new
engine.run