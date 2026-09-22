class Aluno < ApplicationRecord

  before_validation :normalizar_nfc_uid
  belongs_to :turma

  has_many :presencas, dependent: :destroy
  has_many :atividades, through: :presencas

  has_one_attached :foto

  validates :nome, presence: true
  validates :nfc_uid, uniqueness: true, allow_blank: true

  has_many :atividade_participantes,
         dependent: :destroy

has_many :atividades_participadas,
         through: :atividade_participantes,
         source: :atividade
private

def normalizar_nfc_uid
  return if nfc_uid.blank?

  self.nfc_uid = nfc_uid
    .gsub(/[\s:-]/, "")
    .upcase
end
end
