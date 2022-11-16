# frozen_string_literal: true

RSpec.describe HTTP::UserRoutes, type: :request do
  describe "POST /signup" do
    subject(:signup) { post "/", **params }

    context "with valid params" do
      let(:params) do
        {
          name: "Anna",
          email: "anna@example.com",
          password: "qwerty123"
        }
      end

      it "responds with 201" do
        signup
        expect(response_status).to eq(201)
      end

      it "creates new record" do
        expect { signup }.to change(Auth::User, :count).by(1)
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          email: "anna@example.com",
          password: "qwerty123"
        }
      end

      it "responds with 422" do
        signup
        expect(response_status).to eq(422)
      end

      it "does not create new record" do
        expect { signup }.not_to change(Auth::User, :count)
      end

      it "renders errors" do
        signup
        expect(response_json["errors"]).to include(
          "detail" => "is missing",
          "source" => { "pointer" => "/data/attributes/name" }
        )
      end
    end
  end
end
