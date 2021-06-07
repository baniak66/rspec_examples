module Posts
  module UseCases
    class Update
      def initialize(post_id, params)
        @post_id = post_id
        @params = params
      end

      def call
        post.update(params)
      end

      private

      attr_reader :post_id, :params

      def post
        Post.find(post_id)
      end
    end
  end
end