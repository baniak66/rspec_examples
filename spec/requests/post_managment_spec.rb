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
      context "when one post in db" do
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

      context "when sample posts requested" do
        before { create_list(:post, 5) }

        it "returns proper number of posts in response" do
          get("/posts")
          expect(JSON.parse(response.body).count).to eq(5)
        end
      end
    end

    context "when sample posts requested" do
      let(:import_post) do
        instance_double(Posts::UseCases::ImportPosts, sample: sample_posts)
      end
      let(:sample_posts) do
        [
          { title: "title 1", body: "body 1" },
          { title: "title 2", body: "body 2" },
          { title: "title 3", body: "body 3" },
          { title: "title 4", body: "body 4" },
          { title: "title 5", body: "body 5" }
        ]
      end

      before do
        allow(Posts::UseCases::ImportPosts).to receive(:new).and_return(import_post)
        get("/posts", params: { sample: true })
      end

      it "works and return status 200" do
        expect(response.status).to eq(200)
      end

      it "returns proper number of posts in response" do
        expect(JSON.parse(response.body).count).to eq(5)
      end
    end
  end

  describe "GET /posts/:id" do
    context "when post not found" do
      let(:post_id) { 3434 }

      it "raises record not found error" do
        expect { get("/posts/#{post_id}") }.to raise_error(ActiveRecord::RecordNotFound)
      end

      context "when we want to mock error" do
        before do
          allow(Post).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        end

        it "raises record not found error" do
          expect { get("/posts/#{post_id}") }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      # it "returns json response with error" do
      #   get("/posts/#{post_id}")
      #   expect(JSON.parse(response.body)).to eq({ "error" => "post not found" })
      # end
    end
  end
end