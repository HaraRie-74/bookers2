class BooksController < ApplicationController

  before_action:is_matching_login_user,only:[:edit,:update]

  def new
  end

  def create
    @book_new=Book.new(book_params)
    @book_new.user_id=current_user.id
    if @book_new.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      @user=User.find(current_user.id)
      @books=Book.all
      render:index
    end
  end

  def index
    @books=Book.all
    @user=User.find(current_user.id)
    @book_new=Book.new
  end

  def show
    @book=Book.find(params[:id])
    @user=User.find(@book.user_id)
    @book_new=Book.new
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You have update book successfully."
      redirect_to book_path(@book.id)
    else
      render:edit
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

 def is_matching_login_user
   book=Book.find(params[:id])
   unless book.user==current_user
     redirect_to books_path
   end
 end

end
