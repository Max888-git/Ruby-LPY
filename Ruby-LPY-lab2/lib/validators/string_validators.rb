module Validators
    class StringValidators
        def self.get_starts_with_validator(starts_with)
            -> (v) { v.start_with? starts_with }
        end
    end
end