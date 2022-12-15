require 'yaml'

class Cart
    def initialize(items)
        @items = items
    end

    def save_to_yml
        self.to_yaml
    end
end
