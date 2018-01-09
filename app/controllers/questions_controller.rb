class QuestionsController < ApplicationController
  def show
    @question = Question.new
    render :service_unavailable if @question.invalid?
  end

  def show_category
    @question = Question.new(category: params[:category])
    if @question.valid?
      render :show
    else
      render :service_unavailable
    end
  end

  def answer
    if params[:answer] == 'correct'
      render :correct, category: params[:category]
    else
      render :wrong, category: params[:category]
    end
  end
end
