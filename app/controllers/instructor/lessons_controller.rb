module Instructor
  class LessonsController < Instructor::BaseController
    before_action :load_course_section
    before_action :load_lesson, only: %i[edit update show destroy]

    def index
      @lessons = filter_lessons.includes(:course_section)
    end

    def new
      @lesson = @course_section.lessons.new
    end

    def create
      @lesson = @course_section.lessons.new(lesson_params)
      if @lesson.save
        redirect_to instructor_course_section_lessons_path(@course_section), notice: 'Lesson has been created successfully.'
      else
        flash[:alert] = @lesson.errors.full_messages.to_sentence
        render :new
      end
    end

    def edit; end

    def update
      if @lesson.update(lesson_params)
        redirect_to instructor_course_section_lessons_path(@course_section), notice: 'Lesson has been updated successfully.'
      else
        flash[:alert] = @lesson.errors.full_messages.to_sentence
        render :edit
      end
    end

    def show; end

    def load_media
      @media_url  = params[:url]
      @media_type = params[:type]
    end

    def destroy
      if @lesson.destroy
        flash[:notice] = 'Lesson has been deleted!'
      else
        flash[:alert] = 'Error! unable to delete lesson at the moment!'
      end
      redirect_to instructor_course_section_lessons_path(@course_section)
    end

    def restore
      @lesson = Lesson.with_deleted.find(params[:id])

      redirect_to instructor_course_section_lessons_path(@course_section),  notice: 'Lesson has been restored' if @lesson.restore
    end

    private

    def load_course_section
      @course_section = current_user.course_sections.find(params[:course_section_id])
    end

    def load_lesson
      @lesson = @course_section.lessons.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:title, videos: [], files: [])
    end

    def filter_lessons
      lessons    = @course_section.lessons.with_deleted
      constraint = params.dig(:filter, :constraint)

      case constraint
      when 'deleted'
        lessons.deleted
      else
        lessons
      end
    end
  end
end
