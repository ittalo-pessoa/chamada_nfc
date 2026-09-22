class CreatePresencas < ActiveRecord::Migration[7.2]
  def change
   create_table :presencas do |t|
  t.references :aluno,
               null: false,
               foreign_key: true

  t.references :atividade,
               null: false,
               foreign_key: true

  t.datetime :registrada_em,
             null: false

  t.string :origem,
           default: "nfc",
           null: false

  t.timestamps
end

add_index :presencas,
          [:aluno_id, :atividade_id],
          unique: true
  end
end
