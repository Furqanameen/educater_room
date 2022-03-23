module VideoMedia
  extend ActiveSupport::Concern
  included do
    has_many_attached :videos

    VIDEO_TYPES = %w[video/mov video/mpeg video/mp4 video/avi].freeze

    validates :videos, content_type: { in: VIDEO_TYPES, message: 'invalid format' }, requisites: false

  end
end
