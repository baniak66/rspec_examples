class CountPostsFromDateJob < ApplicationJob
  queue_as :default

  def perform(date)
    Post.where("DATE(created_at) = ?", date).count
  end
end
