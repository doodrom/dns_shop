class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:checkout, :payment, :confirmation, :status]
  def destroy
    current_order.destroy
    session[:order_id] = nil
    redirect_to root_path, :notice => "Basket emptied successfully."
  end
  
  def checkout
    @order = Shoppe::Order.find(current_order.id)
    if request.patch?
      if @order.proceed_to_confirm(params[:order].permit(:first_name, :last_name, :billing_address1, :billing_address2, :billing_address3, :billing_address4, :billing_country_id, :billing_postcode, :email_address, :phone_number))
        redirect_to checkout_payment_path
      end
    end
  end
  
  def payment
    if request.post?
      redirect_to checkout_confirmation_path
    end
  end
  
  def confirmation
    if request.post?
      current_order.confirm!
      current_user.user_orders.create(order_id: current_order.id)
      session[:order_id] = nil
      redirect_to root_path
      flash[:notice] = "Order has been placed successfully!"
    end
  end
  
  def status
       @orders = Shoppe::Order.where(id: current_user.user_orders.pluck(:order_id))
       #@order_items = Shoppe::OrderItem.where(id: current_user.user_order_items.pluck(:orderItem_id))
  end
  
  
end

