module Instructor
  class AssignmentsController < Instructor::BaseController
    before_action :load_course_section
    before_action :load_assignment, only: %i[edit update show destroy]

    def index
      @assignments = filter_assignments
    end

    def new
      @assignment = Assignment.new
    end

    def create
      @assignment = @course_section.assignments.new(assignment_params)
      if @assignment.save
        redirect_to instructor_course_section_assignments_path(@course_section), notice: 'Assignment is created successfully.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @assignment.update(assignment_params)
        redirect_to instructor_course_section_assignments_path(@course_section), notice: 'Assignment is Updated successfully.'
      else
        render :edit
      end
    end

    def show; end

    def destroy
      if @assignment.destroy
        flash[:notice] = 'Assignment deleted!'
      else
        flash[:alert] = 'Assignment not delete!'
      end
      redirect_to instructor_course_section_assignments_path(@course_section)
    end

    def restore
      @assignment = Assignment.with_deleted.find(params[:id])

      redirect_to instructor_course_section_assignments_path(@course_section),  notice: 'Assignment has been restored' if @assignment.restore
    end

    private

    def load_course_section
      @course_section = current_user.course_sections.find(params[:course_section_id])
    end

    def load_assignment
      @assignment = @course_section.assignments.find(params[:id])
    end

    def assignment_params
      params.require(:assignment).permit(:title, :description, :start_date, :end_date, :course_section_id, files: [])
    end


    def filter_assignments
      assignments = @course_section.assignments.with_deleted
      start_date = params.dig(:filter, :start_date)
      end_date   = params.dig(:filter, :end_date)
      constraint = params.dig(:filter, :constraint)

      assignments = assignments.where('start_date >= ?', start_date.to_datetime)  if start_date.present?
      assignments = assignments.where('end_date <= ?', end_date.to_datetime)      if end_date.present?

      case constraint
      when 'deleted'
        assignments.deleted
      else
        assignments
      end
    end

  end
end
