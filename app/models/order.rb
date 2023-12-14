class Order < ApplicationRecord
    
    enum method_payment:{ credit_card: 0, transfer:1 }
    
    has_many :order_detail
    
    belongs_to :customer
     
end
