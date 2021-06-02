require "rails_helper"

RSpec.describe "Posts requests", type: :request do
  describe "GET /posts" do
    context "when no posts in db" do
      before { get("/posts") }

      it "works and return status 200" do
        expect(response.status).to eq(200)
      end

      it "returns proper json response" do
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context "when posts records in db" do
      let!(:post) { create :post }
      let(:post_attr) do
        {
          "id" => post.id,
          "title" => post.title,
          "body" => post.body
        }
      end
      let(:expected_response) { [post_attr] }

      before { get("/posts") }

      it "works and return status 200" do
        expect(response.status).to eq(200)
      end

      it "returns proper json response" do
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end
  end
end