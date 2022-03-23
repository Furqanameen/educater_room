class Lesson < ApplicationRecord
  include SlugCandidate
  include VideoMedia
  include FileMedia

  acts_as_paranoid

  belongs_to :course_section

  validates :title, presence: true
end
