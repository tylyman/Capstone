class ChargesController < ApplicationController
	before_action :authenticate_user!
	
	def new
		@event = Event.find(params[:event_id])
	end

	def create
		@event = Event.find(params[:event_id])
	  # Amount in cents

	  @amount = @event.cost * 100

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

	  @charge = Transaction.new(stripe_id: charge['id'], user_id: current_user.id, amount: charge['amount'], paid: charge['paid'], event_id: @event.id)
	  @charge.save

	  redirect_to enroll_path(@event)
	  # <!-- enroll_path(event), method: :put  -->

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end
end
