# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_09_22_013517) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "alunos", force: :cascade do |t|
    t.string "nome", null: false
    t.string "nfc_uid"
    t.boolean "ativo", default: true, null: false
    t.bigint "turma_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nfc_uid"], name: "index_alunos_on_nfc_uid", unique: true
    t.index ["turma_id"], name: "index_alunos_on_turma_id"
  end

  create_table "atividade_participantes", force: :cascade do |t|
    t.bigint "atividade_id", null: false
    t.bigint "aluno_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aluno_id"], name: "index_atividade_participantes_on_aluno_id"
    t.index ["atividade_id", "aluno_id"], name: "index_atividade_participantes_on_atividade_id_and_aluno_id", unique: true
    t.index ["atividade_id"], name: "index_atividade_participantes_on_atividade_id"
  end

  create_table "atividade_turmas", force: :cascade do |t|
    t.bigint "atividade_id", null: false
    t.bigint "turma_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atividade_id", "turma_id"], name: "index_atividade_turmas_on_atividade_id_and_turma_id", unique: true
    t.index ["atividade_id"], name: "index_atividade_turmas_on_atividade_id"
    t.index ["turma_id"], name: "index_atividade_turmas_on_turma_id"
  end

  create_table "atividades", force: :cascade do |t|
    t.string "nome", null: false
    t.string "tipo_atividade", null: false
    t.datetime "inicio", null: false
    t.datetime "fim"
    t.string "local"
    t.string "status", default: "agendada", null: false
    t.text "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dispositivos", force: :cascade do |t|
    t.string "nome", null: false
    t.string "identificador", null: false
    t.string "api_token", null: false
    t.string "local"
    t.boolean "ativo", default: true, null: false
    t.datetime "ultimo_contato"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_token"], name: "index_dispositivos_on_api_token", unique: true
    t.index ["identificador"], name: "index_dispositivos_on_identificador", unique: true
  end

  create_table "presencas", force: :cascade do |t|
    t.bigint "aluno_id", null: false
    t.bigint "atividade_id", null: false
    t.datetime "registrada_em", null: false
    t.string "origem", default: "nfc", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aluno_id", "atividade_id"], name: "index_presencas_on_aluno_id_and_atividade_id", unique: true
    t.index ["aluno_id"], name: "index_presencas_on_aluno_id"
    t.index ["atividade_id"], name: "index_presencas_on_atividade_id"
  end

  create_table "turmas", force: :cascade do |t|
    t.string "nome"
    t.string "curso"
    t.string "serie"
    t.boolean "ativa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "alunos", "turmas"
  add_foreign_key "atividade_participantes", "alunos"
  add_foreign_key "atividade_participantes", "atividades"
  add_foreign_key "atividade_turmas", "atividades"
  add_foreign_key "atividade_turmas", "turmas"
  add_foreign_key "presencas", "alunos"
  add_foreign_key "presencas", "atividades"
end
