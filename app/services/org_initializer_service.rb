class OrgInitializerService
  def initialize(user)
    @user         = user
    @organization = @user.organization
  end

  def execute
    Apartment::Tenant.create(@organization.name)
    copied_user = build_duplicate_user
    Apartment::Tenant.switch(@organization.name) { copied_user.save(validate: false) }
  end

  private

  def build_duplicate_user
    dup_user = @user.dup
    dup_user.build_organization(@organization.org_copy_attributes)
    dup_user
  end
end
