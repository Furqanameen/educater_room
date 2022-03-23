module Organisation
  class SectionsController < Organisation::BaseController
    before_action :load_section, only: %i[show edit update destroy enroll_students enroll_students_modal]

    def index
      @sections = filtered_sections
      @batches  = Batch.all
    end

    def new
      @section = Section.new
      form_data
    end

    def create
      @section = Section.create(section_params)
      if @section.save
        redirect_to organisation_sections_path, notice: 'Section was successfully created.'
      else
        form_data
        flash[:alert] = @section.errors.full_messages.to_sentence
        render :new
      end
    end

    def show; end

    def edit
      form_data
    end

    def update
      if @section.update(section_params)
        redirect_to organisation_sections_path, notice: 'Section was successfully updated.'
      else
        form_data
        render :edit
      end
    end

    def destroy
      if @section.destroy
        flash[:notice] = 'Section deleted!'
      else
        flash[:alert] = 'Section not delete!'
      end
      redirect_to organisation_sections_path
    end

    def restore
      @section = Section.with_deleted.find params[:id]

      return redirect_to organisation_sections_path, notice: 'Section was successfully restored.' if @section.restore
    end

    def enroll_students_modal
      @students = User.student
    end

    def enroll_students
      # @section.course_sections  = @section.course_sections.joins(:users).where('users.role = ?', 'student')
      selected_users   = params[:user_ids].present? ? User.where(id: params[:user_ids]) : []
      selected_courses = params[:course_ids].present? ? @section.course_sections.where(course_id: params[:course_ids]) : []

      # enrolling_courses = selected_courses         - @section.course_sections
      removing_courses  = @section.course_sections - selected_courses
      CourseSectionUser.where(course_section_id: removing_courses.pluck(:id)).delete_all if removing_courses.present?

      selected_courses.each do |course_section|
        enrolling_students = selected_users       - course_section.users
        removing_users     = course_section.users - selected_users
        course_section.users << enrolling_students  if enrolling_students.present?
        course_section.users.delete(removing_users) if removing_users.present?
      end
    end

    private

    def section_params
      params.require(:section).permit(:title, :description, :batch_id, course_sections_attributes: course_sections_params)
    end

    def course_sections_params
      [:id, :course_id, :_destroy, course_section_users_attributes: course_section_users_params]
    end

    def course_section_users_params
      %i[id user_id _destroy]
    end

    def load_section
      @section = Section.find params[:id]
    end

    def form_data
      @batches     = Batch.all
      @courses     = Course.published
      @instructors = User.instructor
    end

    def filtered_sections
      sections   = Section.with_deleted
      batch      = params.dig(:filter, :batch)
      constraint = params.dig(:filter, :constraint)

      sections = sections.where(batch_id: batch) if batch.present?

      case constraint
      when 'deleted'
        sections.deleted
      else
        sections
      end
    end
  end
end
