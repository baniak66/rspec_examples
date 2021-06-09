require "rails_helper"

RSpec.describe Posts::Representers::Multiple do
  describe ".call" do
    let(:post_1) { create :post }
    let(:post_2) { create :post }
    let(:posts) { [post_1, post_2] }

    it "returns proper hash" do
      expect(Posts::Representers::Multiple.new(posts).call).to match_array(
        [
          {
            id: post_2.id,
            title: post_2.title,
            body: post_2.body
          },
          {
            id: post_1.id,
            title: post_1.title,
            body: post_1.body
          }
        ]
      )
    end
  end
end