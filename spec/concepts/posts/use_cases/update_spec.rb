require "rails_helper"

RSpec.describe Posts::UseCases::Update do
  describe ".call" do
    let!(:post) { create :post, title: "title", body: "body" }
    let(:params) do
      {
        title: "title updated",
        body: "body updated"
      }
    end
    let(:instance) { described_class.new(post.id, params) }

    it "updates post title" do
      expect { instance.call }
        .to change { post.reload.title }.from("title").to("title updated")
    end

    it "updates post body" do
      expect { instance.call }
        .to change { post.reload.body }.from("body").to("body updated")
    end

    it "updates post attributes" do
      expect { instance.call }
        .to change { post.reload.body }.from("body").to("body updated")
        .and change { post.reload.title }.from("title").to("title updated")
    end

    it "returns post" do
      expect(instance.call).to eq(post)
    end
  end
end