class Post < ApplicationRecord

    has_many :postsubs

    has_many :subs,
    through: :postsubs,
    source: :sub

    belongs_to :author,
    class_name: :User

    has_many :comments


end