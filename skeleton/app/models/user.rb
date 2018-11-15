class User < ApplicationRecord
  validates :username, presence: true,uniqueness: true
  validates :session_token, presence: true
  
  attr_reader :password
  before_validation :create_session
  
  has_many :cats,
    foreign_key: :user_id,
    class_name: :Cat
  
  def reset_session_token
  self.session_token ||= SecureRandom::urlsafe_base64
  self.save!
  self.session_token
  end
  
  def create_session
    self.session_token = SecureRandom::urlsafe_base64
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def self.find_by_credentials(user_name,password)
      user = User.find_by(username: user_name)
      if user && user.is_password?(password)
        user
      else
        nil
      end
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
