class AnswersController < ApplicationController
  before_action :set_answer, only: [:edit, :update, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer   = Answer.new
    if @answer.update(answer_params)
      redirect_to question_path(@question), notice: 'Success'
    else
      redirect_to question_path(@question), alert: 'Error'
    end
  end

  def edit
  end
  
  def update
    if @answer.update(answer_params)
      redirect_to question_path(@question), notice: 'Answer update success!'
    else
      flash[:alert] = 'Answer update error!'
      render :edit
    end
  end
  
  def destroy
    @answer.destroy
    redirect_to question_path(@question), notice: 'Answer deleted!'
  end

  private
  def set_answer
    @question = Question.find(params[:question_id])
    @answer   = @question.answers.find(params[:id])
  end
  
  def answer_params
    params.require(:answer).permit(:name, :content, :question_id)
  end
end
