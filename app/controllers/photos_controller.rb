class PhotosController < ApplicationController
  def index
    @photos = Photo.all.order({ :created_at => :desc })

    respond_to do |format|
      format.json do
        render({ :json => @photos.as_json })
      end

      format.html do
        render({ :template => "photos/index.html" })
      end
    end
  end

  def show
    the_id = params.fetch(:rt_photo_id)
    @photo = Photo.where({ :id => the_id }).at(0)

    respond_to do |format|
      format.json do
        render({ :json => @photo.as_json })
      end

      format.html do
        render({ :template => "photos/show.html" })
      end
    end
  end

  def create
    photo = Photo.new

    photo.owner_id = current_user.id
    photo.caption = params.fetch(:qs_caption, nil)
    photo.image = params.fetch(:qs_image, nil)
    photo.likes_count = params.fetch(:qs_likes_count, 0)
    photo.comments_count = params.fetch(:qs_comments_count, 0)
    
    photo.save

    respond_to do |format|
      format.json do
        render({ :json => photo.as_json })
      end

      format.html do
        redirect_to("/photos/#{photo.id}")
      end
    end
  end

  def update
    the_id = params.fetch(:rt_photo_id)
    photo = Photo.where({ :id => the_id }).at(0)


    photo.owner_id = params.fetch(:qs_owner_id, photo.owner_id)
    photo.caption = params.fetch(:qs_caption, photo.caption)
    photo.image = params.fetch(:qs_image, photo.image)
    photo.likes_count = params.fetch(:qs_likes_count, photo.likes_count)
    photo.comments_count = params.fetch(:qs_comments_count, photo.comments_count)
    
    photo.save
  
    respond_to do |format|
      format.json do
        render({ :json => photo.as_json })
      end

      format.html do
        redirect_to("/photos/#{photo.id}")
      end
    end
  end

  def destroy
    the_id = params.fetch(:rt_photo_id)
    photo = Photo.where({ :id => the_id }).at(0)

    photo.destroy

    respond_to do |format|
      format.json do
        render({ :json => photo.as_json })
      end

      format.html do
        redirect_to("/photos")
      end
    end  end
 
  def comments
    the_id = params.fetch(:rt_photo_id)
    photo = Photo.where({ :id => the_id }).at(0)

    the_comments = photo.comments.order(:created_at)

    render({ :json => the_comments.as_json })
  end

  def likes
    the_id = params.fetch(:rt_photo_id)
    photo = Photo.where({ :id => the_id }).at(0)

    the_likes = photo.likes.order(:created_at)

    render({ :json => likes.as_json })
  end

  def fans
    the_id = params.fetch(:rt_photo_id)
    photo = Photo.where({ :id => the_id }).at(0)

    the_fans = photo.fans.order(:created_at)

    render({ :json => the_fans.as_json })
  end
end
