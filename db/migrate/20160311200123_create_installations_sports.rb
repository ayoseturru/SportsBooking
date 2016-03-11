class CreateInstallationsSports < ActiveRecord::Migration
  def change
    create_table :installations_sports, :id => false do |t|
      t.references :installation
      t.references :sport
    end
  end

  def self.down
    drop_table :installations_sports
  end
end