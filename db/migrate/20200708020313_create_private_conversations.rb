class CreatePrivateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :private_conversations do |t|

      t.timestamps
    end
  end
end
