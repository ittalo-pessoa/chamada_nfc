class Turma < ApplicationRecord
  has_many :alunos, dependent: :destroy

  has_many :atividade_turmas, dependent: :destroy
  has_many :atividades, through: :atividade_turmas

  validates :nome, presence: true
end
