class Admin::OrderController < ApplicationController
    
    def show
        @order = Order.find(params[:id])
        
        @order_details = @order.order_details
        
        @tortal = 0
    end
end
