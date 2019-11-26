class Allocation < ApplicationRecord
    validates :user_id, presence: true
    validates :annotation_id, presence: true

    belongs_to :user
    has_many :annotations


end
