module OrganizationsHelper
  def get_flash_key(key)
    key == 'alert' ? 'danger' : 'success'
  end

  def selected_section(object)
    object.course_sections.map(&:section_id)
  end

  def selected_section_courses(section)
    course_ids = []
    section.course_sections.each{|c_s| course_ids << c_s.course_id if c_s.course_section_users.present? && c_s.users.student.present? }
    course_ids&.uniq
  end

  def selected_section_students(section)
    user_ids = []
    section.course_sections.each{|c_s| user_ids << c_s.course_section_users.map(&:user_id)}
    user_ids&.reduce(:concat)&.uniq
  end

end
