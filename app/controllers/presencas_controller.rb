class PresencasController < ApplicationController
  before_action :set_atividade, only: %i[
    create
    destroy
  ]

  def index
    @presencas = Presenca
      .includes(
        :atividade,
        aluno: :turma
      )
      .order(registrada_em: :desc)

    # BUSCA POR ALUNO
    if params[:busca].present?
      busca = "%#{params[:busca].strip.downcase}%"

      @presencas = @presencas
        .joins(:aluno)
        .where(
          "LOWER(alunos.nome) LIKE ?",
          busca
        )
    end

    # FILTRO POR ATIVIDADE
    if params[:atividade_id].present?
      @presencas = @presencas.where(
        atividade_id: params[:atividade_id]
      )
    end

    # FILTRO POR TURMA
    if params[:turma_id].present?
      @presencas = @presencas
        .joins(:aluno)
        .where(
          alunos: {
            turma_id: params[:turma_id]
          }
        )
    end

    # FILTRO POR ORIGEM
    if params[:origem].present?
      @presencas = @presencas.where(
        origem: params[:origem]
      )
    end

    # FILTRO POR DATA
    if params[:data].present?
      begin
        data = Date.parse(params[:data])

        @presencas = @presencas.where(
          registrada_em: data.beginning_of_day..data.end_of_day
        )
      rescue Date::Error
      end
    end

    @presencas = @presencas
      .page(params[:page])
      .per(15)

    @atividades = Atividade
      .order(inicio: :desc)

    @turmas = Turma
      .where(ativa: true)
      .order(:nome)
  end

  def create
    unless @atividade.status == "ativa"
      redirect_to @atividade,
                  alert: "A chamada não está aberta."
      return
    end

    aluno = Aluno.find(params[:aluno_id])

    unless aluno_permitido?(aluno)
      redirect_to @atividade,
                  alert: "Este aluno não pertence à turma da atividade."
      return
    end

    presenca = @atividade.presencas.find_or_initialize_by(
      aluno: aluno
    )

    if presenca.new_record?
      presenca.registrada_em = Time.current
      presenca.origem = "manual"
      presenca.save!
    end

    redirect_to @atividade,
                notice: "Presença de #{aluno.nome} registrada."
  end

  def destroy
    unless @atividade.status == "ativa"
      redirect_to @atividade,
                  alert: "A chamada não está aberta."
      return
    end

    presenca = @atividade.presencas.find(params[:id])

    presenca.destroy

    redirect_to @atividade,
                notice: "Presença removida."
  end

  private

  def set_atividade
    @atividade = Atividade.find(
      params[:atividade_id]
    )
  end

  def aluno_permitido?(aluno)
    @atividade.turmas.exists?(aluno.turma_id) &&
      aluno.ativo?
  end
end
