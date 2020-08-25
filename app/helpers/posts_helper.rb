module PostsHelper
  def total_likes(post)
    Post.likes_count(post)
  end

  # def total_comments

  # end

end
