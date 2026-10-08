class DashboardController < ApplicationController
  def index
    @total_turmas = Turma.count
    @total_alunos = Aluno.count
    @total_atividades = Atividade.count
    @presencas_hoje = Presenca.where(registrada_em: Time.current.all_day).count
    @atividades_recentes = Atividade.order(inicio: :desc).limit(5)
  end
end
