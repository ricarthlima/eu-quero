class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    redirect_to root_path
    flash[alert] = "Em breve."
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @wishlist = Wishlist.where("id = '" + @item.wishlist_id + "'")[0]

    respond_to do |format|
      if @item.save
        format.html { redirect_to @wishlist, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { redirect_to @wishlist }
        
        flash[alert] = ""
        @item.errors.each do |key|
          flash[alert] = flash[alert] + " " + @item.errors[key][0]
        end
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @wishlist = Wishlist.where("id = '" + @item.wishlist_id + "'")[0]
    @item.destroy
    respond_to do |format|
      format.html { redirect_to @wishlist, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:nome, :link_img, :link_prod, :preco, :desc, :wishlevel, :ativo, :wishlist_id)
    end
end
