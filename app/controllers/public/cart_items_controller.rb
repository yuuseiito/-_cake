class Public::CartItemsController < ApplicationController
    
    def index
        @cart_items = current_customer.cart_items
        @subtotal = 0
        
        
    end
    
    def update
        cart_item = CartItem.find(params[:id])
        cart_item.update(amount: params[:cart_item][:amount].to_i)
        redirect_to cart_items_path
    end
        
    def destroy
        cart_item = CartItem.find(params[:id])
        cart_item.destroy
        redirect_to cart_items_path
    end
    
    def destroy_all
        cart_item = current_customer.cart_items
        cart_item.destroy_all
        redirect_to cart_items_path
    end
    
    def create
        if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
            item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
            item.update(amount: params[:cart_item][:amount].to_i + item.amount)
        else
            @cart_item = CartItem.new(cart_item_params)
            @cart_item.customer_id = current_customer.id
            @cart_item.save
        end
         redirect_to cart_items_path
    end
    
    private
    
    def cart_item_params
        params.require(:cart_item).permit(:item_id, :amount)
    end
    
    
end
