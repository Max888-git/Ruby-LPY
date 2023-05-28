require 'singleton'

class Quiz
  include Singleton

  attr_accessor :yaml_dir, :in_ext, :answers_dir

  def self.config(&block)
    instance.instance_eval(&block)
  end
end

