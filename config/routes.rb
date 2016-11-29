# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  get '/projects/:project_id/setting_holidays/index', :to => 'setting_holidays#index', :as => 'project_setting_holidays_index'
  get '/projects/:project_id/setting_holidays/list', :to => 'setting_holidays#list', :as => 'project_setting_holidays_list'
  get '/projects/:project_id/setting_holidays/new', :to => 'setting_holidays#new', :as => 'project_setting_holidays_new'
  get '/projects/:project_id/setting_holidays/show', :to => 'setting_holidays#show', :as => 'project_setting_holidays_show'
  get '/projects/:project_id/setting_holidays/edit', :to => 'setting_holidays#edit', :as => 'project_setting_holidays_edit'

  post '/projects/:project_id/setting_holidays/destroy', :to => 'setting_holidays#destroy'
  post '/projects/:project_id/setting_holidays/create', :to => 'setting_holidays#create'
  put '/projects/:project_id/setting_holidays/update', :to => 'setting_holidays#update'
end
