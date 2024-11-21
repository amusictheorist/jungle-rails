class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_secure_password

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    return user if user && user.authenticate(password)
    nil
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
