module Organisation
  class ProfilesController < Organisation::BaseController
    def index; end

    def edit; end

    def update
      skip_password_validation?
      if current_user.update_with_password(profile_params)
        sign_in(current_user, :bypass => true)
        redirect_to organisation_profiles_path, notice: 'Profile has been updated'
      else
        flash[:alert] = current_user.errors.full_messages.to_sentence
        render :edit
      end

    end

    private

    def profile_params
      params.require(:user).permit(:first_name, :last_name, :email, :contact, :birth_date, :specialization, :highest_education, :image, :current_password, :password, :password_confirmation)
    end

    def skip_password_validation?
      current_user.skip_password_validation = params.dig(:user, :password).blank? &&
                                             params.dig(:user, :password_confirmation).blank?
    end
  end
end
