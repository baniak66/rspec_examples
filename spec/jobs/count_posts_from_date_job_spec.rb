require "rails_helper"

RSpec.describe CountPostsFromDateJob do
  let(:date) { Date.current }

  describe ".perform_now" do

    before do
      create :post, created_at: Time.now - 2.days
      create :post, created_at: Time.now - 1.hour
    end

    it "returns number of posts from date" do
      expect(described_class.perform_now(date)).to eq(1)
    end
  end

  describe ".perform_later" do
    it "enque job" do
      ActiveJob::Base.queue_adapter = :test
      expect { described_class.perform_later(date) }.to have_enqueued_job(CountPostsFromDateJob)
    end
  end
end