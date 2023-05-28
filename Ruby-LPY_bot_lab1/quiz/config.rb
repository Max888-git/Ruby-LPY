module Quiz
    
    def self.config
      @yaml_dir = "quiz/yml"
      @answers_dir = "quiz/answers"
      @in_ext = "yml"
    end
  
    def self.yaml_dir
      @yaml_dir
    end
  
    def self.answers_dir
      @answers_dir
    end
  
    def self.in_ext
      @in_ext
    end
  end
  
