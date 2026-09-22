class Api::V1::PresencasController < ApplicationController
  skip_forgery_protection

  def create
    dispositivo = autenticar_dispositivo

    unless dispositivo
      return render json: {
        sucesso: false,
        mensagem: "Dispositivo não autorizado."
      }, status: :unauthorized
    end

    atividade = Atividade
      .joins(:turmas)
      .where(status: "ativa")
      .order(updated_at: :desc)
      .first

    unless atividade
      return render json: {
        sucesso: false,
        mensagem: "Nenhuma atividade está em andamento."
      }, status: :unprocessable_entity
    end

    uid = normalizar_uid(params[:nfc_uid])

    aluno = Aluno.find_by(nfc_uid: uid)

    unless aluno
      return render json: {
        sucesso: false,
        mensagem: "Pulseira não cadastrada."
      }, status: :not_found
    end

    unless atividade.turmas.exists?(aluno.turma_id)
      return render json: {
        sucesso: false,
        mensagem: "Aluno não pertence à turma desta atividade."
      }, status: :unprocessable_entity
    end

    presenca = atividade.presencas.find_or_initialize_by(
      aluno: aluno
    )

    nova_presenca = presenca.new_record?

    if nova_presenca
      presenca.registrada_em = Time.current
      presenca.origem = "nfc"
      presenca.save!
    end

    dispositivo.update_column(
      :ultimo_contato,
      Time.current
    )

    render json: {
      sucesso: true,
      nova_presenca: nova_presenca,
      aluno: aluno.nome,
      atividade: atividade.nome,
      mensagem: nova_presenca ?
        "Presença registrada." :
        "Presença já registrada."
    }
  end

  private

  def autenticar_dispositivo
    token = request.headers["X-API-Token"]

    return nil if token.blank?

    Dispositivo.find_by(
      api_token: token,
      ativo: true
    )
  end

  def normalizar_uid(uid)
    uid.to_s
       .gsub(/[\s:-]/, "")
       .upcase
  end
end
