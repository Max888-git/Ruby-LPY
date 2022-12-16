module Validators
    class IntegerValidators
        def self.get_min_max_validator(min, max)
            lambda do |v|
                is_float = !!(Float(v) rescue false) 
                if !is_float
                    return false
                end
                num = Float(v)
                num and (num >= min) and (num <= max)
            end
        end
    end
end