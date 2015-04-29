class Event < ActiveRecord::Base
  has_and_belongs_to_many :users, -> { uniq }
  has_attached_file :image, styles: { med: "400x200" }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  belongs_to :owner, class_name: "User", foreign_key: "events_owner_id"

  validates :image, :attachment_presence => true
  validates :title, :presence => true
  validates :description, :presence => true
  validates :address, :presence => true
  validates :cost, :presence => true
  validates :total_spots, :presence => true

  validate :check_for_owner_enrollment, :on => :update

  geocoded_by :address
  after_validation :geocode

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
