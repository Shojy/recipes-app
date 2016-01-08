class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :new, :create, :destroy]

  def index
    @recipe = Recipe.all.order('updated_at desc')
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = 'Successfully updated recipe'
      redirect_to @recipe
    else 
      render 'edit'
    end
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      flash[:success] = 'Successfully added new recipe'
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def show
  end

  def destroy
    @recipe.destroy

    flash[:success] = 'Successfully deleted recipe'
    redirect_to root_path
  end

  private

    def find_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy], instructions_attributes: [:id, :step, :_destroy])
    end
end
