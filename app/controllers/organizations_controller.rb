class OrganizationsController < ApplicationController
  def new
    @user = User.new
    @user.build_organization
  end

  def create
    @user      = User.new(user_params)
    @user.role = User.roles[:org_owner]

    if @user.save
      OrgInitializerService.new(@user).execute
      redirect_to new_user_session_url(subdomain: @user.organization.name), notice: 'Organization was successfully created.'
    else
      render :new
    end
  end

  private

  def user_params
    params[:user][:organization_attributes][:name] = Organization.normalized_name(params[:user][:organization_attributes][:name])

    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 organization_attributes: [:name, additional_information: {}])
  end
end
