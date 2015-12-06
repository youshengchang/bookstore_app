class AuthorsController < ApplicationController
    
    before_action :set_author, except: [:index, :new, :create]
    
    
    def index
        @authors = Author.all
    end
    
    def show
        #@author = Author.find(params[:id])
        #require 'pry'; binding.prypara
    end
    
    def new
        @author = Author.new
    end
    
    def create
       #require 'pry'; binding.pry
        @author = Author.new(author_params)
        
        if @author.save
            flash[:success] = "Author has been created."
            redirect_to @author
        else
            flash[:danger] = "Author has not been created."
            render :new
        end
        
    end
    
    def edit
        #@author = Author.find(params[:id])
    end
    
    def update
       #@author = Author.find(params[:id])
       if @author.update(author_params)
            flash[:success] = "Author has been updated."
            redirect_to @author
       else
            flash[:danger] = "Author has not been updated."
            render :edit
       end
    end
    
    def destroy
        
        
        @author.destroy
        flash[:success] = "Author has been deleted."
        redirect_to authors_path
    end

    
    private
        
        def author_params
            
            params.require(:author).permit(:first_name, :last_name)
        end
        
        def set_author
            @author = Author.find(params[:id])
        end
end
