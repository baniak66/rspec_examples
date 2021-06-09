require "rails_helper"

RSpec.describe Posts::Repository do
  describe ".recent" do
    let(:instance) { Posts::Repository.new }
    # let(:instance) { described_class.new }
    let!(:post_1) { create :post, created_at: Time.current - 6.hours }
    let!(:post_2) { create :post, created_at: Time.current - 12.hours }
    let!(:post_3) { create :post, created_at: Time.current - 1.day }
    let!(:post_4) { create :post, created_at: Time.current - 2.day }
    let!(:post_5) { create :post, created_at: Time.current - 3.day }

    it "returns proper posts" do
      expect(instance.recent).to eq([post_3, post_2, post_1])
    end
  end
end