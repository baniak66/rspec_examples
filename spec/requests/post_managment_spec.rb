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

      # context "when sample posts requested" do
      #   before { create_list(:post, 5) }

      #   it "returns proper number of posts in response" do
      #     get("/posts")
      #     expect(JSON.parse(response.body).count).to eq(5)
      #   end
      # end
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
    context "when post found" do
      let(:post) { create :post }

      before do
        get("/posts/#{post.id}")
      end

      it "returns success status" do
        expect(response.status).to eq(200)
      end

      it "returns proper json" do
        expect(JSON.parse(response.body).keys).to match_array(%w(id body title))
        # expect(JSON.parse(response.body).keys).to eq(%w(id body title)) !!! order
      end
    end

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

  describe "POST /posts" do
    let(:params) do
      {
        post: {
          title: "title",
          body: "body updated"
        }
      }
    end

    subject { post("/posts", params: params) }

    it "retuns success status" do
      subject
      expect(response.status).to eq(201)
    end
  end


  describe "PUT /posts/:id" do
    let(:post) { create :post, title: "title", body: "body" }
    let(:params) do
      {
        id: post.id,
        post: {
          title: title,
          body: "body updated"
        }
      }
    end
    let(:title) { "title updated" }

    subject { put("/posts/#{post.id}", params: params) }

    context "when params are valid" do
      it "retuns success status" do
        subject
        expect(response.status).to eq(200)
      end

      it "updates post params" do
        expect { subject }
          .to change { post.reload.title }.from("title").to("title updated")
          .and change { post.reload.body }.from("body").to("body updated")
      end
    end

    context "when params not valid" do
      let(:title) { nil }
      let(:expected_response) { { "title"=>["can't be blank"] } }

      it "retuns unprocess entity status" do
        subject
        expect(response.status).to eq(422)
      end

      it "retuns response with error message" do
        subject
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end
  end

  describe "DELETE /posts/:id" do
    let(:post) { create :post }

    subject { delete("/posts/#{post.id}") }

    it "retuns no content status" do
      subject
      expect(response.status).to eq(204)
    end
  end
end