class AlunosController < ApplicationController
  before_action :set_aluno, only: %i[show edit update destroy]
  before_action :set_turma, only: %i[new create]

  def index
    @alunos = Aluno.includes(:turma).order(:nome)
  end

  def show
  end

  def new
    @aluno = @turma.alunos.new
  end

  def create
    @aluno = @turma.alunos.new(aluno_params)

    if @aluno.save
      redirect_to @aluno, notice: "Aluno cadastrado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @aluno.update(aluno_params)
      redirect_to @aluno, notice: "Aluno atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    turma = @aluno.turma
    @aluno.destroy

    redirect_to turma_path(turma),
                notice: "Aluno removido com sucesso."
  end

  private

  def set_aluno
    @aluno = Aluno.find(params[:id])
  end

  def set_turma
    @turma = Turma.find(params[:turma_id])
  end

  def aluno_params
    params.require(:aluno).permit(
      :nome,
      :nfc_uid,
      :ativo,
      :foto,
      :turma_id
    )
  end
end
