require "rails_helper"

RSpec.describe Posts::UseCases::Update do
  let!(:post) { create :post, title: "title", body: "body" }
  let(:params) do
    {
      title: title,
      body: "body updated"
    }
  end
  let(:title) { "title updated" }
  let(:instance) { described_class.new(post.id, params) }

  subject { instance.call }

  describe ".call" do
    it "updates post" do
      expect { subject }
        .to change { post.reload.title }.from("title").to("title updated")
        .and change { post.reload.body }.from("body").to("body updated")
    end

    it "retuns true" do
      expect(subject).to eq(true)
    end

    it { is_expected.to eq true }
    it { is_expected.to be_truthy } # !!!
    it { expect("siema").to be_truthy } # !!!

    context "when params invalid" do
      let(:title) { nil }

      it "doesn't update post" do
        expect { subject }.not_to change { post.reload.title }
      end

      it { is_expected.to eq false }
    end
  end
end