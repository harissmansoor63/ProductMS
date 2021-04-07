class User < ApplicationRecord
  validates :first_name, :last_name, presence: true 
  validates :password, length: {minimum: 8}, format: { with: /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}/}
 
# the .{8,} does the same as length: {minimum: 8} 
# /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*\W])/ 
# /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
