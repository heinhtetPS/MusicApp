class User < ApplicationRecord
  validates :email, :password_digest, :session_token,
  presence: true, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}
  after_initialize :ensure_token
  attr_reader :password

  def ensure_token
    self.session_token ||= User.generate_token
  end

  def self.generate_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_token!
    self.session_token = User.generate_token
    self.save!
    self.session_token
  end

  def password=(pw)
    self.password_digest = Bcrypt::Password.create(pw)
  end

  def is_password?(pw)
    Bcrypt::Password.new(self.password_digest).is_password?(pw)
  end


  def self.find_by_creds(email, pw)
    user = User.find_by(email: email)
    if user && user.is_password?(pw)
      user
    else
      nil
    end
  end

end
