class TasksController < ApplicationController
  #include Exportable

  before_action :set_task, only: [ :edit, :update, :destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.order(due_date: :asc)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit # rubocop:disable Layout/TrailingWhitespace
  end
  def show
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tasks_path, alert: "Tarefa não encontrada."
  end
  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: "Tarefa foi criada com sucesso."
    else
      flash.now[:alert] = @task.errors.full_messages.to_sentence
      render :new
    end
  end
  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Tarefa foi atualizada com sucesso."
    else
      flash.now[:alert] = @task.errors.full_messages.to_sentence
      render :edit
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
