class AddShowSenderAndShowRecipientToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :show_sender, :boolean
    add_column :messages, :show_recipient, :boolean
  end
end
