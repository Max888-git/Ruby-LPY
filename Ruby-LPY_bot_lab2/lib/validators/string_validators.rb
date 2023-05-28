module Validators
    class StringValidators
        def self.first_char_must_be_one_of(valid_chars)
            -> (v) do
                false if (v.nil? || v.empty?)
                valid_chars.any? { |c| c == v[0] }
            end
        end
    end
end