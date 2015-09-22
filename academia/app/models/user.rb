class User < ActiveRecord::Base

  has_secure_password
  
  validates :email,
    presence: true,
    uniqueness: true,
    length: { in: 3..50 },
    format: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  validates :name,
    presence: true

  # before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if (self.password_changed?())
      self.password_salt = BCrypt::Engine.generate_salt()
      self.password = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def self.authenticate(email = "", login_password = "")
    user = User.find_by_email(email)

    if (user && user.match_password(login_password))
      return user
    else
      return false
    end
  end

  def match_password(login_password = "")
    password == BCrypt::Engine.hash_secret(login_password, password_salt)
  end

end
