class User < ActiveRecord::Base
  has_and_belongs_to_many :events, -> { uniq }
  has_many :owned_events, class_name: 'Event', foreign_key: 'events_owner_id'
  has_many :questions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
end
