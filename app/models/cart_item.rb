class CartItem < ApplicationRecord
    def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
    end
    
    belongs_to :customer
    
    belongs_to :item
end
