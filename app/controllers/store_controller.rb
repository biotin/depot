class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    @products = Product.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
    @cart= current_cart
  end
  
  def about
  end

  def contacts
  end
end
