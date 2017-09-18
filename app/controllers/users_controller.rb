class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def upgrade
    @user.role = 'premium'
  end
  
  def downgrade
    @user.role = 'user'
  end
end
