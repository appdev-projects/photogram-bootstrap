class FollowRequestsController < ApplicationController
  def create
    follow_request = FollowRequest.new

    follow_request.recipient_id = params.fetch(:qs_recipient_id)
    follow_request.sender_id = current_user.id

    recipient = User.where({ :id => follow_request.recipient_id }).at(0)
    
    if !recipient.private
      follow_request.status = "accepted"
    else
      follow_request.status = "pending"
    end

    follow_request.save

    redirect_to("/users/#{recipient.username}")
  end

  def destroy
    follow_request = FollowRequest.where({ :id => params.fetch(:rt_follow_request_id) }).at(0)

    follow_request.destroy

    recipient = User.where({ :id => follow_request.recipient_id }).at(0)

    redirect_to("/users/#{recipient.username}")
  end

  def update
    the_id = params.fetch(:rt_follow_request_id)
    follow_request = FollowRequest.where({ :id => the_id }).at(0)

    follow_request.status = params.fetch(:qs_status, nil)
    follow_request.save
    
    redirect_to("/users/#{follow_request.recipient.username}")
  end
end
