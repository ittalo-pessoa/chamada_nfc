class Presenca < ApplicationRecord
  belongs_to :aluno
  belongs_to :atividade

  validates :registrada_em, presence: true

  validates :aluno_id,
            uniqueness: {
              scope: :atividade_id,
              message: "já possui presença nesta atividade"
            }

  # Avisa as telas abertas quando uma nova presença for registrada
  after_create_commit :atualizar_chamada

  private

  def atualizar_chamada
    broadcast_refresh_to atividade
  end
end
