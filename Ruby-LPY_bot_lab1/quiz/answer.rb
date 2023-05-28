class Answer
    attr_accessor :text, :is_correct

    def initialize(text, is_correct)
        @text = text
        @is_correct = is_correct
    end
end