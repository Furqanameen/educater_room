module Instructor
  class QuizzesController < Instructor::BaseController
    before_action :load_course_section
    before_action :load_quiz, only: %i[edit update show destroy]

    def index
      @quizzes = @course_section.quizzes
    end

    def new
      @quiz = Quiz.new
    end

    def create
      @quiz = @course_section.quizzes.new(quiz_params)
      if @quiz.save
        redirect_to instructor_course_section_quizzes_path(@course_section), notice: 'Quiz is created successfully.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @quiz.update(quiz_params)
        redirect_to instructor_course_section_quizzes_path(@course_section), notice: 'Quiz is Updated successfully.'
      else
        render :edit
      end
    end

    def show; end

    def destroy
      if @quiz.destroy
        flash[:notice] = 'Quiz has been deleted!'
      else
        flash[:alert] = 'Error! unable to delete quiz at the moment!'
      end
      redirect_to instructor_course_section_quizzes_path(@course_section)
    end

    private

    def load_course_section
      @course_section = current_user.course_sections.find(params[:course_section_id])
    end

    def load_quiz
      @quiz = @course_section.quizzes.friendly.find(params[:id])
    end

    def quiz_params
      params.require(:quiz).permit(:title, :description, :start_date, :end_date, :course_section_id,
                                   questions_attributes: [:id, :statement, :question_type, answers_attributes: %i[id statement is_correct]])
    end
  end
end
