module Admin
  class MealPlanItemsController < BaseController
    before_action :set_meal
    before_action :set_item, only: [ :edit, :update, :destroy ]

    def new
      @item = @meal.meal_plan_items.build
    end

    def create
      @item = @meal.meal_plan_items.build(item_params)
      # No position field in the form (order is managed by append-to-end) —
      # position has a DB default of 0, so it's never actually blank here.
      @item.position = (@meal.meal_plan_items.maximum(:position) || -1) + 1
      if @item.save
        redirect_to edit_admin_meal_plan_day_meal_plan_meal_path(@meal.meal_plan_day, @meal), notice: "Added \"#{@item.name_en}\"."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @item.update(item_params)
        redirect_to edit_admin_meal_plan_day_meal_plan_meal_path(@meal.meal_plan_day, @meal), notice: "Updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @item.destroy!
      redirect_to edit_admin_meal_plan_day_meal_plan_meal_path(@meal.meal_plan_day, @meal), notice: "#{@item.name_en} was removed."
    end

    private

    def set_meal
      @meal = MealPlanMeal.find(params[:meal_plan_meal_id])
    end

    def set_item
      @item = @meal.meal_plan_items.find(params[:id])
    end

    def item_params
      params.expect(meal_plan_item: [ :name_en, :name_th, :protein_en, :protein_th ])
    end
  end
end
