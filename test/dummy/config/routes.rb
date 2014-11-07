Rails.application.routes.draw do

  mount Analytics::Engine => "/analytics"
end
