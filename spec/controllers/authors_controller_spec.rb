require "rails_helper"

RSpec.describe AuthorsController, :type => :controller do
    
    describe "GET #index" do
        
        it "returns a successful http request status code" do
            get :index
            
            expect(response).to have_http_status(:success)
        end
        
    end
    
    describe "GET #show" do
        
        let(:author) { Fabricate(:author)}
        
        it "returns a successful http request code" do
            author = Fabricate(:author)
            get :show, id: author.id
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
            
            it "save the new author object" do
                post :create, author: Fabricate.attributes_for(:author)
                expect(Author.count).to eq(1)
            end
            
            it "redirect to the show action" do
                 post :create, author: Fabricate.attributes_for(:author)
                 expect(response).to redirect_to author_path(Author.last)
            end
            
            it "flash successful message" do
                post :create, author: Fabricate.attributes_for(:author)
                expect(flash[:success]).to eq('Author has been created.')
            end
        end
        
        context "an unsuccessful create" do
            
            it "does not save the new author object with invalid inputs" do
                 post :create, author: Fabricate.attributes_for(:author, first_name: nil)
                 expect(Author.count).to eq(0)
            end
            
            it "renders the new template" do
                post :create, author: Fabricate.attributes_for(:author, first_name: nil)
                expect(response).to render_template :new
            end
            
            it "flash fault message" do
                post :create, author: Fabricate.attributes_for(:author, first_name: nil)
                expect(flash[:danger]).to eq('Author has not been created.')
            end
        end
        
    end
    
    describe "GET #edit" do
        
        let(:author) {Fabricate(:author)}
        
        it "send a successful edit request" do
            
            get :edit, id: author
            expect(response).to have_http_status(:success)
        end
        

    end
    
    describe "PUT #update" do
        
        context "a successful update" do
            let(:john) {Fabricate(:author, first_name: "John")}
            
            it "updates modified author object" do
                put :update, author: Fabricate.attributes_for(:author, first_name: 'Paul'), id: john.id
                expect(Author.first.first_name).to eq('Paul')
                expect(Author.first.first_name).not_to eq('John')
            end
            
            it "redirect to the author show" do
                 put :update, author: Fabricate.attributes_for(:author, first_name: 'Paul'), id: john.id
                 expect(response).to redirect_to author_path(Author.first)
            end
            
            it "flash successful message" do
                put :update, author: Fabricate.attributes_for(:author, first_name: 'Paul'), id: john.id
                expect(flash[:success]).to eq('Author has been updated.')
            end
        end
        
        context "an unsuccessful update" do
            let(:author){Fabricate(:author, first_name: 'Paul')}
            
            it "does not update modified author object with invalid inputs" do
                put :update, author: Fabricate.attributes_for(:author, first_name: ''), id: author.id
                expect(Author.first.first_name).to eq('Paul')
                
            end
            
            
            it "flash unsuccessful message" do
                put :update, author: Fabricate.attributes_for(:author, first_name: ''), id: author.id
                expect(flash[:danger]).to eq('Author has not been updated.')
            end
        end
    end
    
    describe "DELETE #destroy" do
        
        let(:author) { Fabricate(:author)}
        
        it "delete author with given id" do
            delete :destroy, id: author.id
            expect(Author.count).to eq(0)
        end
        
        it "sets the flash message" do
            delete :destroy, id: author.id
            expect(flash[:success]).to eq("Author has been deleted.")
        end
        
        it "it redirect_to index action" do
            delete :destroy, id: author.id
            expect(response).to redirect_to authors_path
        end
    end
    
end