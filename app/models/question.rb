class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :title, :presence => true
  validates :content, :presence => true
  validates :category, :presence => true

  validate :profane?

  def profane?
  	errors.add(:title, "contains obscene content") if Obscenity.profane?(self.title)
  	errors.add(:content, "contains obscene content") if Obscenity.profane?(self.content)
  end
end
