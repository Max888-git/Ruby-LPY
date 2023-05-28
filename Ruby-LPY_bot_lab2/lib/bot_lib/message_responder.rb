require './models/user'
require_relative './message_sender'

class MessageResponder
  attr_reader :message
  attr_reader :bot
  attr_reader :user

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @questions = options[:questions]
    @user = User.create_with(username: message.from.username).find_or_create_by(uid: message.from.id)
  end

  def respond

    on /^\/start/ do
      answer_with_greeting_message
    end

    on /^\/stop/ do
      answer_with_farewell_message
    end

    on /^\/c ([0-9]+)/ do |question_number|
      answer_with_question(question_number)
    end
  end

  private

  def on regex, &block
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
    answer_with_message I18n.t('greeting_message')
  end

  def answer_with_farewell_message
    answer_with_message I18n.t('farewell_message')
  end

  def answer_with_question(question_number)
    question = @questions[question_number.to_i - 1]
    puts question.display_answers
    # answer_with_message_and_answers(question.question_body, [1, 2, 3, 4])
    answer_with_message question.question_body
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end

  def answer_with_message_and_answers(text, answers)
    MessageSender.new(bot: bot, chat: message.chat, text: text, answers: answers).send
  end
end