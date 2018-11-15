Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
 namespace :api do 
   
  #coins_controller_begin:

   get '/coins' => 'coins#index'

   post '/coins' => 'coins#create'

  patch "/coined/:id" => "coins#show"

  patch '/coinses/:id' => 'coins#update'
  
  delete '/coinz/:id' => 'coins#destroy'

  get '/coinz' => 'coins#total_value'

   get '/usermoney' => 'coins#current_user_money'


  #coins_controller_end

  #users_controller_begin:

   post "/users" => "users#create"

   #user_controller_end

   #sessions_controller_begin:

   post "/sessions" => "sessions#create"

   #sessions_controller_end


    #draws_controller_begin:

    get '/transa' => 'draws#money_in_pocket'

    post '/withdraw' => 'draws#create'

     get '/curr' => 'draws#curr_coins'

     get '/alldraws' => 'draws#index'

     get '/coinmachine' => 'draws#coins_in_coinmachine'

     #draws_controller_end


 end 


end
