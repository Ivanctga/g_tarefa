class TasksController < ApplicationController
  before_action :set_task, only: [ :edit, :update, :destroy ]
  
  def index
    @tasks = Task.only_parents.order(due_date: :asc)
  end
  
  def new
    @task = Task.new
  end
    
  def edit # rubocop:disable Layout/TrailingWhitespace
  end

  def show
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tasks_path, alert: "Tarefa não encontrada."
  end
  
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Tarefa foi criada com sucesso."
    else
      flash.now[:alert] = @task.errors.full_messages.to_sentence
      render :new
    end
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Tarefa foi atualizada com sucesso."
    else
      flash.now[:alert] = @task.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @task = Task.find(params[:id])
    @task.destroy  
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "Tarefa apagada com sucesso." }
      format.turbo_stream # Se estiver usando Turbo Streams
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :due_date, :done, :parent_id)
  end
end
