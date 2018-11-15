class Api::DrawsController < ApplicationController

  #I have commented out the authentications, but you can comment them out if you want to provide authentications. 



  #----------------------

   #Authentications:
  
  #before_action :authenticate_user , only:[:money_in_pocket, :create,:curr_in_coins]


   #before_action :authenticate_admin , only:[:index, :coins_in_coinmachine]


   #----------------------


  
  def index 
    #This action gives all the withdraws the users has performed in this machine. Only the admin has the right to perform this operation.

    @draws = Draw.all 
     render 'index.json.jbuilder'
  end 

  def money_in_pocket

    #only the user who is logged in can perform this operation. This action gives the total amount of coins(value in total) that the user who is logged in has. The number of nickles, quarters, pennies and dimes that the logged in - user has.
    


   @curr = User.find_by(id:current_user.id).coins
   #I am getting the deposites.
   @drew = User.find_by(id:current_user.id).draws
   #I am getting the withdraws.



      #I am comparing the deposites
    @count_1 = 0
    @quarter_1 = 0 
    @dime_1 = 0 
    @nickle_1 = 0 
    @penny_1 = 0 

   @curr.each do |a|
  
  #I am getting all the deposites values of the current_user
      am = a.value
      if am == 25
         @quarter_1 += 1
      elsif am == 10 
         @dime_1 += 1
      elsif am == 5 
         @nickle_1 += 1
      elsif am == 1 
         @penny_1 += 1
      end 
          
      @count_1 += am 

   end 


     # I am comparing the withdraws
    @count_2 = 0 
    @quarter_2 = 0 
    @dime_2 = 0 
    @nickle_2 = 0 
    @penny_2 = 0 


   @drew.each do |a|
    #I am getting all the withdraws values of the current_user
  
       am = a.value
      if am == 25
        @quarter_2 += 1
      elsif am == 10 
         @dime_2 += 1
      elsif am == 5 
         @nickle_2 += 1
      elsif am == 1 
         @penny_2 += 1
      end 
         
      @count_2 += am 

   end 


   #Comparing the total of the Deposites with the total of the withdraws:
   if @count_1 > @count_2
     @money_in_pocket = @count_1 - @count_2
   else 
     @money_in_pocket = "You don't have enough of it!"
   end   


   #Comparing the total of the quarters of deposites with the quarters of the withdraws:
   if @quarter_1 > @quarter_2
     @no_of_quarters = @quarter_1 - @quarter_2
   else 
     @no_of_quarters =  "You don't have enough of it!"
   end   

  

   #Comparing the total of the dimes of deposites with the dimes of the withdraws:
   if @dime_1 > @dime_2
     @no_of_dimes = @dime_1 - @dime_2
   else 
     @no_of_dimes =  "You don't have enough of it!"
   end   



   #Comparing the total of the nickles of deposites with the nickles of the withdraws:
   if @nickle_1 > @nickle_2
    @no_of_nickles = @nickle_1 - @nickle_2
   else 
     @no_of_nickles =  "You don't have enough of it!"
   end  

  

   #Comparing the total of the pennies of deposites with the pennies of the withdraws:
    if @penny_1 > @penny_2
     @no_of_pennies = @penny_1 - @penny_2
    else 
      @no_of_pennies =  "You don't have enough of it!"
    end  



  render 'user_transaction.json.jbuilder'

  end 


  def create

   #The user who is logged in won't be able to withdraw coin if he has only 1 coin in his balance. 


   #Setting up the date and time with ruby date_time_funcitons:
    @time = Time.new

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




   #Getting the current user's Deposites and withdraws:
   @curr = User.find_by(id:current_user.id).coins
   @drew = User.find_by(id:current_user.id).draws

    @count_dep = 0

   @curr.each do |a|
  
      am = a.value
      @count_dep += am 

   end 


    @count_dra = 0 


   @drew.each do |a|
  
      am = a.value
      @count_dra += am 

   end 

   #Comparing the Deposites and withdraws and if the deposites are higher than the withdraws then the user has some coins left in his account to be able to be withdrawn.
   @money_in_pocket = @count_dep - @count_dra
  

   if @money_in_pocket <= 0 
     render json:{alert:"You don't have that much coins in your account"}
   else 

    @draw = Draw.new(
       name: params[:name],
       value: params[:value],
       user_id: current_user.id,
       time: @final_t,
       date:@date
      )

 
       if @draw.value == 25 || @draw.value == 10 || @draw.value == 5 || @draw.value == 1 
          #Providing some validations so that the user withdraws a valid coin.
    

                 @curr = User.find_by(id:current_user.id).coins
                 #I am getting the deposites.
                 @drew = User.find_by(id:current_user.id).draws
                 #I am getting the withdraws.


                  @count_1 = 0
                  @quarter_1 = 0 
                  @dime_1 = 0 
                  @nickle_1 = 0 
                  @penny_1 = 0 

                 @curr.each do |a|
                
                #I am getting all the deposites values of current user and getting the dimes,nickels,pennies and quarters.
                    am = a.value
                    if am == 25
                       @quarter_1 += 1
                    elsif am == 10 
                       @dime_1 += 1
                    elsif am == 5 
                       @nickle_1 += 1
                    elsif am == 1 
                       @penny_1 += 1
                    end 
                        
                    @count_1 += am 

                 end 


                  @count_2 = 0 
                  @quarter_2 = 0 
                  @dime_2 = 0 
                  @nickle_2 = 0 
                  @penny_2 = 0 


                 @drew.each do |a|
                  #I am getting all the withdraws values of the current user and calculating the coins he withdrew - nickles , pennies , quarters , dimes.
                
                     am = a.value
                    if am == 25
                      @quarter_2 += 1
                    elsif am == 10 
                       @dime_2 += 1
                    elsif am == 5 
                       @nickle_2 += 1
                    elsif am == 1 
                       @penny_2 += 1
                    end 
                       
                    @count_2 += am 

                 end 


                 if @count_1 > @count_2
                   @money_in_pocket = @count_1 - @count_2
                 else 
                   @money_in_pocket = 0
                 end   

                 if @quarter_1 > @quarter_2
                   @no_of_quarters = @quarter_1 - @quarter_2
                 else 
                   @no_of_quarters =  0
                 end   

                 if @dime_1 > @dime_2
                   @no_of_dimes = @dime_1 - @dime_2
                 else 
                   @no_of_dimes =  0
                 end   

                 if @nickle_1 > @nickle_2
                  @no_of_nickles = @nickle_1 - @nickle_2
                 else 
                   @no_of_nickles =  0
                 end  

                  if @penny_1 > @penny_2
                   @no_of_pennies = @penny_1 - @penny_2
                  else 
                    @no_of_pennies =  0
                  end  
                    
                    @drawing = 1 

             
             #After all these comparisons and the user has some coins left to be withdrawn then the following operations are performed.



                #MY IDEA IS IF THE USER HAS MORE THAN ONE QUARTER THEN HE CAN WITHDRAW ONE AND THE SAME GOES ON FOR THE REST OF THE COINS.THE USER CAN"T WITHDRAW IF HE HAS ONLY ONE COIN> HE MUST HAVE TWO COINS ATLEAST TO WITHDRAW ONE.HE CAN'T WITHDRAW IF HE HAD ONLY ONE COIN
             if @draw.value == 25 
                 if @no_of_quarters > @drawing
                       if @draw.save 
                         render 'show.json.jbuilder'
                       end   
                 else 
                      render json:{message:"you don't have enough coins to withdraw"}   
                 end
                
             elsif @draw.value == 10 
                 if @no_of_dimes > @drawing
                         if @draw.save 
                          render 'show.json.jbuilder'
                         end 
                 else 
                    render json:{message:"you don't have enough coins to withdraw"}   
                 end
        
             elsif @draw.value == 5 
                 if @no_of_nickles > @drawing
                         if @draw.save 
                           render 'show.json.jbuilder'
                         end   
                 else 
                     render json:{message:"you don't have enough coins to withdraw"}   
                 end
 
             elsif @draw.value == 1 
                  if @no_of_pennies > @drawing
                         if @draw.save 
                          render 'show.json.jbuilder'
                         end  
                  else 
                      render json:{message:"you don't have enough coins to withdraw"}   
                  end
             end 
          
       else 
       
         render json:{message: 'Please specify a valid coin to withdraw'}    

      end 


   end 

  end 



  def curr_coins
    #just testing out if I am able to get the current_user(user who is logged in) deposites.
    @curr = User.find_by(id: current_user.id).coins

    render 'current_user.json.jbuilder'
  end 


  def coins_in_coinmachine 

     #This action gives out the total amount of Coins in the Coin machine irrespective of the user who is logged in. Only the admin has the right to perform this action.  

    @user = User.all 

    @quarter_1 = 0 
    @dime_1 = 0 
    @nickle_1 = 0 
    @penny_1  = 0

    @quarter_2 = 0 
    @dime_2 = 0 
    @nickle_2 = 0 
    @penny_2  = 0 
 
    
    @user.each do |use|
     #I am getting all the users who has registered themselves in the coin machine.
      @coin = use.coins 
      @draw = use.draws 

       @coin.each do |con|
         # I am getting the deposites of the user

          if con.value == 25 || con.value == 10 || con.value == 5 || con.value == 1 
               
               if con.value == 25 
                  @quarter_1 += 1
               elsif con.value == 10 
                  @dime_1 += 1 
               elsif con.value == 5 
                  @nickle_1 += 1 
               elsif con.value == 1 
                  @penny_1 += 1 
               end 
                  
          end 


       end 


       
       @draw.each do |dra|

          # I am getting the withdrawls of the user

          if dra.value == 25 || dra.value == 10 || dra.value == 5 || dra.value == 1 
           
               if dra.value == 25 
                  @quarter_2 += 1
               elsif dra.value == 10 
                  @dime_2 += 1 
               elsif dra.value == 5 
                  @nickle_2 += 1 
               elsif dra.value == 1 
                  @penny_2 += 1 
               end 
                  
          end 


       end 



    end 


       #Comparing the deposites and the withdrawls of all the users who had registered themseleves in the coin machine.



      @no_of_quarters = @quarter_1 - @quarter_2 

      @no_of_dimes = @dime_1 - @dime_2  

      @no_of_nickles = @nickle_1 - @nickle_2

      @no_of_pennies = @penny_1 - @penny_2


      #Getting all the users and see if they are admins of the coin machine, not just users but also admins and alerting them if the coin machine is running out of coins.

      @users = User.all 

      @admins = []

      @users.each do |user|
        if user.admin == true 
           @admins << user
        end  

      end 

      #alerting the admins if the coin machine is running low on quarters.

      #Go to Views -> Low_balance_mailer -> notify_user.html.erb = to see the email
      if @no_of_quarters <= 3 
          @quat = 'quarters'

         @admins.each do |admin|
           LowBalanceMailer.notify_user(admin,@quat, @no_of_quarters, @no_of_quarters,@no_of_dimes,@no_of_nickles,@no_of_pennies).deliver
           
         end 

      end 
      
      #alerting the admins if the coin machine is running low on dimes.
      if @no_of_dimes <= 3 
         @dime = 'dimes'

           @admins.each do |admin|
            LowBalanceMailer.notify_user(admin,@dime, @no_of_dimes, @no_of_quarters,@no_of_dimes,@no_of_nickles,@no_of_pennies).deliver
           
           end 

      end
      
      #alerting the admins if the coin machine is running low on nickles.
      if @no_of_nickles <= 3 
          @nick = 'nickles'

             @admins.each do |admin|
               LowBalanceMailer.notify_user(admin,@nick, @no_of_nickles, @no_of_quarters,@no_of_dimes,@no_of_nickles,@no_of_pennies).deliver
           
             end 

      end 

      
      #alerting the admins if the coin machine is running low on pennies.
      if @no_of_pennies <= 3
           @penn = 'pennies'

             @admins.each do |admin|
               LowBalanceMailer.notify_user(admin,@penn, @no_of_pennies, @no_of_quarters,@no_of_dimes,@no_of_nickles,@no_of_pennies).deliver
           
             end  

      end   


    render 'allcoins.json.jbuilder'

  end 


end
