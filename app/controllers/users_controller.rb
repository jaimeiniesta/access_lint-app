class UsersController < Clearance::UsersController
  after_action :set_sign_up_success, only: :create

  private

  def set_sign_up_success
    if signed_in?
      flash[:success] = t(:sign_up_success)
    end
  end
end
