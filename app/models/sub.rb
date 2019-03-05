class Sub < ApplicationRecord
    
    has_many :postsubs

    has_many :posts,
    through: :postsubs,
    source: :post

    belongs_to :moderator,
    class_name: :User

end