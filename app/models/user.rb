class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :token_authenticatable,
         :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :players, :dependent => :destroy
  has_many :teams, :dependent => :destroy
  has_many :games, :dependent => :destroy

end
