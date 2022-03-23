module FileMedia
  extend ActiveSupport::Concern
  included do
    has_many_attached :files

    FILE_TYPES  = %w[application/pdf].freeze

    validates :files,  content_type: { in: FILE_TYPES, message: 'invalid format' }, requisites: false

  end
end
