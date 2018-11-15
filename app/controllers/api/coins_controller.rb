class Api::CoinsController < ApplicationController
   
   #I have commented out the authentications, but you can comment them out inorder to provide the autentications

  
   #-----------------------
      
      #Authentications:

  #before_action :authenticate_user , except:[:total_value, :controls, :index, :destroy]


   #before_action :authenticate_admin , only:[:index, :total_value, :destroy]

   #------------------------

  require 'time'
  
  def index 

    #The amount of coins deposited in the coin machine irrespective of the user being logged in - only the admin has the access to this. The admin has to be a user as well.
 
    @coins = Coin.all
      
      render 'index.json.jbuilder'

  end 

  def create


   #create - here is depositing a coin into the machine. The user has to be logged in inorder to do this.

   #I have converted the date and the time into strings so that they can be viewed at the exact time the transaction has taken place.


   @time = Time.new

   #Getting the value of the current date and time using the datetime functions in ruby.

      @tt = @time.inspect

      @time = @tt.split(' ')

      @date = @time[0]

      @timz = @time[1]

      @t = @timz.split(':')

      @t1 = @t[0]

      dn = 'am'

      if @t1.to_i > 12
        @tz = @t1.to_i - 12 
        dn = 'pm'
        @t[0] = @tz

      elsif @t1.to_i == 12
         dn = 'pm'
      elsif @t1.to_i == 0 
         dn = 'am'
         @tz = 12
         @t[0] = @tz         
            
      end 
        
        @t = @t.join(':') + ' ' + dn 

      @final_t = @t

    if current_user   
      @coin = Coin.new(
       name: params[:name],
       value:params[:value],
       user_id: current_user.id,
       date: @date,
       time: @final_t
      )

        #making sure that the coins that are being inserted are valid ones.

        if @coin.value == 25 || @coin.value == 10 || @coin .value == 5 || @coin.value == 1 

           if @coin.save 
             render 'show.json.jbuilder'
           end 

        else 

           render json:{message: 'please insert a valid coin'}

        end 

    else 

        render json:{message:'please Login'}

    end    

  end 


   def show 

    #the user has to be logged in to perform this action. This action shows only one coin according to the coin's id which the user has to send through params. 

    if current_user
        @coin = Coin.find_by(id: params[:id])

        render 'show.json.jbuilder'
    else
      render json:{message:'please login'}    
    end

   end 

   def update

     #the user has to be logged in to perform this action. This action shows only one coin according to the coin's id which the user has to send through params after which the user has the ability to edit it.  
     
     if current_user
         @coin = Coin.find_by(id:params[:id])

         @coin.name = params[:name] || @coin.name

         @coin.value = params[:value] || @coin.value 

         if @coin.save

            render 'show.json.jbuilder'
     
         end 
     else  

        render json:{message:'please Login'}
     
     end     

   end 


  def destroy 

      #Only the admin has the right to perfom this action. A user who is logged in can't perform this action, he just can't go and toss money out of the machine. All the logged-in-user can do is he can withdraw or deposit coins but he can't toss / delete coins from the machine. Only the admin has the right to perform this aciton.
    if current_user
         @coin = Coin.find_by(id: params[:id])

         if @coin.delete 
           render json:{message:'the coin has been removed'}
         end 
    else 
      render json:{message:'Please Login'}

    end   

  end 

  def total_value 

    #This gives out the total amount of the coins being deposited into the coin machine irrespective of the current user who is logged in. An indiviual user who is logged in won't be able to do this, only the admin has the right to perform this action. This doesn't include the withdraw action. Only the deposites are being calculated and tracked.

    @coins = Coin.all

    @count = 0

    @quarter = 0

    @dime = 0

    @nickle = 0 

    @penny = 0

    @coins.each do |con|
     val = con[:value]

       if val == 10 
         @dime += 1
       elsif val == 5 
         @nickle += 1
       elsif val == 1 
         @penny += 1 
       elsif val == 25
         @quarter += 1 
       end

       @count += val 

    end  

     render 'total.json.jbuilder'

  end 



  def current_user_money
    #only the user who is currently logged in can perform this action. This shows how much money that the user has deposited into his account.

    @coins = Coin.where(user_id: current_user.id)

    @count = 0

    @quarter = 0

    @dime = 0

    @nickle = 0 

    @penny = 0

    @coins.each do |con|
      val = con[:value]

       if val == 10 
         @dime += 1
       elsif val == 5 
         @nickle += 1
       elsif val == 1 
         @penny += 1 
       elsif val == 25
         @quarter += 1 
       end

       @count += val 

    end  

    render 'current_user_money.json.jbuilder'

  end 

   #The Last portion in part-1 included me to calculate the amount of coin in the machine at a given time. Since the user has the ability to withdraw too. I have did this part in the draws controller.
 



end
