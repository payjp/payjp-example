require 'sinatra'
require 'payjp'

set :secret_key, ENV['SECRET_KEY']
set :public_key, ENV['PUBLIC_KEY']

Payjp.api_key = settings.secret_key

configure do
  set :erb, escape_html: true
end

get '/' do
  erb :index
end

post '/pay' do
  amount = 1000
  customer = Payjp::Customer.create(
    :email => 'example@pay.jp',
    :card  => params['payjp-token']
  )
  Payjp::Charge.create(
      :amount => amount,
      :currency => 'jpy',
      :customer => customer.id,
      :description => 'Sinatra example charge'
  )
  erb :pay, :locals => {:amount => amount}
end
