class CreateDispositivos < ActiveRecord::Migration[7.2]
  def change
    create_table :dispositivos do |t|
      t.string :nome, null: false
      t.string :identificador, null: false
      t.string :api_token, null: false
      t.string :local
      t.boolean :ativo, default: true, null: false
      t.datetime :ultimo_contato

      t.timestamps
    end

    add_index :dispositivos, :identificador, unique: true
    add_index :dispositivos, :api_token, unique: true
  end
end
