class Idea < ActiveRecord::Base
  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :joins, dependent: :destroy
  has_many :joining_users, through: :joins, source: :user

  validates :title, presence: {message: "Title required."},
                    uniqueness: {scope: :body},
                    length: {minimum: 3}
  validates :body, presence: true,
                   length: {minimum: 3}


  def self.search(value)
    search_term = "%#{value}%"
    where(["title ILIKE :term OR body ILIKE :term", {term: search_term}])
  end

  def user_name
    if user
      user.name
    else
      "Anonymous"
    end
  end

  def like_for(user)
    likes.find_by_user_id(user.id)
  end

  def join_for(user)
    joins.find_by_user_id(user.id)
  end

end
