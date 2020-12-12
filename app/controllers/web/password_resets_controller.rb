class Web::PasswordResetsController < Web::ApplicationController
  def new
    @user_email = UserEmailForm.new
  end

  def create
    user = UserEmailForm.new(user_email_params).user
    user.update({ password_reset_token: JsonWebToken.encode })
    UserMailer.with({ user: user }).reset_password.deliver_now if user
    redirect_to(new_session_path)
  end

  def edit
    @password_reset = PasswordResetForm.new
    @token = params[:token]
  end

  def update
    token = JsonWebToken.decode(params[:token])
    user = User.find_by_password_reset_token(params[:token])
    if user && token
      user.update({ **password_reset_params, password_reset_token: nil })
    end
    redirect_to(new_session_path)
  end

  private

  def password_reset_params
    params.require(:password_reset_form).permit(:password, :password_confirmation)
  end

  def user_email_params
    params.require(:user_email_form).permit(:email)
  end
end
