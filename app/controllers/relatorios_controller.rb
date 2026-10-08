class RelatoriosController < ApplicationController
  def index
    @atividades = Atividade.left_joins(:presencas)
      .select("atividades.*, COUNT(presencas.id) AS total_presencas")
      .group("atividades.id")
      .order(inicio: :desc)
      .page(params[:page]).per(10)
  end
end
