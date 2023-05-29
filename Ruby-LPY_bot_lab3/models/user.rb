require 'active_record'

class User < ActiveRecord::Base
    has_many :quiz_tests
    
    validates :uid, presence: true
    validates :username, presence: true
    
    def self.save_user(uid, username)
      user = User.new(uid: uid, username: username)
      user.save
      user
    end
  end  