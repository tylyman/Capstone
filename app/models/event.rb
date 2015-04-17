class Event < ActiveRecord::Base
  has_and_belongs_to_many :users, -> { uniq }

  def spots_left
    self.total_spots - self.users.count
  end
end
