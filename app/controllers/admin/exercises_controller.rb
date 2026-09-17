module Admin
  class ExercisesController < BaseController
    before_action :set_exercise, only: [ :edit, :update, :destroy ]

    # The app only falls back to this icon if a video's thumbnail fails to
    # load — not worth an admin picker, so every new exercise gets the same
    # generic one.
    DEFAULT_ICON = "fitness_center".freeze

    def index
      @exercises = Exercise.order(:name_en)
    end

    def new
      @exercise = Exercise.new
    end

    def create
      video_id = YoutubeUrl.extract_id(params[:youtube_url])
      if video_id.blank?
        @exercise = Exercise.new(exercise_params)
        @exercise.errors.add(:video_id, "couldn't find a video id in that URL")
        return render :new, status: :unprocessable_entity
      end

      title = YoutubeUrl.fetch_title(video_id)
      if title.blank?
        @exercise = Exercise.new(exercise_params)
        @exercise.errors.add(:video_id, "couldn't fetch that video's title from YouTube — check the link is public")
        return render :new, status: :unprocessable_entity
      end

      @exercise = Exercise.new(exercise_params.merge(
        video_id: video_id,
        name_en: title,
        name_th: title,
        icon: DEFAULT_ICON,
        key: unique_key_for(title)
      ))
      if @exercise.save
        redirect_to admin_exercises_path, notice: "Added \"#{title}\"."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @exercise.update(exercise_params)
        redirect_to admin_exercises_path, notice: "Updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @exercise.destroy!
      redirect_to admin_exercises_path, notice: "#{@exercise.name_en} was removed."
    end

    private

    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    def exercise_params
      params.expect(exercise: [ :name_en, :name_th, :default_minutes ])
    end

    def unique_key_for(title)
      base = title.parameterize.presence || "exercise"
      key = base
      n = 2
      while Exercise.exists?(key: key)
        key = "#{base}-#{n}"
        n += 1
      end
      key
    end
  end
end
