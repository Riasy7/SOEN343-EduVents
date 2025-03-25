require 'rails_helper'

RSpec.describe "OrganizerDashboards", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/organizer_dashboard/index"
      expect(response).to have_http_status(:success)
    end
  end

end
