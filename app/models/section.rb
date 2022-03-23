class Section < ApplicationRecord
  include SlugCandidate

  acts_as_paranoid

  belongs_to :batch

  has_many   :course_sections, dependent: :destroy
  has_many   :courses, through: :course_sections

  accepts_nested_attributes_for :course_sections,
                                reject_if: proc { |attributes| attributes['course_id'].blank? },
                                allow_destroy: true

  validates :title, presence: true, uniqueness: { case_sensitive: false, scope: :batch_id }

  scope :of_user, ->(user) { joins(course_sections: [:course_section_users]).where('course_section_users.user_id = ?', user.id).uniq }
end
