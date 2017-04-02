class User < ActiveRecord::Base
  has_many :user_organizations, :dependent => :destroy
  has_many :organizations, :through => :user_organizations

  has_many :project_contributes, :dependent => :destroy
  has_many :projects, :through => :project_contributes

  has_many :viewpoints

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, uniqueness: true
  validates_uniqueness_of :username
  validates :firstname, :lastname, :username, :email, presence: true

  before_create :generate_authentication_token!
  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  def birth_date=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute(:birth_date, date)
  end
end
