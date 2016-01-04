class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    before_action :set_category, only:[:show]
    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end
    def new
        @category = Category.new
    end
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "Category was created successfully"
            redirect_to categories_path
        else
            render 'new'
        end
    end
    def edit
        @category = Category.find(params[:id])
    end
    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            flash[:success] = "Category name was successfully updated"
            redirect_to category_path(@category)
        else
            render 'edit'
        end
    end
    def show
        @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
    end
    def destroy
        @category = Category.find(params[:id])
       @category.destroy
       flash[:danger] = "Category was successfully deleted"
       redirect_to articles_path
    end
    private
    def set_category
         @category = Category.find(params[:id])
    end
    def category_params
        params.require(:category).permit(:name)
    end
    def require_admin
        if !logged_in? || (logged_in? and !current_user.admin?)
            flash[:danger] = "Only admins can perform that action"
            redirect_to categories_path
        end
    end
end