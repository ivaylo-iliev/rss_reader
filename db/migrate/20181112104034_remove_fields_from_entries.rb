class RemoveFieldsFromEntries < ActiveRecord::Migration[5.2]
  def change
    remove_column :entries, :content, :text
  end
end
