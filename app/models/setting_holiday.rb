class SettingHoliday < ActiveRecord::Base
  include Redmine::SafeAttributes
  unloadable

  validates :project_id, :presence => true
  validates :title, :presence => true

  safe_attributes 'title',
                  'description'
end
