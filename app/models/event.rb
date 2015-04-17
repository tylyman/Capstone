class Event < ActiveRecord::Base
  has_and_belongs_to_many :users

  def vaca_countdown
    self.votes -= 1
    self.save
  end
end
