class QuizBot
    include Singleton
  
    attr_accessor :yaml_dir, :in_ext, :answers_dir, :log_dir
  
    def self.config(&block)
        instance.instance_eval(&block)
    end
end
  
  