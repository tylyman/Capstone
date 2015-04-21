class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :title, :presence => true
  validates :content, :presence => true
  validates :category, :presence => true
  
  validate :profane?

  def profane?
  	errors.add(:content, "contains obscene content") if Obscenity.profane?(self.content)
  	errors.add(:title, "contains obscene content") if Obscenity.profane?(self.title)
  end
end
