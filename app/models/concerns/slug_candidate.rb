module SlugCandidate
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :slug_candidates

    private

    def should_generate_new_friendly_id?
      if self.class.name == 'User'
        slug.blank? || first_name_changed? || last_name_changed?
      else
        slug.blank? || title_changed?
      end
    end

    def slug_candidates
      if self.class.name == 'User'
        [
          :first_name,
          %i[first_name last_name],
          [:first_name, :last_name, Digest::SHA1.hexdigest(Time.now.to_s)[0..6]]
        ]
      else
        [
          :title,
          [:title, Digest::SHA1.hexdigest(Time.now.to_s)[0..6]]
        ]
      end
    end
  end
end
