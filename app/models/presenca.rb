class Presenca < ApplicationRecord
  belongs_to :aluno
  belongs_to :atividade

  validates :registrada_em, presence: true

  validates :aluno_id,
            uniqueness: {
              scope: :atividade_id,
              message: "já possui presença nesta atividade"
            }
end
