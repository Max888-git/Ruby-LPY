require 'active_record'
require 'logger'

class DatabaseConnector
  class << self
    def establish_connection
      configure_logger
      configuration = load_configuration
      establish_database_connection(configuration)
    end

    private

    def configure_logger
      log_path = 'debug.log'
      ActiveRecord::Base.logger = Logger.new(log_path)
      ActiveRecord::Base.logger.level = Logger::DEBUG
    end

    def load_configuration
      config_path = 'config/database.yml'
      YAML.load_file(config_path)
    end

    def establish_database_connection(configuration)
      ActiveRecord::Base.establish_connection(configuration)
      log_connection_status
    end

    def log_connection_status
      if ActiveRecord::Base.connected?
        puts "Database connection established successfully."
        ActiveRecord::Base.logger.debug("Database connection established successfully.")
      else
        puts "Failed to establish database connection."
        ActiveRecord::Base.logger.error("Failed to establish database connection.")
      end
    end
  end
end
