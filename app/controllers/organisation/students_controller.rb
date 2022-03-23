module Organisation
  class StudentsController < Organisation::BaseController
    before_action :load_student, only: %i[show edit update destroy]

    def index
      @students = filtered_students
    end

    def show; end

    def new
      @student = User.student.new
      form_data
    end

    def create
      @student = User.student.new(student_params)
      skip_password_validation?
      if @student.save
        redirect_to organisation_students_path, notice: 'Student has been created.'
      else
        form_data
        flash[:alert] = @student.errors.full_messages.to_sentence
        render :new
      end
    end

    def edit
      form_data
    end

    def update
      skip_password_validation?

      if @student.update(student_params)
        redirect_to organisation_students_path, notice: 'Student has been updated'
      else
        form_data
        flash[:alert] = @student.errors.full_messages.to_sentence
        render :edit
      end
    end

    def destroy
      if @student.destroy
        flash[:notice] = 'Student deleted!'
      else
        flash[:alert] = @student.errors.full_messages.to_sentence
      end
      redirect_to organisation_students_path
    end

    def restore
      @student = User.with_deleted.find params[:id]

      redirect_to organisation_students_path, notice: 'Student has been restored' if @student.restore
    end

    private

    def student_params
      params.require(:user).permit(:first_name, :last_name, :email, :contact, :birth_date, :highest_education, :image)
    end

    def load_student
      @student = User.find params[:id]
    end

    def form_data
      @sections = Section.pluck(:title, :id)
    end

    # def course_sections
    #   return unless params[:section].present?

    #   existing_course_section_ids = []
    #   section                     = params[:section]
    #   course_sections_ids         = CourseSection.where(section_id: section)&.pluck(:id)
    #   existing_course_section_ids = @student.course_section_users.where(course_section_id: course_sections_ids)&.pluck(:course_section_id) if @student&.course_section_users&.present?
    #   new_course_sections         = CourseSection.where(id: (course_sections_ids - existing_course_section_ids))

    #   return new_course_sections
    # end

    def filtered_students
      students = User.student.with_deleted
      constraint = params.dig(:filter, :constraint)

      case constraint
      when 'deleted'
        students.deleted
      else
        students
      end
    end

    def skip_password_validation?
      @student.skip_password_validation = params.dig(:user, :password).blank? &&
                                          params.dig(:user, :password_confirmation).blank?
    end
  end
end
