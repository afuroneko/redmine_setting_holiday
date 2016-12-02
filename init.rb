Redmine::Plugin.register :redmine_setting_holiday do
  name 'Redmine Setting holidays plugin'
  author 'afuroneko'
  description 'This is a plugin for Redmine Setting holidays'
  version '0.0.1'
  url 'https://github.com/afuroneko/redmine_setting_holiday'

  project_module :setting_holiday do
    permission :view_setting_holidays, :setting_holidays => [:index, :show]
    permission :manage_setting_holidays, :setting_holidays => [:new, :edit, :create, :update, :destroy, :preview], :require => :member
  end

  menu :project_menu, :setting_holiday, { :controller => 'setting_holidays', :action => 'index'}, :param => :project_id

end

Holidays.load_all
