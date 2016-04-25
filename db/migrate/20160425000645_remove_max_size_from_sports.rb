class RemoveMaxSizeFromSports < ActiveRecord::Migration
  def change
    remove_column :sports, :max_size, :integer
  end
end
