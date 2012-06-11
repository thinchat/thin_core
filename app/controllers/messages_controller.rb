class MessagesController < ApplicationController
  respond_to :html, :json, :js

  def create
    params[:message].merge!(current_user.user_hash)
    message = Message.create!(params[:message])
    render :nothing => true, :status => 201 if message.broadcast
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