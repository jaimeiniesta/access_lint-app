class UsersController < Clearance::UsersController
  after_action :set_sign_up_success, only: :create

  private

  def set_sign_up_success
    if signed_in?
      flash[:success] = t(:success, scope: "flash.sign_up")
    end
  end
end
