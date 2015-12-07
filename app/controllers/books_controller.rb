class BooksController < ApplicationController
    
    before_action :set_book, except: [:index, :new, :create]
    
    def index
    end
    
    def show
        
    end
    
    def new
        @book = Book.new
    end
    
    def create
        #require 'pry'; binding.pry
        @book = Book.new(book_params)
        if @book.save
            flash[:success] = "Book has been created"
            redirect_to @book
        else
            flash[:danger] = "Book has not been created"
            render :new
        end
    end
    
    def edit
       
    end
    
    def update
       
        if @book.update(book_params)
            flash[:success] = "Book has been updated"
            redirect_to @book
        else
            flash[:danger] = "Book has not been updated"
            render :edit
        end
    end
    
    def destroy
       
        @book.destroy
        flash[:success] = "Book has been deleted"
        redirect_to books_path
    end
    
    private
    
        def book_params
            params.require(:book).permit(:title, :isbn, :description, :published_at, :publisher_id, :page_count, :price)
        end
        
        def set_book
             @book = Book.find(params[:id])
        end
    
end
