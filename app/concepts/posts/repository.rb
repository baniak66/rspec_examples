module Posts
  class Repository
    def initialize(adapter = Post)
      @adapter = adapter
    end

    def recent
      adapter.order('posts.created_at ASC').last(3)
    end

    private

    attr_reader :adapter
  end
end