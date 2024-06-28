class Public::OrdersController < ApplicationController
    def new
        @order = Order.new
    end
    
    def confirmation
        @cart_items = current_customer.cart_items
        
        @flag = params[:order][:address_flag]
        
        @order = Order.new(order_params)
         
        if params[:order][:address_flag] == "0"
            @order.shipping_address = current_customer.address
            @order.shipping_postal_code = current_customer.postal_code
            @order.shipping_name = current_customer.first_name + current_customer.last_name
        elsif params[:order][:address_flag] == "1"
            @order.shipping_address = order_params[:shipping_address]
            @order.shipping_postal_code = order_params[:shipping_postal_code]
            @order.shipping_name = order_params[:shipping_name]
        end

        @postage = 800
    end
    
    def conplation
        
    end
    
    def create
        @cart_items = current_customer.cart_items
        @order = Order.new(order_params)
        
        if @order.save
            
        current_customer.cart_items.each do |cart|
        OrderDetail.create!(
            item_id: cart.item.id,
            order_id: @order.id,
            tax_included_price: cart.item.add_tax_price,
            quantity: cart.amount
            )
        
        end
        current_customer.cart_items.destroy_all
        redirect_to orders_conplation_path
        
        else
        render :new
        end
    end
    
    def index
        @orders = current_customer.orders
    end
    
    def show
        @order = Order.find(params[:id])
        
        @order_details = @order.order_details
    end
    
    private
    
    def order_params
        params.require(:order).permit(:method_payment, :shipping_postal_code, :shipping_address, :shipping_name, :payment_amount, :postage, :customer_id)
    end
end
