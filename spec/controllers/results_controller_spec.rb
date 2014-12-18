require "rails_helper"

describe ResultsController do
  before do
    audit = double(:audit, execute: [])
    allow(Audit).to receive(:new).and_return(audit)
  end

  context "with a url param" do
    context "with a valid url" do
      it "responds with success and no error message" do
        get :index, url: "http://google.com"

        expect(response).to be_success
        expect(request.flash.now[:error]).to be_blank
      end
    end

    context "with an invalid url" do
      it "renders an error message" do
        get :index, url: "google"

        expect(request.flash.now[:error]).not_to be_blank
      end
    end
  end

  context "with no url param" do
    it "rescues with a flash notice" do
      get :index

      expect(request.flash.now[:error]).not_to be_blank
    end
  end
end
