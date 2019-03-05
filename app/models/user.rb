class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    has_many :subs,
        foreign_key: :moderator_id
    has_many :posts,
        foreign_key: :author_id
    has_many :comments,
        foreign_key: :author_id

    attr_reader :password

    after_initialize :ensure_session_token

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)

    end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom.urlsafe_base64
    end

    def self.find_by_credentials(username, password)
        u = User.find_by(username: username)
        u && u.is_password?(password) ? u : nil
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    

end