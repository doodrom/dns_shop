class ProductsController < ApplicationController

  def index
    @products = Shoppe::Product.root.ordered.includes(:product_category, :variants)
    @products = @products.group_by(&:product_category)
  end
  
  def show
      @products = Shoppe::Product.all
    @product = Shoppe::Product.find_by_permalink!(params[:permalink])
  end
  
  def buy
    @product = Shoppe::Product.find_by_permalink!(params[:permalink])
    current_order.order_items.add_item(@product, params[:stock].to_i)
    redirect_to product_path(@product.permalink), :notice => "Product has been added successfuly!"
  end
  
end