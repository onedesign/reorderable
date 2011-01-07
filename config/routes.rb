Rails.application.routes.draw do
  scope '/reorderable' do
    match ":model/:column", :to => "reorderings#create"
  end
end
