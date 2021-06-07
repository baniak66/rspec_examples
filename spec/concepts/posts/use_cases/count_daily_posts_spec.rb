require "rails_helper"

RSpec.describe Posts::UseCases::CountDailyPosts do
  describe ".call" do
    before do
      create :post, created_at: Time.now - 2.days
      create :post, created_at: Time.now - 1.hour
    end
    let(:date) { Date.current }

    it "calls delayed job" do
      expect(CountPostsFromDateJob).to receive(:perform_later).with(date)
      described_class.call(date)
    end

    it "enque job" do
      ActiveJob::Base.queue_adapter = :test
      expect { described_class.call(date) }.to have_enqueued_job(CountPostsFromDateJob)
    end
  end
end