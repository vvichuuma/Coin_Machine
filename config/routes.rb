Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
 namespace :api do 

 #-------------------------------#
   
  #coins_controller_begin:

   #getting all the deposites:
   get '/coins' => 'coins#index'

   #creating a deposite:
   post '/coins' => 'coins#create'


  #getting a specific coin:
  patch "/coined/:id" => "coins#show"

  #updating a specific coin:
  patch '/coinses/:id' => 'coins#update'
  

  #deleting a specific coin:
  delete '/coinz/:id' => 'coins#destroy'


   #getting the total value of all deposites made in the coin_machine:
  get '/coinz' => 'coins#total_value'



   #getting the current_user money:
   get '/usermoney' => 'coins#current_user_money'


  #coins_controller_end

  #---------------------------------#

  #users_controller_begin:

    #creating a new user:
   post "/users" => "users#create"

   #user_controller_end

   #----------------------------------#

   #sessions_controller_begin:

  #for login purpose:
   post "/sessions" => "sessions#create"

   #sessions_controller_end

 #--------------------------------------#
    #draws_controller_begin:

  
    #get the nickles,pennies and coins of the current-logged-in-user 
    get '/transa' => 'draws#money_in_pocket'
    
    #withdrawing a coin from the user's account who is logged in:
    post '/withdraw' => 'draws#create'


     #get the deposites of the current-logged-in-user:
     get '/curr' => 'draws#curr_coins'



     #get all the withdrawls made by the users in the coin machine, not the deposites but just the withdrawls:
     get '/alldraws' => 'draws#index'



     #getting the total amount of coins in the coin_machine:
     get '/coinmachine' => 'draws#coins_in_coinmachine'

     #draws_controller_end


  #------------------------------------#


 end 


end
