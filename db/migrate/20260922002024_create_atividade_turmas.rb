class CreateAtividadeTurmas < ActiveRecord::Migration[7.2]
  def change
    create_table :atividade_turmas do |t|
      t.references :atividade, null: false, foreign_key: true
      t.references :turma, null: false, foreign_key: true

      t.timestamps
    end

    add_index :atividade_turmas,
              [:atividade_id, :turma_id],
              unique: true
  end
end
