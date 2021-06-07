require "rails_helper"

RSpec.describe Posts::Repository do
  let(:instance) { described_class.new }

  describe ".recent" do
    let!(:post_1) { create :post, created_at: Time.current - 6.hours }
    let!(:post_2) { create :post, created_at: Time.current - 12.hours }
    let!(:post_3) { create :post, created_at: Time.current - 1.days }
    let!(:post_4) { create :post, created_at: Time.current - 2.days }
    let!(:post_5) { create :post, created_at: Time.current - 3.days }

    subject { instance.recent }

    it "returns 3 recent posts" do
      expect(subject).to match_array([post_1, post_2, post_3])
    end
  end
end