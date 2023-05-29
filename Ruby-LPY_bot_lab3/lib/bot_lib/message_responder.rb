require './models/user'
require './models/quiz_test'
require_relative './message_sender'

class MessageResponder
  attr_reader :message
  attr_reader :bot
  attr_reader :user

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @questions = options[:questions]
    @user = User.find_or_create_by(uid: message.from.id) do |u|
      u.username = message.from.username
    end
    @logger = options[:logger] 
    @quiz_test = QuizTest.find_or_create_by(user: @user, status: :pending) # Создаем или находим тест пользователя
  end

  def respond
    on /^\/start/ do
      save_user_name
      answer_with_greeting_message
    end

    on /^\/stop/ do
      answer_with_farewell_message
    end

    on /^\/c ([0-9]+)/ do |question_number|
      answer_with_question(question_number)
    end

    on /^[A-D](.*)/ do |answer|
      process_answer(answer)
    end
  end

  private

  def on(regex, &block)
    regex =~ message.text

    if $~
      case block.arity
      when 0
        yield
      when 1
        yield $1
      when 2
        yield $1, $2
      end
    end
  end

  def answer_with_greeting_message
    first_name = message.from.first_name
    greeting = "#{first_name}," if first_name
    answer_with_message("#{greeting} #{I18n.t('greeting_message')}")
    answer_with_next_question
  end
  
  def answer_with_farewell_message
    answer_with_message(I18n.t('farewell_message'))
  end

  def answer_with_next_question
    if @quiz_test.completed?
      answer_with_test_results
      return
    end

    question_number = @quiz_test.current_question
    question = @questions[question_number]

    # answers = question.display_answers
    # answer_with_message_and_answers(question.question_body, answers)
    reply_buttons = question.display_answers.map { |a| { text: a }}
    answer_with_message_and_answers(question.question_body, reply_buttons)
  end

  def answer_with_test_results
    message_text = I18n.t('summary') + "\n"
    message_text += I18n.t('correct_answers') + ": #{@quiz_test.correct_answers}\n"
    message_text += I18n.t('incorrect_answers') + ": #{@quiz_test.incorrect_answers}\n"
    message_text += I18n.t('percent') + ": #{@quiz_test.percent}%"

    answer_with_message(message_text)
  end

  def answer_with_question(question_number)
    if (question_number.to_i > @questions.length())
      answer_with_message "Невірний номер питання"
    else
        question = @questions[question_number.to_i - 1]
        reply_buttons = question.display_answers.map { |a| { text: a }}
        answer_with_message_and_answers(question.question_body, reply_buttons)
        # answer_with_message question.question_body
    end
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end
 
  def answer_with_message_and_answers(text, answers)
    # markup = ReplyMarkupFormatter.new(answers).get_markup
    MessageSender.new(bot: bot, chat: message.chat, text: text, answers: answers).send
  end
  
  def save_user_name
    @user.username ||= message.from.first_name
    @user.save if @user.changed?
    @logger.debug("@#{message.from.first_name}")
  end
  
  def process_answer(answer)
    # Save answer
    question_number = @quiz_test.current_question
    question = @questions[question_number]
    correct_answer = question.question_correct_answer
  
    if answer.to_s.upcase == question.get_valid_answers_chars[correct_answer]
      @quiz_test.correct_answers += 1
    else
      @quiz_test.incorrect_answers += 1
    end
  
    @quiz_test.percent = (@quiz_test.correct_answers.to_f / (@quiz_test.correct_answers + @quiz_test.incorrect_answers)) * 100
    @quiz_test.current_question += 1
    @quiz_test.status = :completed if @quiz_test.current_question >= @questions.length
  
    @quiz_test.save
  
    answer_with_next_question
  end
  
end
