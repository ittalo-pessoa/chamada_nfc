class CreateAtividadeParticipantes < ActiveRecord::Migration[7.2]
  def change
    create_table :atividade_participantes do |t|
      t.references :atividade, null: false, foreign_key: true
      t.references :aluno, null: false, foreign_key: true

      t.timestamps
    end

    add_index :atividade_participantes,
              [:atividade_id, :aluno_id],
              unique: true
  end
end
