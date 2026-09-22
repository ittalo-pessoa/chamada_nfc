class MigrarTurmasDasAtividades < ActiveRecord::Migration[7.2]
  def up
    execute <<~SQL
      INSERT INTO atividade_turmas
        (atividade_id, turma_id, created_at, updated_at)
      SELECT
        id,
        turma_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
      FROM atividades
      WHERE turma_id IS NOT NULL
      ON CONFLICT DO NOTHING
    SQL
  end

  def down
  end
end
