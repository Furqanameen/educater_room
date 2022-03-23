module ImageMedia
  extend ActiveSupport::Concern
  included do
    IMAGE_TYPES = %w[image/gif image/jpeg image/pjpeg image/x-png image/png].freeze

    has_one_attached :image

    validates :image, content_type: { in: IMAGE_TYPES, message: 'invalid format' }, requisites: false

    def image_path
      image.attached? ? image : 'account-add-photo.svg'
    end
  end
end
