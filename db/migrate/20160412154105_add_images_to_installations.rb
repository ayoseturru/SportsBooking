class AddImagesToInstallations < ActiveRecord::Migration
  def change
    add_column :installations, :images, :string
  end
end
