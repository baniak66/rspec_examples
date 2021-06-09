module Posts
  module Representers
    class Multiple
      def initialize(posts)
        @posts = posts
      end

      def call
        posts.map do |post|
          # Posts::Representers::Single.new(post).call
          {
            id: post.id,
            title: post.title,
            body: post.body
          }
        end
      end

      private

      attr_reader :posts
    end
  end
end