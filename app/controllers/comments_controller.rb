class CommentsController < ApplicationController
    def create
      @article = Article.find(params[:article_id])
      @comment = @article.comments.create(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        redirect_to article_path(@article)
      else
        flash.now[:danger] = "error"
      end
    end
     
    def destroy
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      redirect_to article_path(@article)
    end
    
    def comment_params
      params.require(:comment).permit(:commenter , :body)  
    end        
end
