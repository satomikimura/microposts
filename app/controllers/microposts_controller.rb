class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success]='Sent message'
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = ' Failed to sent message'
      render 'toppages/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success]='delete message'
    redirect_back(fullback_location: root_path)
  end
  
  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      unless @micropost
        redirect_to root_path
      end
    end
end
