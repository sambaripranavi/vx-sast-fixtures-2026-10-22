Rails.application.routes.draw do
  get "fixtures/:action", controller: "fixtures"
  get "clean/index", to: "clean#index"
end
