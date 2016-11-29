class CreateSettingHolidays < ActiveRecord::Migration
  def change
    create_table :setting_holidays do |t|
      t.integer :project_id
      t.string :title
      t.text :description
      t.date :date
    end
    add_index :setting_holidays, :project_id
    add_index :setting_holidays, :date
  end
end
