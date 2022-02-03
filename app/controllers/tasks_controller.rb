class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :get_category, except: [:edit, :update, :today, :all, :destroy]

  def today
    @tasks = Task.where(task_date: Date.today.all_day, user_id: current_user.id).order("updated_at DESC")
  end

  def all
    @tasks = Task.where(user_id: current_user.id).order("updated_at DESC")
  end

  # GET /tasks or /tasks.json
  def index
    @tasks = @category.tasks
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    @task = Task.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  # GET /tasks/new
  def new
    @task = @category.tasks.build
    respond_to do |format|
      format.js
    end
  end

  # GET /tasks/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /tasks or /tasks.json
  def create
    @task = @category.tasks.build(task_params)
    @task.update(user_id: current_user.id)

    # if @task.save
    #   redirect_to category_task_path(@category.id, @task.id)
    # else
    #     render :new
    # end

    respond_to do |format|
      if @task.save
        format.html { redirect_to params[:previous_request], notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { redirect_to params[:previous_request], status: :unprocessable_entity, alert: "Task was not created." }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to params[:previous_request], notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { redirect_to params[:previous_request], status: :unprocessable_entity, alert: "Task was not updated." }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @category = @task.category_id
    @task.destroy
    respond_to do |format|
      # ayaw magredirect sa category
      format.html { flash[:notice] = "Task was successfully deleted." }
      format.js 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def get_category
      @category = Category.find(params[:category_id])
  end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :previous_request, :body, :task_date, :user_id)
    end
end
