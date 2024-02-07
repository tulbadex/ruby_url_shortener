class Link < ApplicationRecord
    belongs_to :user, optional: true
    has_many :views, dependent: :destroy
    scope :recent_first, -> { order(created_at: :desc)}
    # Ex:- scope :active, -> {where(:active => true)}
    validates :url, presence: true

    after_save_commit if: :url_previously_changed? do
        MetadataJob.perform_later(to_param)
    end

    def self.find(id)
        super (id.is_a?(Integer) ? id : Base62.decode(id))
    end

    def self.find_by_short_code(code)
        find Base62.decode(code)
    end

    def to_param
        Base62.encode(id)
    end

    def domain
        URI(url).host rescue URI::InvalidURIError
    end

    # return false if no user_id on link
    # return boolean if user.id matches user_id on link
    def editable_by?(user)
        # return false unless user_id?
        # user_id == user&.id
        user_id? && (user_id == user&.id)
    end
end
