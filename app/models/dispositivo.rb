class Dispositivo < ApplicationRecord
  before_validation :gerar_identificador, on: :create
  before_validation :gerar_api_token, on: :create

  validates :nome, presence: true
  validates :identificador, presence: true, uniqueness: true
  validates :api_token, presence: true, uniqueness: true

  private

  def gerar_identificador
    self.identificador ||= "ESP32-#{SecureRandom.hex(4).upcase}"
  end

  def gerar_api_token
    self.api_token ||= SecureRandom.hex(32)
  end
end
