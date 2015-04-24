class Event < ActiveRecord::Base
  has_and_belongs_to_many :users, -> { uniq }
  belongs_to :owner, class_name: "User", foreign_key: "events_owner_id"
  has_one :transaction

  validates :title, :presence => true
  validates :description, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :cost, :presence => true
  validates :total_spots, :presence => true

  validate :check_for_owner_enrollment, :on => :update

  def spots_left
    self.total_spots - self.users.count
  end

  private
  def check_for_owner_enrollment
    if self.users.include? self.owner
      errors.add(:users, "can't enroll owner")
    end
  end
end
