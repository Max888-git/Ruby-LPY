require_relative './reply_markup_formatter'
require_relative './app_configurator'

class MessageSender
  attr_reader :bot
  attr_reader :text
  attr_reader :chat
  attr_reader :answers
  attr_reader :logger

  def initialize(options)
    @bot = options[:bot]
    @text = options[:text]
    @chat = options[:chat]
    @answers = Array(options[:answers]).map(&:to_s)
    @logger = AppConfigurator.new.get_logger
  end

  def send
    if answers.any?
      reply_markup = ReplyMarkupFormatter.new(answers).get_markup
      bot.api.send_message(chat_id: chat.id, text: text, reply_markup: reply_markup)
    else
      bot.api.send_message(chat_id: chat.id, text: text)
    end

    logger.debug "sending '#{text}' to #{chat.username}"
  end
end