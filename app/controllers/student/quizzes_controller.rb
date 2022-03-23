module Student
  class QuizzesController < Student::BaseController
    before_action :load_course_section, only: %i[index]
    before_action :load_quiz, only: %i[show]
    before_action :load_question, only: %i[submit_answer skip_question]
    before_action :load_current_user, only: %i[submit_answer]

    def index
      @quizzes = @course_section.quizzes
    end

    def show
      @question = @quiz.questions.first
      @index = 1
      redirect_to student_course_section_quizzes_path(@quiz.course_section) if @question.blank?
    end

    def submit_answer
      if params[:answers].present? && params[:answers].length == 1
        UserAnswer.create(user_id: @student.id, answer_id: params[:answers][0])
        load_next_question
      else
        @error              = true
        flash.now[:alert]   = 'Please Checked the one from Answers'
      end
    end

    def skip_question
      load_next_question
    end

    def load_next_question
      @quiz               = @question.quiz
      @next_question      = @quiz.questions.where('id > ?', @question.id).first
      @index              = params[:count].to_i + 1
      flash[:notice]      = 'Quiz is complete' if @next_question.blank?
    end

    private

    # will use current_user there
    def load_current_user
      @student = User.where(role: User.roles[:student]).last
    end

    def load_question
      @question = Question.find params[:question]
    end

    def load_course_section
      begin
        @course_section = CourseSection.find params[:course_section_id]
      rescue ActiveRecord::RecordNotFound
        nil
      end
      redirect_to student_course_sections_path if @course_section.blank?
    end

    def load_quiz
      begin
        @quiz = Quiz.friendly.find params[:id]
      rescue ActiveRecord::RecordNotFound
        nil
      end
      redirect_to student_course_sections_path if @quiz.blank?
    end
  end
end
