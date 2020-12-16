# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def task_created
    user = User.first
    task = Task.first
    params = { user: user, task: task }

    UserMailer.with(params).task_created
  end

  def task_updated
    user = User.first
    task = Task.first
    params = { user: user, task: task }

    UserMailer.with(params).task_updated
  end

  def task_deleted
    user = User.first
    task = Task.first
    params = { user: user, task: task }

    UserMailer.with(params).task_deleted
  end

  def reset_password
    user = User.first
    user.password_reset_token = JsonWebToken.encode
    params = { user: user }
    UserMailer.with(params).reset_password
  end
end
