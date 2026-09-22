class AtividadeTurma < ApplicationRecord
  belongs_to :atividade
  belongs_to :turma

  validates :turma_id, uniqueness: { scope: :atividade_id }
end
