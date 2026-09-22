class CreateAlunos < ActiveRecord::Migration[7.2]
  def change
    create_table :alunos do |t|
  t.string :nome, null: false
  t.string :nfc_uid
  t.boolean :ativo, default: true, null: false

  t.references :turma,
               null: false,
               foreign_key: true

  t.timestamps
end

add_index :alunos, :nfc_uid, unique: true
  end
end
