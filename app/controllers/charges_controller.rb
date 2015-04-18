class ChargesController < ApplicationController
	def new
	end

	def create
		@event = Event.find[:id]
	  # Amount in cents
	  @amount = (@event.price * 100)

	  customer = Stripe::Customer.create(
	    :email => 'example@stripe.com',
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd'
	  )

	  @charge = Transaction.new(stripe_id: charge['id'], user_id: current_user, amount: charge['amount'], paid: charge['paid'], course_id: @event.id)
	  @charge.save
	  
	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end
end
