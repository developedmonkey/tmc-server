module FeedbackAnswersHelper
  def render_feedback_answer(answer)
    if answer.feedback_question.intrange?
      answer.answer + "/" + answer.feedback_question.intrange.max.to_s
    else
      simple_format(answer.answer)
    end
  end

  def feedback_statistics_for_question(question)
    stats = {}
    stats[:count] = question.feedback_answers.count

    if question.intrange?
    end

    # TODO
  end
end