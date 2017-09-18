 # Store the environment variables on the Rails.configuration object
 Rails.configuration.stripe = {
   publishable_key: ENV['pk_test_DZSX5kUm0iyds79VBaqXEZDY'],
   secret_key: ENV['sk_test_ix84d0n4wmcrplZTpa0riBlF']
 }
 
 # Set our app-stored secret key with Stripe
 Stripe.api_key = Rails.configuration.stripe[:secret_key]