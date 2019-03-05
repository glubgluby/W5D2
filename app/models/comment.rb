class Comment < ApplicationRecord
    validates :body, presence: true

    belongs_to :parent_comment,
        class_name: :Comment,
        optional: true

    has_many :children,
        class_name: :Comment,
        foreign_key: :parent_comment_id
    

    belongs_to :author,
        class_name: :User

    belongs_to :post




end