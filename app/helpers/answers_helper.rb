module AnswersHelper
  def vote_badge(answer)
    if answer.helpful >= 0
      content_tag :span, answer.helpful, class: ['badge'] 
    else  
      content_tag :span, answer.helpful, class: ['badge'] 
    end  
  end
end
