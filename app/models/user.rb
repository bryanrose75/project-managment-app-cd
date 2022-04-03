class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :user_tasks
  has_many :tasks, through: :user_tasks

  #Create initials when assigning a task to a user 
  def initials
    "#{name.first.upcase.to_s} #{name.last.upcase.to_s}"
  end 
end
