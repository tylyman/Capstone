class Question < ActiveRecord::Base
  belongs_to :users
  has_one :answers
end
