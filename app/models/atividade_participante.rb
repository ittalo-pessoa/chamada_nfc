class AtividadeParticipante < ApplicationRecord
  belongs_to :atividade
  belongs_to :aluno

  validates :aluno_id,
            uniqueness: { scope: :atividade_id }
end
