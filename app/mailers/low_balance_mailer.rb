class LowBalanceMailer < ApplicationMailer

 def notify_user(user,coin,number,quarters,dimes,nickles,pennies)

  @user = user 
  @coin = coin 
  @number = number
  @quarters = quarters
  @dimes = dimes 
  @nickles = nickles 
  @pennies = pennies

  mail(to: @user.email, subject:'Low-balance-alert')

 end 

end
