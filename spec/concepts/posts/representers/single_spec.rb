require "rails_helper"

RSpec.describe Posts::Representers::Single do
  let(:post) { create :post }
  let(:instance) { described_class.new(post) }
  let(:expected_hash) do
    {
      id: post.id,
      title: post.title,
      body: post.body
    }
  end

  subject { instance.call }

  describe ".call" do
    it "returns hash with proper structure" do
      expect(subject).to eq(expected_hash)
    end
  end
end