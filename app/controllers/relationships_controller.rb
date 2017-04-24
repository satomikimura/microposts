class RelationshipsController < ApplicationController
  def create
    user=User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = ' follow this user'
    redirect_to user
  end

  def destroy
    user=User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] ='Unfollow this user'
    redirect_to user
  end
end
