# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Deposites:

@coin = Coin.new(name:'quarter',value:25)
@coin.save
@coin = Coin.new(name:'penny',value:1)
@coin.save
@coin = Coin.new(name:'nickle',value:5)
@coin.save
@coin = Coin.new(name:'dime',value:10)
@coin.save
@coin = Coin.new(name:'quarter',value:25)
@coin.save
@coin = Coin.new(name:'quarter',value:25)
@coin.save
@coin = Coin.new(name:'dime',value:10)
@coin.save
@coin = Coin.new(name:'penny',value:1)
@coin.save
@coin = Coin.new(name:'dime',value:10)
@coin.save
@coin = Coin.new(name:'dime',value:10)
@coin.save
@coin = Coin.new(name:'nickle',value:5)
@coin.save




#Withdrawls:

@draw = Draw.new(name:'quarter',value:25)
@draw.save
@draw = Draw.new(name:'dime',value:10)
@draw.save
@draw = Draw.new(name:'nickle',value:5)
@draw.save
@draw = Draw.new(name:'quarter',value:25)
@draw.save
@draw = Draw.new(name:'dime',value:10)
@draw.save
@draw = Draw.new(name:'penny',value:1)
@draw.save
@draw = Draw.new(name:'penny',value:1)
@draw.save





#Users: 

@user = User.new(name:'Vishnu',email:'codervichu96@gmail.com', password:'password',password_confirmation:'password')
@user.save
@user = User.new(name:'Peter', email:'vichucoder96@gmail.com',password:'password',password_confirmation:'password')
@user.save
