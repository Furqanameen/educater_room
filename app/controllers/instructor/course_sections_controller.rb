module Instructor
  class CourseSectionsController < Instructor::BaseController
    def index
      @course_sections = current_user.course_sections
                                     .includes(:course, section: [:batch])
                                     .order(section_id: :desc)
    end
  end
end
