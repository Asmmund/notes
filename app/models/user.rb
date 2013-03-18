class User < ActiveRecord::Base
  attr_accessor :password
  attr_protected :password_digest
  attr_accessible :password, :password_confirmation, :facebook, :linkedin, :name, :email,  :twitter, :web
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true, :confirmation => true
  validates :password_confirmation, presence: { if: :password }

  def self.authenticate email, pass
    user = where(email: email).first
    user && BCrypt::Password.new(user.password_digest) == pass ? user : nil
  end

  def password=(pass)
    return if pass.blank?
    @password = pass
    self.password_digest = BCrypt::Password.create(pass)
  end
end
