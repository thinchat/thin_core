class MessagesController < ApplicationController
  respond_to :html, :json, :js

  def create
    message = Message.create!(user_hash_for_create(params[:message]))
    render :nothing => true, :status => 201 if message.broadcast
  end

  private

  def user_hash_for_create(params)
    { :body => params["body"],
      :room_id => params["room_id"],
      :message_type => params["message_type"],
      :user_id => current_user.user_hash[:id],
      :user_type => current_user.user_hash[:user_type],
      :user_name => current_user.user_hash[:user_name] }
  end
end

# {"channel"=>"/messages/5", 
#  "data"=> { 
#             "chat_message"=> { "user_name"=>"Jonan", 
#                          "user_id"=>1, 
#                          "user_type"=>"Guest", 
#                          "message_id"=>1, 
#                          "message_type"=>"Message", 
#                          "message_body"=>"I'm a farmer.", 
#                          "metadata"=>{}, 
#                          "created_at"=>"2012-06-07T17:49:57Z" } } }