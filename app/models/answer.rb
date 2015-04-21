class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :content, :presence => true
  validate :profane?

  def profane?
    errors.add(:content, "contains obscene content.") if Obscenity.profane?(self.content)
  end

  def upvote
    self.helpful += 1
    self.save
  end

  def downvote
    self.helpful -= 1
    self.save
  end
end
