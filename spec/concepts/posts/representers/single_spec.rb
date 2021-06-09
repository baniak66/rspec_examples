require "rails_helper"

RSpec.describe Posts::Representers::Single do
  describe ".call" do
    let(:post) { create :post }
    let(:instance) { Posts::Representers::Single.new(post) }

    it "returns proper hash" do
      expect(instance.call).to eq(
        {
          id: post.id,
          title: post.title,
          body: post.body
        }
      )
    end
  end
end