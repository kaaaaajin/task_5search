class BookCommentsController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    comment.save
    redirect_to request.referer
    
  end
  
  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to request.referer
    # bookcommentテーブルにはuser_id, book_id, commentがある
    # それらのうちuser_idとpost_idを指定して削除する必要があります。
    # なのでid: params[:id]というのはコメントのidで、params[:post_id]というのは投稿記事のidを記述しています。　
  end
  
  
  
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
    
  end
end
