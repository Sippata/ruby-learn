require 'test_helper'

class Web::PasswordResetsControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should post create' do
    user = create(:user)
    attr = { email: user.email }

    assert_emails 1 do
      post :create, params: { user_email_form: attr }
    end

    assert_response :redirect
  end

  test 'should get show' do
    user = create(:user)
    token = JsonWebToken.encode({ user_id: user.id })
    get :show, params: { id: token }
    assert_response :success
  end

  test 'should put update' do
    user = create(:user, { password: generate(:string) })
    previous_password_digest = user.password_digest.dup
    new_password = generate(:string)
    token = JsonWebToken.encode({ user_id: user.id })
    attr = {
      password: new_password,
      password_confirmation: new_password,
    }

    put :update, params: { id: token, password_reset_form: attr }

    assert_response :redirect
    user.reload
    assert_not_equal previous_password_digest, user.password_digest
  end
end
