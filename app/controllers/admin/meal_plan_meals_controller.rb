module Admin
  class MealPlanMealsController < BaseController
    before_action :set_day
    before_action :set_meal, only: [ :edit, :update, :destroy ]

    # Keep in sync with the app's icon lookup (sarco_care/lib/data/meal_plan.dart,
    # mealIconForKey) — only these keys resolve to a real icon there.
    ICONS = %w[rice_bowl soup_kitchen set_meal local_drink_outlined ramen_dining icecream egg_alt].freeze

    def new
      @meal = @day.meal_plan_meals.build
    end

    def create
      @meal = @day.meal_plan_meals.build(meal_params)
      # No position field in the form (order is managed by append-to-end) —
      # position has a DB default of 0, so it's never actually blank here.
      @meal.position = (@day.meal_plan_meals.maximum(:position) || -1) + 1
      if @meal.save
        redirect_to edit_admin_meal_plan_day_path(@day), notice: "Added \"#{@meal.title_en}\"."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @meal.update(meal_params)
        redirect_to edit_admin_meal_plan_day_path(@day), notice: "Updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @meal.destroy!
      redirect_to edit_admin_meal_plan_day_path(@day), notice: "#{@meal.title_en} was removed."
    end

    private

    def set_day
      @day = MealPlanDay.find(params[:meal_plan_day_id])
    end

    def set_meal
      @meal = @day.meal_plan_meals.find(params[:id])
    end

    def meal_params
      params.expect(meal_plan_meal: [
        :slot, :title_en, :title_th, :icon, :total_protein_en, :total_protein_th, :image, :photo
      ])
    end
  end
end
