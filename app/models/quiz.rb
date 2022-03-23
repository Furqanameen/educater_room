class Quiz < ApplicationRecord
  include SlugCandidate

  belongs_to  :course_section

  has_many    :questions, dependent: :destroy

  validates_presence_of :title, :description, :start_date, :end_date

  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end
