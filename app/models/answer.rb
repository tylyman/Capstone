class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  def upvote
    self.helpful += 1
    self.save
  end

  def downvote
    self.helpful -= 1
    self.save
  end
end
