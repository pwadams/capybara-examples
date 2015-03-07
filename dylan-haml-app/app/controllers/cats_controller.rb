class CatsController < ApplicationController
  before_action :ensure_current_user
  before_action :set_cat, only:[:show, :edit, :update]

  def index
    @cats = Cat.all
  end

  def show
  end

  def new
    @cat = Cat.new
  end

  def create
    cat = Cat.new(cat_params)
    if cat.save
      flash[:notice] = 'Congratulations on your new cat!'
      redirect_to cats_path
    else
      @cat = cat
      render :new
    end
  end

  def edit
  end

  def update
    if @cat.update(cat_params)
      flash[:notice] = "You changed #{@cat.name}'s stats!"
      redirect_to cats_path
    else
      render :edit
    end
  end

  def destroy
    cat = Cat.find(params[:id])
    cat.destroy
    flash[:notice] = 'Your cat ran away!'
    redirect_to cats_path
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :age, :friendly)
  end

  def set_cat
    @cat = Cat.find(params[:id])
  end

end
