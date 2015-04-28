class User < ActiveRecord::Base
  has_and_belongs_to_many :events, -> { uniq }
  has_many :owned_events, class_name: 'Event', foreign_key: 'events_owner_id'
  has_many :questions
  has_many :answers
  has_many :transactions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    	user.email = auth.info.email
    	user.password = Devise.friendly_token[0,20]
    	user.first_name = auth.info.first_name   
    	user.last_name = auth.info.last_name   
  	end
	end

	# Copies the facebook email if available
	def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
