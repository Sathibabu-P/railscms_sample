class Admin::CategoriesController < Admin::BaseController
  before_action :set_admin_category, only: [:show, :edit, :update, :destroy]

  # GET /admin/categories
  # GET /admin/categories.json
  def index
    # @admin_categories = Category.all
    
    respond_to do |format|
      format.html
      format.json { render json: CategoryDatatable.new(params,  view_context: view_context) }
    end

  end

  # GET /admin/categories/1
  # GET /admin/categories/1.json
  def show
  end

  # GET /admin/categories/new
  def new
    @admin_category = Category.new
  end

  # GET /admin/categories/1/edit
  def edit
  end

  # POST /admin/categories
  # POST /admin/categories.json
  def create
    @admin_category = Category.new(admin_category_params)

    respond_to do |format|
      if @admin_category.save
        #  @admin_category.image.attach(params[:image])
        format.html { redirect_to admin_categories_url, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @admin_category }
      else
        format.html { render :new }
        format.json { render json: @admin_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/categories/1
  # PATCH/PUT /admin/categories/1.json
  def update
    respond_to do |format|
      if @admin_category.update(admin_category_params)
        format.html { redirect_to admin_categories_url, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_category }
      else
        format.html { render :edit }
        format.json { render json: @admin_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/categories/1
  # DELETE /admin/categories/1.json
  def destroy
    @admin_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def activate
    @admin_category = Category.find(params[:category_id])
    @admin_category.status = !@admin_category.status
    @admin_category.save!
    redirect_to admin_categories_url,notice: 'Category was successfully updated.'      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_category
      @admin_category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_category_params
      params.require(:category).permit(:name, :description, :position, :status, :image,:preview)
    end
end