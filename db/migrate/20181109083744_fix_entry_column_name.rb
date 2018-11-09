class FixEntryColumnName < ActiveRecord::Migration[5.2]
  def change
    change_table :entries do |t|
      t.rename :context, :content
    end
  end
end
