class RemoveTurmaFromAtividades < ActiveRecord::Migration[7.2]
  def change
    remove_reference :atividades, :turma, null: false, foreign_key: true
  end
end
