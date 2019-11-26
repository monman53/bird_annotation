class Annotation < ApplicationRecord
    validates :path, presence: true
    validates :category_id, presence: true
    validates :information, presence: true

    belongs_to :allocation

end
