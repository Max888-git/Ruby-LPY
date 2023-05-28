require 'yaml'
require 'json'
require 'concurrent'
require_relative './question'

class QuestionData
    attr_accessor :collection, :yaml_dir, :in_ext, :threads
    
    def initialize(yaml_dir, in_ext)
        @yaml_dir = yaml_dir
        @in_ext = in_ext
        @collection = []
        @threads = []
        load_data
    end

    def to_h
        {
            collection: @collection.map { |q| q.to_hash }
        }
    end
    
    def to_json
        JSON.pretty_generate(to_h)
    end

    def to_yaml
        to_h.to_yaml
    end

    def save_to_yaml(filepath)
        File.open(filepath, 'w') do |file|
            file.puts to_yaml
        end
    end

    def save_to_json(filepath)
        File.open(filepath, 'w') do |file|
            file.puts to_json
        end
    end

    def prepare_filename
        "#{@yaml_dir}/question_*#{@in_ext}"
    end

    def each_file(&block)
        pattern = prepare_filename()
        matching_files = Dir.glob(pattern)
        matching_files.each do |file|
            parse_file_block = ->{ block.call(file) }
            in_thread(&parse_file_block)
        end

        @collection = @threads.map(&:value)
    end

    def in_thread(&block)
        @threads << Thread.new { block.call }
    end

    def load_from(filename)
        question_content = File.open(filename)
        instance = YAML.load(question_content)[0]
        Question.new(instance['question'], instance['answers'], instance['correct_answer_index'].to_i)
    end

    def load_data
        load_from_func = ->(filename){ load_from filename }
        each_file(&load_from_func)
    end
end