module Organisation
  class BatchesController < Organisation::BaseController
    before_action :load_batch, only: %i[show edit update destroy]

    def index
      @batches = filter_batches
    end

    def new
      @batch = Batch.new
      form_data
    end

    def create
      @batch = Batch.new(batch_params)
      if @batch.save
        redirect_to organisation_batches_path, notice: 'Batch has been created.'
      else
        form_data
        flash[:alert] = @batch.errors.full_messages.to_sentence
        render :new
      end
    end

    def show; end

    def edit
      form_data
    end

    def update
      if @batch.update(batch_params)
        redirect_to organisation_batches_path, notice: 'Batch has been updated'
      else
        form_data
        flash[:alert] = @batch.errors.full_messages.to_sentence
        render :edit
      end
    end

    def destroy
      if @batch.destroy
        flash[:notice] = 'Batch deleted!'
      else
        flash[:alert] = 'Batch not delete!'
      end
      redirect_to organisation_batches_path
    end

    def restore
      @batch = Batch.with_deleted.find(params[:id])

      redirect_to organisation_batches_path, notice: 'Batch has been restored' if @batch.restore
    end

    private

    def batch_params
      params.require(:batch).permit(:title, :description, :start_date, :end_date, sections_attributes: section_params)
    end

    def section_params
      [:id, :title, :description, :_destroy, course_sections_attributes: course_sections_params]
    end

    def course_sections_params
      [:id, :course_id, :_destroy, course_section_users_attributes: course_section_users_params]
    end

    def course_section_users_params
      %i[id user_id _destroy]
    end

    def load_batch
      @batch = Batch.find(params[:id])
    end

    def form_data
      @courses     = Course.published
      @instructors = User.instructor
    end

    def filter_batches
      batches    = Batch.with_deleted
      start_date = params.dig(:filter, :start_date)
      end_date   = params.dig(:filter, :end_date)
      constraint = params.dig(:filter, :constraint)

      batches = batches.where('start_date >= ?', start_date.to_date)  if start_date.present?
      batches = batches.where('end_date <= ?', end_date.to_date)      if end_date.present?

      case constraint
      when 'deleted'
        batches.deleted
      else
        batches
      end
    end
  end
end
