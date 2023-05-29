class ReplyMarkupFormatter
  attr_reader :array

  def initialize(array)
    @array = array
  end

  # def get_markup
  #   buttons = array.map { |answer| Telegram::Bot::Types::KeyboardButton.new(text: answer.to_s) }
  #   Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: buttons.each_slice(1).to_a, one_time_keyboard: true)
  # end

  # def get_markup
  #   buttons = array.map { |answer| Telegram::Bot::Types::KeyboardButton.new(text: answer) }
  #   Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: buttons.each_slice(1).to_a, one_time_keyboard: true)
  # end

  # def get_markup
  #   buttons = array.map { |answer| Telegram::Bot::Types::InlineKeyboardButton.new(text: answer, callback_data: answer) }
  #   Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons.each_slice(1).to_a)
  # end

  # def get_markup
  #   buttons = array.map { |answer| Telegram::Bot::Types::KeyboardButton.new(text: answer) }
  #   Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: buttons.each_slice(1).to_a, one_time_keyboard: true)
  # end

  # def get_markup
  #   buttons = array.map { |answer| Telegram::Bot::Types::InlineKeyboardButton.new(text: answer, callback_data: answer) }
  #   Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons.each_slice(1).to_a)
  # end

  # def get_markup
  #   buttons = array.map.with_index(1) { |answer, index| Telegram::Bot::Types::InlineKeyboardButton.new(text: answer, callback_data: index.to_s) }
  #   Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons.each_slice(1).to_a)
  # end
  

  def get_markup
    buttons = array.map.with_index(1) do |answer, index|
      puts "Answer ##{index}: #{answer}" # Выводим номер ответа и текст ответа в консоль
      Telegram::Bot::Types::InlineKeyboardButton.new(text: answer, callback_data: index.to_s)
    end
  
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons.each_slice(1).to_a)
  end
  

end
