class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category, only: %i[ show edit update destroy ]

    def home
        @categories = Category.where(user_id: current_user.id).order("name DESC")  if user_signed_in?
        @today_tasks = Task.where(task_date: Date.today.all_day, user_id: current_user.id).order("updated_at DESC") if user_signed_in?
        @all_tasks = Task.where(user_id: current_user.id).order("updated_at DESC")
    end

    def index
        @categories = Category.where(user_id: current_user.id) if user_signed_in?
        # originally Category.all
    end

    def show
        @tasks = @category.tasks
    end

    def new
        @category = Category.new
        respond_to do |format|
            format.js
        end
    end

    def create
        # @category = Category.new
        # @category.name = params[:name]
        # @category.details = params[:details]
        @category = Category.new(category_params)
        @category.update(user_id: current_user.id)

        respond_to do |format|
            if @category.save
                format.html { redirect_to params[:previous_request], notice: "Category was successfully created." }
                format.json { render :show, status: :created, location: @category }
            else
                format.html { redirect_to params[:previous_request], status: :unprocessable_entity, alert: "Category was not created." }
                format.json { render json: @category.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
        respond_to do |format|
            format.js
        end
    end

    def update
        respond_to do |format|
            if @category.update(category_params)
                format.html { redirect_to params[:previous_request], notice: "Category was successfully updated." }
                format.json { render :show, status: :ok, location: @category }
            else
                format.html { redirect_to params[:previous_request], status: :unprocessable_entity, alert: "Category was not updated."  }
                format.json { render json: @category.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @category.destroy

        respond_to do |format|
            format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    private

    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name, :previous_request, :details, :user_id)
    end
end
