class ChargesController < ApplicationController

  def new
   @stripe_btn_data = {
     key: Rails.application.secrets.stripe_publishable_key, # "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Membership - #{current_user.name}",
     amount: 1500
   }
  end

  def create
 
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
    charge = Stripe::Charge.create(
     customer: customer.id, 
     description: "Premium Membership - #{current_user.email}",
     amount: 1500,
     currency: 'usd'
   )
 
   current_user.update_attribute(:role, 'premium')

   flash[:success] = "You have upgraded to a Premium Account, #{current_user.email}! Enjoy your upgarded Blocipedia account."
   redirect_to wikis_path
 
 # Stripe will send back CardErrors, with friendly messages
 # when something goes wrong.
 # This `rescue block` catches and displays those errors.
 rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
 end

end
