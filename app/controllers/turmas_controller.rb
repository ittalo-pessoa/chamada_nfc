class TurmasController < ApplicationController
  before_action :set_turma, only: %i[show edit update destroy]

  def index
    @turmas = Turma.order(:nome)
  end

  def show
    @alunos = @turma.alunos.order(:nome)
    @atividades = @turma.atividades.order(inicio: :desc)
  end

  def new
    @turma = Turma.new
  end

  def create
    @turma = Turma.new(turma_params)

    if @turma.save
      redirect_to @turma, notice: "Turma cadastrada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @turma.update(turma_params)
      redirect_to @turma, notice: "Turma atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @turma.destroy
    redirect_to turmas_path, notice: "Turma removida."
  end

  private

  def set_turma
    @turma = Turma.find(params[:id])
  end

  def turma_params
    params.require(:turma).permit(
      :nome,
      :serie,
      :curso,
      :ativa
    )
  end
end
