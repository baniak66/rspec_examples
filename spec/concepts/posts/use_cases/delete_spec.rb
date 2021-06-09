require "rails_helper"

RSpec.describe Posts::UseCases::Delete do
  describe ".call" do
    let!(:post) { create :post }
    let(:instance) { described_class.new(post.id) }

    it "deletes post record" do
      expect { instance.call }.to change { Post.count }.by(-1)
    end

    it "deletes post record" do
      instance.call
      expect(Post.find_by(id: post.id)).to eq(nil)
    end
  end
end