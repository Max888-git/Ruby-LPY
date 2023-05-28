require 'telegram/bot'

require_relative './message_responder'
require_relative './app_configurator'

class EngineBot
    def run
        config = AppConfigurator.new
        config.configure
        
        logger = config.get_logger

        logger.debug 'Fetching questions'
        question_data = QuestionData.new(QuizBot.instance.yaml_dir, ".yml")

        token = config.get_token
        
        logger.debug 'Starting telegram bot'
        
        Telegram::Bot::Client.run(token) do |bot|
          bot.listen do |message|
            begin
                options = {bot: bot, message: message, questions: question_data.collection}
        
                logger.debug "@#{message.from.username}: #{message.text}" 
                MessageResponder.new(options).respond
            rescue => e
                logger.error e
            end
          end
        end
    end
end
