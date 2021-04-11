class User < ApplicationRecord

  Special = "?<>',?[]}{=-)(*&^%$#`~{}!"
  Regex = /[#{Special.gsub(/./){|char| "\\#{char}"}}]/

  validates :first_name, :last_name, presence: true 
  validates :password, format: { with: /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}/}

  validate :password_lower_case, :password_uppercase, :password_special_char, :password_contains_number

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  def password_uppercase
    return if !!password.match(/\p{Upper}/)
    errors.add :password, ' must contain at least 1 uppercase '
  end

  def password_lower_case
    return if !!password.match(/\p{Lower}/)
    errors.add :password, ' must contain at least 1 lowercase '
  end

  def password_special_char 
    return if password =~ Regex
    errors.add :password, ' must contain special character'
  end

  def password_contains_number
    return if password.count("0-9") > 0
    errors.add :password, ' must contain at least one number'
  end

end
