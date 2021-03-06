class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :name, :email, :password, :password_confirmation
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  validates :name, :presence => true, :length => { :maximum => 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, :presence =>   true,
                    :format =>    { :with => VALID_EMAIL_REGEX },
                    :uniqueness => { :case_sensitive => false }
  validates :password, :length => { :minimum => 6 }

  private

  def create_remember_token
  	self.remember_token = SecureRandom.hex
  end
end

