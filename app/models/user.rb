class User < ActiveRecord::Base
  has_and_belongs_to_many :events, -> { uniq }
  has_many :owned_events, class_name: 'Event', foreign_key: 'events_owner_id'
  has_many :questions
  has_many :transactions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
end
