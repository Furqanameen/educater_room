module Organisation
  class CoursesController < Organisation::BaseController
    before_action :load_course, only: %i[show edit update destroy]

    def index
      @courses = filtered_courses
    end

    def new
      @course = Course.new
    end

    def create
      @course = Course.new(course_params)
      if @course.save
        redirect_to organisation_courses_path, notice: 'Course was successfully created.'
      else
        flash[:alert] = @course.errors.full_messages.to_sentence
        render :new
      end
    end

    def edit; end

    def update
      if @course.update(course_params)
        redirect_to organisation_courses_path, notice: 'Course was successfully created.'
      else
        flash[:alert] = @course.errors.full_messages.to_sentence
        render :edit
      end
    end

    def destroy
      if @course.destroy
        flash[:notice] = 'Course was successfully deleted.'
      else
        flash[:alert] = 'Course not delete!'
      end
      redirect_to organisation_courses_path
    end

    def restore
      @course = Course.with_deleted.find(params[:id])

      redirect_to organisation_courses_path, notice: 'Course has been restored' if @course.restore
    end

    private

    def course_params
      params.require(:course).permit(:title, :description, :subtitle, :image, :status)
    end

    def load_course
      @course = Course.find(params[:id])
    end

    def filtered_courses
      courses    = Course.with_deleted
      constraint = params.dig(:filter, :constraint)

      case constraint
      when 'deleted'
        courses.deleted
      when 'published'
        courses.published
      when 'un_published'
        courses.un_published
      else
        courses
      end
    end
  end
end
