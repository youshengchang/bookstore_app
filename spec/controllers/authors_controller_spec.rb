require "rails_helper"

RSpec.describe AuthorsController, :type => :controller do
    
    describe "GET #index" do
        
        it "returns a successful http request status code" do
            get :index
            
            expect(response).to have_http_status(:success)
        end
        
     #   it "assignes the authors object to @authors variable" do
     #       author1 = Fabricate(:author)
     #       author2 = Fabricate(:author)
     #       
     #       get :index
     #       expect(assigns(:authors)).to match_array([author1, author2])
     #   end
     #   it "renders the index template" do
            
     #       get :index
     #       expect(response).to render_template :index
     #   end
    end
    
    describe "GET #show" do
        
        let(:author) { Fabricate(:author)}
        
        it "returns a successful http request code" do
            author = Fabricate(:author)
            get :show, id: author.id
            expect(response).to have_http_status(:success)
        end
        
    #    it "find the author with the given id and assign it to @author variable" do
            #author = Fabricate(:author)
            
    #        get :show, id: author
    #        expect(assigns(:author)).to eq(author)
    #    end
        
    #    it "renders the show template" do
            
            #author = Fabricate(:author)
     #       get :show, id: author
     #       expect(response).to render_template :show
            
     #   end
    end
    
    describe "GET #new" do
        
        it "returns a successful http status code" do
            get :new
            expect(response).to have_http_status(:success)
        end
        
        #it "assigns a new author object to the @author variable" do
            
        #    get :new
            
        #    expect(assigns(:author)).to be_instance_of(Author)
        #end
        
        #it "renders the new template" do
            
        #    get :new
        #    expect(response).to render_template 'new'
        #end
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
        
       # it "find author with given id and assign it to @author variable" do
    #            get :edit, id: author
     #       expect(assigns(:author)).to eq(author)
      #  end
        
      #  it "renders the edit template" do
       #     get :edit, id: author
        #    expect(response).to render_template :edit
        #end
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
    
end