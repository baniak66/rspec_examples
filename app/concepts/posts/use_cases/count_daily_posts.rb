module Posts
  module UseCases
    class CountDailyPosts
      def self.call(date)
        CountPostsFromDateJob.perform_later(Date.current)
      end

      private

      attr_reader :params
    end
  end
end