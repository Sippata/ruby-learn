class Web::PasswordResetsController < Web::ApplicationController
  def new
    @user_email = UserEmailForm.new
  end

  def create
    user = UserEmailForm.new(user_email_params).user
    UserMailer.with({ user: user }).reset_password.deliver_now if user
    redirect_to(new_session_path)
  end

  def show
    @password_reset = PasswordResetForm.new
    @token = params[:id]
  end

  def update
    token = JsonWebToken.decode(params[:id])
    if token
      User.find(token['user_id'])
        .update(password_reset_params)
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
