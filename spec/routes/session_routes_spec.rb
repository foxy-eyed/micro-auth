# frozen_string_literal: true

RSpec.describe SessionRoutes, type: :request do
  describe "POST /auth" do
    subject(:login) { post "/", **params }

    context "with valid params" do
      let(:params) do
        {
          email: "anna@example.com",
          password: "qwerty123"
        }
      end

      context "when user exists" do
        let!(:user) { create(:user, email: params[:email], password: params[:password]) }

        it "responds with 201" do
          login
          expect(response_status).to eq(201)
        end

        it "creates new user session" do
          expect { login }.to change { user.reload.sessions.count }.by(1)
        end

        it "renders JWT token" do
          login
          expect(response_json["meta"]["token"]).not_to be_empty
        end
      end

      context "with invalid password" do
        before { create(:user, email: params[:email], password: "invalid") }

        it "responds with 401" do
          login
          expect(response_status).to eq(401)
        end
      end

      context "when user does not exist" do
        it "responds with 401" do
          login
          expect(response_status).to eq(401)
        end
      end
    end

    context "with invalid params" do
      let(:params) do
        { email: "anna@example.com" }
      end

      it "responds with 422" do
        login
        expect(response_status).to eq(422)
      end

      it "renders errors" do
        login
        expect(response_json["errors"]).to include(
          "detail" => "is missing",
          "source" => { "pointer" => "/data/attributes/password" }
        )
      end
    end
  end

  describe "GET /auth" do
    subject(:auth) { get "/", {}, headers }

    context "with valid token" do
      let(:user) { create(:user) }
      let(:headers) { { "HTTP_AUTHORIZATION" => auth_header_for(user) } }

      it "responds with 200" do
        auth
        expect(response_status).to eq(200)
      end

      it "renders meta with current user ID" do
        auth
        expect(response_json["meta"]).to eq("user_id" => user.id)
      end
    end

    context "without auth header" do
      let(:headers) { {} }

      it "responds with 403" do
        auth
        expect(response_status).to eq(403)
        expect(response_json["errors"]).to include("detail" => "Invalid token")
      end
    end

    context "with invalid token" do
      let(:headers) { { "HTTP_AUTHORIZATION" => "random_string" } }

      it "responds with 403" do
        auth
        expect(response_status).to eq(403)
        expect(response_json["errors"]).to include("detail" => "Invalid token")
      end
    end
  end
end
