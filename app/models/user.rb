class User < ApplicationRecord

	enum role: [:user, :admin]
	
	Special = "?<>',?[]}{=-)(*&^%$#`~{}!"
	Regex = /[#{Special.gsub(/./){|char| "\\#{char}"}}]/

	validates :first_name, :last_name, presence: true 
	validates :password, format: { with: /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}/}

	validate :password_lower_case, :password_uppercase, :password_special_char, :password_contains_number

	

	attr_writer :login

	def login
		@login || self.username || self.email
	end

	devise :invitable, :database_authenticatable, :registerable,
	:recoverable, :rememberable, :validatable, :confirmable

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

		errors.add :password, ' must contain special character '
	end

	def password_contains_number
		return if password.count("0-9") > 0
		
		errors.add :password, ' must contain at least one number '
	end

	def self.find_for_database_authentication(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
		elsif conditions.has_key?(:username) || conditions.has_key?(:email)
			where(conditions.to_h).first
		end
	end

end
