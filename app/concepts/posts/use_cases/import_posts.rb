require 'faraday'

module Posts
  module UseCases
    class ImportPosts
      POST_API_URL = 'https://jsonplaceholder.typicode.com/posts'

      def sample(number = 5)

        parse_posts.first(number)
      end

      private

      def fetch_posts
        response = Faraday.get POST_API_URL
        response.body
      end

      def parse_posts
        JSON.parse(fetch_posts)
      end
    end
  end
end