class LikesController < ApplicationController
  def index
    likes = Like.all.order({ :created_at => :asc })

    render({ :json => likes.as_json })
  end

  def show
    the_id = params.fetch(:rt_photo_id)
    like = Like.where({ :id => the_id }).at(0)

    render({ :json => like.as_json })
  end

  def create
    like = Like.new
    like.fan_id = current_user.id
    like.photo_id = params.fetch(:qs_photo_id, nil)
    like.save

    current_user.likes_count = current_user.likes_count + 1
    current_user.save

    photo = Photo.where({ :id => like.photo_id }).at(0)
    photo.likes_count = photo.likes_count + 1
    photo.save
    
    respond_to do |format|
      format.json do
        render({ :json => like.as_json })
      end

      format.html do
        redirect_to("/photos/#{like.photo_id}")
      end
    end
  end

  def update
    the_id = params.fetch(:rt_photo_id)
    like = Like.where({ :id => the_id }).at(0)
    like.fan_id = params.fetch(:qs_fan_id, nil)
    like.photo_id = params.fetch(:qs_photo_id, nil)
    like.save
    
    render({ :json => like.as_json })
  end

  def destroy
    like = Like.find(params.fetch(:rt_like_id)).destroy

    current_user.likes_count = current_user.likes_count - 1
    current_user.save

    photo = Photo.where({ :id => like.photo_id }).at(0)
    photo.likes_count = photo.likes_count - 1
    photo.save

    respond_to do |format|
      format.json do
        render({ :json => like.as_json })
      end

      format.html do
        redirect_to("/photos/#{like.photo_id}")
      end
    end
  end
end
