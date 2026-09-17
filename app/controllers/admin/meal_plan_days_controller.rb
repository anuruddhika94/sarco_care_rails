module Admin
  class MealPlanDaysController < BaseController
    before_action :set_day, only: [ :edit, :update ]

    def index
      @days = MealPlanDay.order(:day_number)
    end

    def edit
    end

    def update
      if @day.update(day_params)
        redirect_to edit_admin_meal_plan_day_path(@day), notice: "Updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_day
      @day = MealPlanDay.find(params[:id])
    end

    def day_params
      params.expect(meal_plan_day: [ :label_en, :label_th, :day_total_en, :day_total_th ])
    end
  end
end
