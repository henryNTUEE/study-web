class User <ActiveRecord::Base
    has_many :articles, dependent: :destroy
    has_many :friendships
    has_many :likes
    has_many :friends, through: :friendships
    before_save {self.email = email.downcase}
    validates :username, presence: true, uniqueness: {case_sensitive: false},length: { minimum: 3, maximum: 25}
    VALID_EMAIL = /\A[\w+\-,]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 120},uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL }
    has_secure_password
    def not_friends_with?(friend_id)
        friendships.where(friend_id: friend_id).count < 1    
    end
    def except_current_user(users)
        users.reject {|user| user.id == self.id}
    end
    def self.search(param)
        return User.none if param.blank?
        param.strip!
        param.downcase!
        (username_matches(param) + email_matches(param)).uniq
    end
    def self.username_matches(param)
        matches('username', param)
    end
    def self.email_matches(param)
        matches('email', param)
    end
    def self.matches(field_name, param)
        where("lower(#{field_name}) like ?", "%#{param}%")
    end
end