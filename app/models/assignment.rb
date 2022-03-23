class Assignment < ApplicationRecord
  include SlugCandidate

  acts_as_paranoid

  belongs_to :course_section

  has_many_attached :files

  FILE_TYPES = %w[application/pdf].freeze

  validates :title, presence: true
  validates :files, content_type: { in: FILE_TYPES, message: 'invalid format' }, requisites: false
end
