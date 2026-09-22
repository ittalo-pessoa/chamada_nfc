class Atividade < ApplicationRecord
  # Turmas vinculadas à atividade
  has_many :atividade_turmas,
           dependent: :destroy

  has_many :turmas,
           through: :atividade_turmas

  # Alunos específicos vinculados à atividade
  has_many :atividade_participantes,
           dependent: :destroy

  has_many :participantes,
           through: :atividade_participantes,
           source: :aluno

  # Presenças registradas
  has_many :presencas,
           dependent: :destroy

  has_many :alunos_presentes,
           through: :presencas,
           source: :aluno

  TIPOS = [
    "Aula",
    "Monitoria",
    "Laboratório",
    "Projeto",
    "Evento",
    "Outra"
  ].freeze

  STATUS = [
    "agendada",
    "ativa",
    "encerrada"
  ].freeze

  validates :nome,
            presence: true

  validates :tipo_atividade,
            presence: true,
            inclusion: { in: TIPOS }

  validates :status,
            presence: true,
            inclusion: { in: STATUS }

  validates :inicio,
            presence: true

  validate :fim_depois_do_inicio

  private

  def fim_depois_do_inicio
    return if inicio.blank? || fim.blank?

    if fim <= inicio
      errors.add(
        :fim,
        "deve ser posterior ao horário de início"
      )
    end
  end
end
