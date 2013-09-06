require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    @user = User.find_by_email(email)
    if @user
      if @user.password == password
        @user
      end
    end
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end