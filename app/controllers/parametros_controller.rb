class ParametrosController < ApplicationController
  def index
    @dispositivos_ativos = Dispositivo.where(ativo: true).count
  end
end
