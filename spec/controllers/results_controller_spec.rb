require "rails_helper"

describe ResultsController do
  before do
    loader = double(:audit, report: Report.new([]))
    allow(ReportLoader).to receive(:new).and_return(loader)
  end

  context "with a url param" do
    context "with a valid url" do
      it "responds with success and no error message" do
        get :index, url: "http://google.com"

        expect(response).to be_success
        expect(request.flash.now[:error]).to be_blank
      end

      context "with a runner error" do
        it "rescues with a flash notice" do
          allow(Runner).to receive(:new).and_raise(Runner::RunnerError)

          get :index, url: "http://google.com"

          expect(request.flash.now[:error]).not_to be_blank
          expect(assigns[:report]).to be_a EmptyReport
        end
      end
    end

    context "with an invalid url" do
      it "renders an error message" do
        get :index, url: "google"

        expect(request.flash.now[:error]).not_to be_blank
        expect(assigns[:report]).to be_a EmptyReport
      end
    end

    context "with an empty url" do
      it "rescues with a flash notice" do
        get :index, url: ""

        expect(request.flash.now[:error]).not_to be_blank
        expect(assigns[:report]).to be_a EmptyReport
      end
    end
  end

  context "with no url param" do
    it "rescues with a flash notice" do
      get :index

      expect(request.flash.now[:error]).not_to be_blank
      expect(assigns[:report]).to be_a EmptyReport
    end
  end
end
