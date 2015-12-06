require 'rails_helper'

RSpec.describe PublishersController, :type => :controller do
    
    describe "GET #index" do
        it "returns a successful http request status code" do
            get :index
            
            expect(response).to have_http_status(:success)
        end
    end
    
    describe "GET #show" do
        let(:publisher) { Fabricate(:publisher)}
        
        it "returns a successful http request code" do
            publisher = Fabricate(:publisher)
            get :show, id: publisher.id
            expect(response).to have_http_status(:success)
        end
        
    end
    
    describe "GET #new" do
        
        it "returns a successful http status code" do
            get :new
            expect(response).to have_http_status(:success)
        end

    end
end