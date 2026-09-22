Rails.application.routes.draw do

  # ============================================================
  # DASHBOARD
  # ============================================================

  root "dashboard#index"


  # ============================================================
  # TURMAS
  # ============================================================

  resources :turmas do
    resources :alunos, only: [
      :new,
      :create
    ]
  end


  # ============================================================
  # ALUNOS
  # ============================================================

  resources :alunos, only: [
    :index,
    :show,
    :edit,
    :update,
    :destroy
  ]


  # ============================================================
  # ATIVIDADES
  # ============================================================

  resources :atividades do

    member do
      patch :iniciar
      patch :encerrar
    end

    # Presença dentro de uma atividade
    # POST   /atividades/:atividade_id/presencas
    # DELETE /atividades/:atividade_id/presencas/:id
    resources :presencas, only: [
      :create,
      :destroy
    ]

  end


  # ============================================================
  # PRESENÇAS
  # ============================================================

  # Tela geral de consulta das presenças
  # GET /presencas
  resources :presencas, only: [
    :index
  ]


  # ============================================================
  # DISPOSITIVOS NFC
  # ============================================================

  resources :dispositivos


  # ============================================================
  # API
  # ============================================================

  namespace :api do

    namespace :v1 do

      # ESP32 envia o UID da pulseira para esta rota
      # POST /api/v1/presencas
      post "presencas", to: "presencas#create"

    end

  end

end
