class User < ApplicationRecord
  include SlugCandidate
  include ImageMedia

  acts_as_paranoid

  attr_accessor :skip_password_validation

  enum role: { admin: 0, org_owner: 1, instructor: 2, student: 3 }

  has_one  :organization, dependent: :destroy

  has_many :course_section_users, dependent: :destroy
  has_many :course_sections, through: :course_section_users
  has_many :user_answers
  has_many :answers, through: :user_answers

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :set_uuid


  accepts_nested_attributes_for :organization

  validates :password, length: {:within => 6..40}, if: Proc.new { |user| user.password.present? }

  validate :min_birth_date

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def password_required?
    return false if skip_password_validation

    super
  end

  def set_uuid
    update(uuid: Digest::SHA1.hexdigest("site -- #{$SITE_NAME} -- email -- #{email}"))
  end

  def min_birth_date
    min_date = Date.today.year - 2
    errors.add(:birth_date, "Birth year should be less than #{min_date}") if birth_date.present? && birth_date.year > min_date
  end

end
