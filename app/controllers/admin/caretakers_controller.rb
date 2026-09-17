module Admin
  class CaretakersController < BaseController
    before_action :set_caretaker, only: [ :show, :edit, :update, :destroy ]

    def index
      @caretakers = User.caretaker.order(:full_name)
      if params[:q].present?
        q = "%#{params[:q]}%"
        @caretakers = @caretakers.where("full_name ILIKE :q OR phone_number ILIKE :q", q: q)
      end
    end

    def show
      @patients = @caretaker.approved_patient_links.includes(:patient)
      @pending_links = @caretaker.caretaker_care_links.pending.includes(:patient)
    end

    def edit
    end

    def update
      if @caretaker.update(caretaker_params)
        redirect_to admin_caretaker_path(@caretaker), notice: "Profile updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @caretaker.destroy!
      redirect_to admin_caretakers_path, notice: "#{@caretaker.full_name} was removed."
    end

    private

    def set_caretaker
      @caretaker = User.caretaker.find(params[:id])
    end

    def caretaker_params
      params.expect(user: [ :full_name, :email, :phone_number ])
    end
  end
end
