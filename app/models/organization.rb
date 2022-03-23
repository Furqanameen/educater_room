class Organization < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  after_create :set_ouid

  COPY_ORG_ATTRS         = %w[name additional_information].freeze
  ADDITIONAL_INFORMATION = %w[instructor_strength student_strength address education specialization].freeze

  ADDITIONAL_INFORMATION.each do |key|
    define_method key do
      additional_information[key]
    end
  end

  def org_copy_attributes
    attributes.select { |attr| COPY_ORG_ATTRS.include?(attr) }
  end

  class << self
    def normalized_name(name)
      name.downcase.parameterize
    end
  end

  private

  def set_ouid
    update(ouid: Digest::SHA1.hexdigest("site -- #{$SITE_NAME} -- name -- #{name}"))
  end
end
