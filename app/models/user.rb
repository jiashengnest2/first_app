class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_accessor :password, :password_confirmation
  #has_secure_password

  before_save {|user| user.email = email.downcase}

  validates :name, :presence => true, :length => {:maximum =>  50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, 
                    :format => { :with => VALID_EMAIL_REGEX }, 
                    :uniqueness => true
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => {:minimum => 6},
                        :on => :create,
                        :on => :update


  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
