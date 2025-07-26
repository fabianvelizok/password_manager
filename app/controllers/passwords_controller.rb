class PasswordsController < ApplicationController
  before_action :set_password, except: [ :index, :new, :create ]

  def index
    @passwords = current_user.passwords
  end

  def new
    @password = Password.new
  end

  def create
    @password = Password.new(password_params)
    @password.user_passwords.new(user: current_user)

    if @password.save
      redirect_to @password
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @password.update(password_params)
      redirect_to @password
    else
      render :edit, :unproccessable_entity
    end
  end

  private

  def password_params
    params.require(:password).permit(:url, :username, :password)
  end

  def set_password
    @password = current_user.passwords.find(params[:id])
  end
end
