require 'faraday'

class PostImporter
  POST_API_URL = 'https://jsonplaceholder.typicode.com/posts'

  def self.call
    response = Faraday.get POST_API_URL
    response.body
  end
end