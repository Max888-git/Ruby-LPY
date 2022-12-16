module Email
    class EmailAttachment
        attr_accessor :filename, :filepath

        def initialize(filename, filepath)
            @filename = filename
            @filepath = filepath
        end
    end
end