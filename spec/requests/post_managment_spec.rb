require "rails_helper"

RSpec.describe "Post request", type: :request do
  describe "GET /posts" do
    context "when no posts in db" do
      before { get "/posts" }

      it "retuns 200 status" do
        expect(response.status).to eq(200)
      end

      it "returns proper body" do
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context "when posts in db" do
      let!(:post_1) { create :post }

      it "retuns 200 status" do
        get "/posts"
        expect(response.status).to eq(200)
      end

      it "returns proper body" do
        get "/posts"
        expect(JSON.parse(response.body)).to eq(
          [
            {
              "id" => post_1.id,
              "title" => post_1.title,
              "body" => post_1.body
            }
          ]
        )
      end

      context "when more than one post in db" do
        let!(:post_1) { create :post }
        let!(:post_2) { create :post }

        it "returns body with 2 posts" do
          get "/posts"
          expect(JSON.parse(response.body).count).to eq(2)
        end
      end
    end
  end
end