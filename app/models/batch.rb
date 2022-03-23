class Batch < ApplicationRecord
  include SlugCandidate

  acts_as_paranoid

  has_many :sections, dependent: :destroy

  accepts_nested_attributes_for :sections,
                                reject_if: proc { |attributes| attributes['title'].blank? },
                                allow_destroy: true

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  validates_presence_of :start_date
  validates_presence_of :end_date

  validate :sections_title_uniqueness
  validate :end_date_is_valid

  scope :of_user, ->(user) { joins(sections: [course_sections: [:course_section_users]]).where('course_section_users.user_id = ?', user.id).uniq }

  private

  def sections_title_uniqueness
    return if sections.blank?

    sections_titles = sections.map(&:title)
    errors.add(:base, 'Please use different title for each section') if sections_titles.present? && (sections_titles != sections_titles.uniq)
  end

  def end_date_is_valid
    errors.add(:base, 'Batch end date should be ahead of the start date') if end_date < start_date
  end
end
