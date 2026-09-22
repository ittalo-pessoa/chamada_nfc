class CreateAtividades < ActiveRecord::Migration[7.2]
  def change
   create_table :atividades do |t|
  t.string :nome, null: false
  t.string :tipo_atividade, null: false

  t.references :turma,
               null: false,
               foreign_key: true

  t.datetime :inicio, null: false
  t.datetime :fim

  t.string :local

  t.string :status,
           default: "agendada",
           null: false

  t.text :observacao

  t.timestamps
end
  end
end
