class CreatePrivateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :private_messages do |t|
      t.text :body
      t.integer :conversation_id
      t.integer :user_id

      t.timestamps
    end
  end
end
