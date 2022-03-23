class Course < ApplicationRecord
  include SlugCandidate
  include ImageMedia

  acts_as_paranoid

  enum status: %w[published un_published].freeze

  has_many :course_sections
  has_many :sections, through: :course_sections

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
