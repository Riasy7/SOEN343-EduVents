class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :type, inclusion: { 
    in: %w(AttendeeUser OrganizerUser AdminUser ExecutiveUser),
    message: "%{value} is not a valid user type"
  }

  # belongs to an organization, not sure if it should be optional
  belongs_to :organization, optional: true

  def get_full_name
    "#{first_name} #{last_name}"
  end
  
  # added payment for stripe integration
  has_many :payments, dependent: :destroy
end
