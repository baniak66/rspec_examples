require "rails_helper"

RSpec.describe Posts::UseCases::Create do
  describe ".call" do
    let(:params) do
      {
        title: "title",
        body: "body"
      }
    end
    let(:instance) { described_class.new(params) }

    it "creates post record" do
      expect { instance.call }.to change { Post.count }.by(1)
    end

    it "creates post record" do
      expect { instance.call }.to change { Post.count }.from(0).to(1)
    end

    it "returns post" do
      expect(instance.call).to be_a_kind_of(Post)
    end

    it "returns post with proper attributes" do
      expect(instance.call).to have_attributes(params)
    end
  end
end