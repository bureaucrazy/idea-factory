class Comment < ActiveRecord::Base
  belongs_to :idea
  belongs_to :user

  validates :body, presence: {message: "Content is required."},
                   uniqueness: {scope: :idea_id}

  def user_name
    if user
      user.name
    else
      "Anonymous"
    end
  end
end
