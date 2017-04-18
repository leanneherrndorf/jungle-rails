class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false }



  def self.authenticate_with_credentials(email, password)
    email.strip!
    email.downcase!
    user = User.find_by_email(email)

    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end

