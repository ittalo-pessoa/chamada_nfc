require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ChamadaNfc
  class Application < Rails::Application

    config.load_defaults 7.2

    config.autoload_lib(ignore: %w[assets tasks])

    # Fuso horário da aplicação
    config.time_zone = "Brasilia"

    # Banco continua armazenando datas em UTC
    config.active_record.default_timezone = :utc

  end
end
