class CourseSection < ApplicationRecord
  belongs_to  :course
  belongs_to  :section

  has_many    :lessons
  has_many    :quizzes
  has_many    :assignments
  has_many    :course_section_users, dependent: :destroy
  has_many    :users, through: :course_section_users

  accepts_nested_attributes_for :course_section_users,
                                reject_if: proc { |attributes| attributes['user_id'].blank? },
                                allow_destroy: true
  accepts_nested_attributes_for :course, reject_if: proc { |attributes| attributes['title'].blank? }
  accepts_nested_attributes_for :lessons, reject_if: proc { |attributes| attributes['title'].blank? }
  accepts_nested_attributes_for :quizzes
end
