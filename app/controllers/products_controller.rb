class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search, :detail_search, :get_category_children, :get_category_grandchildren]
  before_action :set_product, only: [:update, :destroy, :show, :edit] 
  before_action :load_mydata, only: [:my_product_show, :destroy, :show, :edit]
  before_action :set_like, only: [:index, :show, :search]
  
  def index
    @products = Product.where(buyer_id:nil).includes(:images).order("id DESC")
  end

  def new
    @product = Product.new
    10.times {@product.images.build}
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else 
      render :new, notice: '保存できませんでした'
    end
  end

  def show
  end

  def edit
    10.times {@product.images.build}
    @images = Image.where(product_id: @product)
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def destroy
    @products = current_user.products
    if @product.saler_id == current_user.id
      @product.destroy
      redirect_to user_path(current_user)
    else
      render :show, notice: '削除できませんでした'
    end
  end
  
  def update
    if @product.update(product_params)
      redirect_to product_path
    else
      render 'show'
    end
  end

  def search
    @products = Product.where('title LIKE(?) OR text LIKE(?)', "%#{params[:keyword]}%","%#{params[:keyword]}%").order(created_at:"desc")
    
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def detail_search
    if params[:price_min].present? && params[:price_max].present?
      search_products = Product.where('title LIKE(?) OR text LIKE(?)', "%#{params[:keyword]}%","%#{params[:keyword]}%").where('price >= ? AND price < ?',"#{params[:price_min]}","#{params[:price_max]}").order(created_at:"desc")

      search_result = []
      if params[:product][:categories][0] == false || params[:product][:categories][0] == "---"
        @products = search_products
      else
        if params[:product][:categories][1] == false || params[:product][:categories][1] == "---"
          search_products.each do |p|
            if p.categories.include?(params[:product][:categories][0])
              search_result << p
              @products = search_result
            else
              @products = []
            end
          end
        else
          if params[:product][:categories][2] == false || params[:product][:categories][2] == "---"
            search_products.each do |p|
              if p.categories.include?(params[:product][:categories][1])
                search_result << p
                @products = search_result
              else
                @products = []
              end
            end
          else
            search_products.each do |p|
              if p.categories.include?(params[:product][:categories][2])
                search_result << p
                @products = search_result
              else
                @products = []
              end
            end
          end
        end
      end
    elsif params[:price_min].present?
      search_products = Product.where('title LIKE(?) OR text LIKE(?)', "%#{params[:keyword]}%","%#{params[:keyword]}%").where('price > ?',"#{params[:price_min]}").order(created_at:"desc")

      search_result = []
      if params[:product][:categories][0] == false || params[:product][:categories][0] == "---"
        @products = search_products
      else
        if params[:product][:categories][1] == false || params[:product][:categories][1] == "---"
          search_products.each do |p|
            if p.categories.include?(params[:product][:categories][0])
              search_result << p
              @products = search_result
            else
              @products = []
            end
          end
        else
          if params[:product][:categories][2] == false || params[:product][:categories][2] == "---"
            search_products.each do |p|
              if p.categories.include?(params[:product][:categories][1])
                search_result << p
                @products = search_result
              else
                @products = []
              end
            end
          else
            search_products.each do |p|
              if p.categories.include?(params[:product][:categories][2])
                search_result << p
                @products = search_result
              else
                @products = []
              end
            end
          end
        end
      end
    elsif params[:price_max].present?
      search_products = Product.where('title LIKE(?) OR text LIKE(?)', "%#{params[:keyword]}%","%#{params[:keyword]}%").where('price < ?',"#{params[:price_max]}").order(created_at:"desc")

      search_result = []
      if params[:product][:categories][0] == false || params[:product][:categories][0] == "---"
        @products = search_products
      else
        if params[:product][:categories][1] == false || params[:product][:categories][1] == "---"
          search_products.each do |p|
            if p.categories.include?(params[:product][:categories][0])
              search_result << p
              @products = search_result
            else
              @products = []
            end
          end
        else
          if params[:product][:categories][2] == false || params[:product][:categories][2] == "---"
            search_products.each do |p|
              if p.categories.include?(params[:product][:categories][1])
                search_result << p
                @products = search_result
              else
                @products = []
              end
            end
          else
            search_products.each do |p|
              if p.categories.include?(params[:product][:categories][2])
                search_result << p
                @products = search_result
              else
                @products = []
              end
            end
          end
        end
      end
    else
      search_products = Product.where('title LIKE(?) OR text LIKE(?)', "%#{params[:keyword]}%","%#{params[:keyword]}%").order(created_at:"desc")

      search_result = []
      if params[:product][:categories][0] == false || params[:product][:categories][0] == "---"
        @products = search_products
      else
        if params[:product][:categories][1] == false || params[:product][:categories][1] == "---"
          search_products.each do |p|
            if p.categories.include?(params[:product][:categories][0])
              search_result << p
              @products = search_result
            else
              @products = []
            end
          end
        else
          if params[:product][:categories][2] == false || params[:product][:categories][2] == "---"
            search_products.each do |p|
              if p.categories.include?(params[:product][:categories][1])
                search_result << p
                @products = search_result
              else
                @products = []
              end
            end
          else
            search_products.each do |p|
              if p.categories.include?(params[:product][:categories][2])
                search_result << p
                @products = search_result
              else
                @products = []
              end
            end
          end
        end
      end
    end
    
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end

    render search_products_path
  end


  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end


  def image_destroy
    @image = Image.find(params[:image_id])
    @image.destroy
  end

  private
  def product_params
    params.require(:product).permit(
      :title,
      :text,
      :price,
      :saler_id,
      {categories: []},
      images_attributes: [:id, :image],
    )
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_like
    @like = Like.new
  end

  def load_mydata
    @image = Image.where(product_id: @product)
  end
end
