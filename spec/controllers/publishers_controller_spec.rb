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
    
    describe "POST #create" do
        
        context "a successful create" do
            it "save the new publisher object" do
                post :create, publisher: Fabricate.attributes_for(:publisher)
                expect(Publisher.count).to eq(1)
            end
            
            it "flash a successful message" do
                post :create, publisher: Fabricate.attributes_for(:publisher)
                expect(flash[:success]).to eq("Publisher has been created.")
            end
            
            it "redirect to the publisher show action" do
                 post :create, publisher: Fabricate.attributes_for(:publisher)
                expect(response).to redirect_to publisher_path(Publisher.last)
            end
        end
        
        context "an unsuccessful create" do
            it "does not save the new publisher object" do
                post :create, publisher: Fabricate.attributes_for(:publisher, name:nil)
                expect(Publisher.count).to eq(0)
            end
            
            it "flash a unsuccessful message" do
                post :create, publisher: Fabricate.attributes_for(:publisher, name: nil)
                expect(flash[:danger]).to eq("Publisher has not been created.")
            end
            
            it "renders new template" do
                post :create, publisher: Fabricate.attributes_for(:publisher, name: nil)
                expect(response).to render_template :new
            end
        end
        
    end
    
    describe "GET #edit" do
        let(:publisher) {Fabricate(:publisher)}
        it "send a successful request" do
            get :edit, id: publisher
            
            expect(response).to have_http_status(:success)
        end
    end
    
    describe "PUT #update" do
        
        context "a successful publisher update" do
            let(:infotech) {Fabricate(:publisher, name: "Infotech")}
            
            it "updates the modified publisher" do
                 put :update, publisher: Fabricate.attributes_for(:publisher, name: "Info"), id: infotech.id
                 expect(Publisher.last.name).to eq('Info')
                 expect(Publisher.last.name).not_to eq('Infotech')
            end
            
            it "flash a successful message" do
                put :update, publisher: Fabricate.attributes_for(:publisher, name: "Info"), id: infotech.id
                expect(flash[:success]).to eq("Publisher has been updated.")
            end
            
            it "redriect to publisher show page" do
                put :update, publisher: Fabricate.attributes_for(:publisher, name: "Info"), id: infotech.id
                expect(response).to redirect_to publisher_path(Publisher.last) 
            end
            
        end
        
        context "an unsuccessful publisher update with invalid input" do
            let(:infotech) {Fabricate(:publisher, name: "Infotech")}
            
            it "does not update the publisher with invalid inputs" do
                put :update, publisher: Fabricate.attributes_for(:publisher, name: nil), id: infotech.id
                expect(Publisher.last.name).to eq("Infotech")
            end
            
            it "flash a fault message" do
                put :update, publisher: Fabricate.attributes_for(:publisher, name: nil), id: infotech.id
                expect(flash[:danger]).to eq("Publisher has not been updated.")
            end
        end
    end
    
    describe "DELETE #destroy" do
        let(:publisher) {Fabricate(:publisher)}
        
        it "delete the publisher with given id" do
            delete :destroy, id: publisher.id
            expect(Publisher.count).to eq(0)
        end
        
        it "flash the successful message" do
            delete :destroy, id: publisher.id
            expect(flash[:success]).to eq("Publisher has been deleted.")
        end
        
        it "redirect to index page" do
            delete :destroy, id: publisher.id
            expect(response).to redirect_to publishers_path
        end
    end
end