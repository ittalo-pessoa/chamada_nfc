class DispositivosController < ApplicationController
before_action :set_dispositivo, only: %i[show edit update destroy]

  def index
    @dispositivos = Dispositivo.order(:nome)
  end

 def show
  @dispositivo = Dispositivo.find(params[:id])
end

  def new
    @dispositivo = Dispositivo.new(ativo: true)
  end

  def create
    @dispositivo = Dispositivo.new(dispositivo_params)

    if @dispositivo.save
      redirect_to @dispositivo,
                  notice: "Dispositivo cadastrado com sucesso."
    else
      render :new,
             status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @dispositivo.update(dispositivo_params)
      redirect_to @dispositivo,
                  notice: "Dispositivo atualizado com sucesso."
    else
      render :edit,
             status: :unprocessable_entity
    end
  end

  def destroy
    @dispositivo.destroy

    redirect_to dispositivos_path,
                notice: "Dispositivo removido com sucesso."
  end

  private

private

def set_dispositivo
  @dispositivo = Dispositivo.find(params[:id])
end

  def dispositivo_params
    params.require(:dispositivo).permit(
      :nome,
      :local,
      :ativo
    )
  end
end
