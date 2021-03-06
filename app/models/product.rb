class Product < ActiveRecord::Base
 default_scope :order => 'products.id DESC'
 has_many :line_items
 has_many :orders, :through => :line_items
 before_destroy :ensure_not_referenced_by_any_line_item
 
 cattr_reader :per_page
 @@per_page = 10
 
 # ensure that there are no line items referencing this product
 def ensure_not_referenced_by_any_line_item
  if line_items.count.zero?
   return true
  else
   errors[:base] << "Line Items present"
   return false
  end
 end
   
 validates :title, :description, :image_url, :presence => true
 validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
 validates :title, :uniqueness => true
 validates :image_url, :format => {
	:with => %r{\.(gif|jpg|png)$}i,
	:message => 'must be a URL for GIF, JPG or PNG image.'
	}

 def self.search(search)
  if search
   where('description || title LIKE?', "%#{search}%")
  else
   scoped
  end
 end

end
