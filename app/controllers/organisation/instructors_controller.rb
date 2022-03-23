module Organisation
  class InstructorsController < Organisation::BaseController
    before_action :load_instructor, only: %i[show edit update destroy]

    def index
      @instructors = filtered_instructors
    end

    def new
      @instructor = User.instructor.new
    end

    def create
      @instructor = User.instructor.new(instructor_params)
      skip_password_validation?
      if @instructor.save
        redirect_to organisation_instructors_path, notice: 'Instructor has been created.'
      else
        flash[:alert] = @instructor.errors.full_messages.to_sentence
        render :new
      end
    end

    def show; end

    def edit; end

    def update
      skip_password_validation?
      if @instructor.update(instructor_params)
        redirect_to organisation_instructors_path, notice: 'Instructor has been updated'
      else
        flash[:alert] = @instructor.errors.full_messages.to_sentence
        render :edit
      end
    end

    def destroy
      if @instructor.destroy
        flash[:notice] = 'Instructor deleted!'
      else
        flash[:alert] = @instructor.errors.full_messages.to_sentence
      end
      redirect_to organisation_instructors_path
    end

    def restore
      @instructor = User.with_deleted.find(params[:id])

      redirect_to organisation_instructors_path, notice: 'Instructor has been restored' if @instructor.restore
    end

    private

    def instructor_params
      params.require(:user).permit(:first_name, :last_name, :email, :contact, :birth_date, :specialization, :highest_education, :image)
    end

    def load_instructor
      @instructor = User.find(params[:id])
    end

    # def course_sections
    #   return unless params[:courses].present?

    #   existing_course_section_ids = []
    #   courses                     = params[:courses]
    #   course_sections             = CourseSection.where(course_id: courses)&.pluck(:id)
    #   existing_course_section_ids = @instructor.course_section_users.where(course_section_id: course_sections)&.pluck(:course_section_id) if @instructor&.course_section_users.present?
    #   new_course_sections         = CourseSection.where(id: (course_sections - existing_course_section_ids))

    #   return new_course_sections
    # end

    def filtered_instructors
      instructors = User.instructor.with_deleted

      constraint = params.dig(:filter, :constraint)

      case constraint
      when 'deleted'
        instructors.deleted
      else
        instructors
      end
    end

    def skip_password_validation?
      @instructor.skip_password_validation = params.dig(:user, :password).blank? &&
                                             params.dig(:user, :password_confirmation).blank?
    end
  end
end
