class User < ApplicationRecord
    has_many :chat_room_users, dependent: :destroy
    has_many :chat_rooms, through: :chat_room_users
    
    has_many :follow_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :followed_relationships, class_name: "Relationship", foreign_key: "followee_id", dependent: :destroy
    has_many :followees, through: :follow_relationships, source: :followee
    has_many :followers, through: :followed_relationships, source: :follower

    has_many :messages
    has_many :posts 

    has_many :likes, dependent: :destroy
    has_many :like_posts, through: :likes, source: :post

    def get_relationship(user)
        Relationship.find_by(follower_id: self.id, followee_id: user.id)
    end

    def like?(post)
        Like.find_by(user_id: self.id, post_id: post.id)
    end
end
