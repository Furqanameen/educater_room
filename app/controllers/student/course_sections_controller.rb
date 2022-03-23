module Student
  class CourseSectionsController < Student::BaseController
    def index
      # will use current_user there
      @student         = User.where(role: User.roles[:student]).last
      @course_sections = @student.course_sections
    end
  end
end
