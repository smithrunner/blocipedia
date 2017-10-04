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
    
    current_user.stripe_id = customer.id
 
    flash[:notice] = "Upgrade successful! #{current_user.email} is now a premium member!"
    current_user.role = 'premium'
    current_user.save!
    
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
  
  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    if customer.delete
      flash[:notice] = "\"#{current_user.email}\" was downgraded to standard successfully."
      current_user.role = 'user'
      current_user.save!
      
      wikis = current_user.wikis
      wikis.each do |wiki|
        if wiki.private
          wiki.private = false
          wiki.save!
        end
      end

      redirect_to new_charge_path
    else
      flash.now[:alert] = "There was an error downgrading the user."
      redirect_to new_charge_path
    end
  end

end
