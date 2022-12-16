require_relative './lib/validators/integer_validators'
require_relative './lib/validators/string_validators'
require_relative './lib/converters/integer_converters'
require_relative './lib/infrastructure/input_reader'
require_relative './lib/email/email_credentials'

require_relative './lib/engine'


module MyApplicationLekaYakhnenkoPerevozniy
    class Application
        def initialize
            @reporting_email = "ghosteagle07@gmail.com"
        end

        def run
            input_reader = InputReader.new

            catalogue_link = input_reader.read(
                "Надайте будь ласка посилання з сайту Наш Формат для парсингу",
                -> (v) { v },
                Validators::StringValidators.get_starts_with_validator("https://nashformat.ua"),
                "Невірне посилання. Спробуйте ще раз. Переконайтесь, що посилання веде на сайт нашформат"
            )

            number_of_pages = input_reader.read(
                "Надайте будь ласка кількість сторінок для парсингу [1-3]",
                Converters::IntegerConverters.get_convert_to_number_lambda,
                Validators::IntegerValidators.get_min_max_validator(1, 3),
                "Число введено не вірно або не відповідає критеріям. Спробуйте ще раз."
            )

            engine = Engine.new(catalogue_link, EmailCredentials.get_email_credentials, @reporting_email)

            engine.perform_parsing(number_of_pages)
        end
    end
end