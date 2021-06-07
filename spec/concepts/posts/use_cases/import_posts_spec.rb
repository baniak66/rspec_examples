require "rails_helper"

RSpec.describe Posts::UseCases::ImportPosts do
  let(:instance) { described_class.new }
  subject { instance.sample }

  describe ".sample" do
    # it "returns sample posts array" do
    #   expect(subject).to be_a_kind_of(Array)
    # end

    # context "when number param not provided" do
    #   it "retuns array with 5 elements" do
    #     expect(subject.count).to eq(5)
    #   end
    # end

    # context "when number param provided" do
    #   subject { instance.sample(3) }

    #   it "retuns array with 3 elements" do
    #     expect(subject.count).to eq(3)
    #   end
    # end

    context "when api call stubbed" do
      let(:sample_post_response) do
        [
          { title: "title 1", body: "body 1" },
          { title: "title 2", body: "body 2" },
          { title: "title 3", body: "body 3" },
          { title: "title 4", body: "body 4" },
          { title: "title 5", body: "body 5" }
        ]
      end

      before do
        stub_request(:get, Posts::UseCases::ImportPosts::POST_API_URL).
          to_return(body: sample_post_response.to_json, status: 200)
      end

      it "retuns array with 5 elements" do
        expect(subject.count).to eq(5)
      end

      it "returns proper posts array" do
        expect(subject).to eq(sample_post_response.map(&:stringify_keys))
      end

      context "when number param provided" do
        subject { instance.sample(3) }

        it "retuns array with 3 elements" do
          expect(subject.count).to eq(3)
        end
      end
    end
  end
end