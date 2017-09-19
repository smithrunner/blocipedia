class ChargesController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 15_00,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )
 
    flash[:notice] = "Upgrade successful! #{current_user.email} is now a premium member!"
    @user = current_user
    @user.role ||= :premium
    redirect_to user_path(current_user)
 
    rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
  end
  
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: 15_00
    }
  end
end
