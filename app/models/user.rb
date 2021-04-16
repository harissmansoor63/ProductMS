class User < ApplicationRecord
  SPECIAL = "?<>',?[]}{=-)(*&^%$#`~{}!"
  REGEX = /[#{SPECIAL.gsub(/./){|char| "\\#{char}"}}]/
  ROLLER = { user: 0, admin: 1 }

  scope :staff, -> {where(role: User.roles[:user])} 

  validates :first_name, :last_name, presence: true 
  validates :password, format: { with: /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}/ }
  validate :password_lower_case, :password_uppercase, :password_special_char, :password_contains_number

  before_create :set_password, :block_from_invitation?

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum role: ROLLER

  def password_uppercase
    return if password.match(/\p{Upper}/)

    errors.add :password, ' must contain at least 1 uppercase '
  end

  def password_lower_case
    return if password.match(/\p{Lower}/)

    errors.add :password, ' must contain at least 1 lowercase '
  end

  def password_special_char
    return if password =~ REGEX

    errors.add :password, ' must contain special character '
  end

  def password_contains_number
    return if password.count("0-9") > 0

    errors.add :password, ' must contain at least one number '
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    clause = where(conditions.to_h)
    return clause.where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first if login

    clause.first if conditions.has_key?(:username) || conditions.has_key?(:email)
  end

  def set_password
    if self.user?
      chars = ((0..9).to_a + ('A'..'z').to_a + ('!'..'?').to_a)
      self.password = (0...12).map { chars.sample }.join + '$0Ac9'
    end
  end

  def block_from_invitation?
    false
  end
end
