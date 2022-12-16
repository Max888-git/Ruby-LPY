class InputReader
    def read(welcome_message, process, validator, error_message)
        puts welcome_message

        while 1
            input = gets.chomp

            if validator.call input
                return process.call input
            else
                puts error_message
            end
        end
    end
end