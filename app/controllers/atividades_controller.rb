class AtividadesController < ApplicationController
  before_action :set_atividade, only: %i[
    show
    edit
    update
    destroy
    iniciar
    encerrar
  ]

  before_action :carregar_opcoes, only: %i[
    new
    create
    edit
    update
  ]

  def index
    @atividades = Atividade
      .includes(:turmas)
      .order(inicio: :desc)

    if params[:busca].present?
      @atividades = @atividades.where(
        "LOWER(atividades.nome) LIKE ?",
        "%#{params[:busca].downcase}%"
      )
    end

    if params[:status].present?
      @atividades = @atividades.where(
        status: params[:status]
      )
    end

    @atividades = @atividades.page(params[:page]).per(10)
  end

  def show
    @turma = @atividade.turmas.first

    @alunos =
      if @turma.present?
        @turma.alunos
          .where(ativo: true)
          .order(:nome)
      else
        Aluno.none
      end

    @presencas = @atividade
      .presencas
      .includes(:aluno)
  end

  def new
    @atividade = Atividade.new(
      inicio: Date.current,
      status: "agendada"
    )
  end

  def create
    @atividade = Atividade.new(atividade_params)
    @atividade.status = "agendada"

    if @atividade.save
      redirect_to atividades_path,
                  notice: "Atividade criada com sucesso."
    else
      render :new,
             status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @atividade.update(atividade_params)
      redirect_to @atividade,
                  notice: "Atividade atualizada com sucesso."
    else
      render :edit,
             status: :unprocessable_entity
    end
  end

  def destroy
    @atividade.destroy

    redirect_to atividades_path,
                notice: "Atividade removida com sucesso."
  end

  # INICIAR ATIVIDADE
  def iniciar
    if @atividade.status == "agendada"

      @atividade.update!(
        status: "ativa"
      )

      redirect_to @atividade,
                  notice: "Atividade iniciada. A chamada está aberta."

    else

      redirect_to @atividade,
                  alert: "Esta atividade não pode ser iniciada."

    end
  end

  # ENCERRAR ATIVIDADE
  def encerrar
    if @atividade.status == "ativa"

      @atividade.update!(
        status: "encerrada"
      )

      redirect_to @atividade,
                  notice: "Atividade encerrada com sucesso."

    else

      redirect_to @atividade,
                  alert: "Esta atividade não está em andamento."

    end
  end

  private

  def set_atividade
    @atividade = Atividade.find(params[:id])
  end

  def carregar_opcoes
    @turmas = Turma
      .where(ativa: true)
      .order(:nome)
  end

  def atividade_params
    parametros = params.require(:atividade).permit(
      :nome,
      :tipo_atividade,
      :inicio,
      :local,
      :observacao,
      :turma_ids
    )

    if parametros[:turma_ids].present?
      parametros[:turma_ids] = [parametros[:turma_ids]]
    else
      parametros[:turma_ids] = []
    end

    parametros
  end
end
