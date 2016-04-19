class AddMapUrlToInstallation < ActiveRecord::Migration
  def change
    add_column :installations, :map_url, :string
  end
end
