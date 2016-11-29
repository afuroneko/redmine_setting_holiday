class ChangeColumnSettingHolidays < ActiveRecord::Migration
  def change
    change_column :setting_holidays, :project_id, :integer, null: false
    change_column :setting_holidays, :date, :date, null: false
  end
end
