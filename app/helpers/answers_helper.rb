module AnswersHelper
	def check_for_language(var)
    Obscenity.profane?(var.content)
  end

  def check_title_for_language_obscene(var)
    Obscenity.profane?(var.title)
  end
end
