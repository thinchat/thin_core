class MessagesController < ApplicationController
  respond_to :html, :json, :js

  def create
    params_hash = build_params_hash(params[:message])
    message = Message.new(params_hash)
    Resque.enqueue(CreateMessageJob, params_hash.to_json)
    render :nothing => true, :status => 201 if message.broadcast
  end

  private

  def build_params_hash(params)
    { :body => params["body"],
      :room_id => params["room_id"],
      :message_type => params["message_type"],
      :user_id => current_user.user_hash[:user_id],
      :user_type => current_user.user_hash[:user_type],
      :user_name => current_user.user_hash[:user_name] }
  end
end