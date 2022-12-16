module Converters
    class IntegerConverters
        def self.get_convert_to_number_lambda
            -> (v) { v.to_f }
        end
    end
end