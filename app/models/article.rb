class Article < ActiveRecord::Base
   has_many :article_categories
   has_many :categories, through: :article_categories
   belongs_to :user
   has_many :likes
   validates :title, presence:true, length: {minimum: 3, maximum: 50}
   validates :description, presence:true, length: {minimum: 10, maximum: 300}
   validates :user_id, presence: true
   default_scope -> {order(updated_at: :desc)}
   
   def self.search(param)
        return Article.none if param.blank?
        param.strip!
        param.downcase!
        (title_matches(param)).uniq
    end
    def self.title_matches(param)
        matches('title', param)
    end
    def self.matches(field_name, param)
        where("lower(#{field_name}) like ?", "%#{param}%")
    end
    def thumbs_up_total
       self.likes.where(like: true).size 
    end
    def thumbs_down_total
        self.likes.where(like: false).size
    end
    
end