class User < ApplicationRecord
  validates :first_name, :last_name, presence: true 
  validates :password, length: {minimum: 8}, format: { with: /(?=.*[a-z])/}
   # /(?=.*[A-Z])/ /(?=.*\d)/ /(?=.*\W])/ 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
