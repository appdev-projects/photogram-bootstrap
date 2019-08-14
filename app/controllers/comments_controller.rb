class CommentsController < ApplicationController
  def index
    comments = Comment.all.order({ :created_at => :asc })

    render({ :json => comments.as_json })
  end

  def show
    the_id = params.fetch(:rt_comment_id)
    comment = Comment.where({ :id => the_id }).at(0)

    render({ :json => comment.as_json })
  end

  def create
    comment = Comment.new

    comment.author_id = current_user.id
    comment.photo_id = params.fetch(:qs_photo_id, nil)
    comment.body = params.fetch(:qs_body, nil)
    
    comment.save

    current_user.comments_count = current_user.comments_count + 1
    current_user.save

    photo = Photo.where({ :id => comment.photo_id }).at(0)
    photo.comments_count = photo.comments_count + 1
    photo.save

    respond_to do |format|
      format.json do
        render({ :json => comment.as_json })
      end

      format.html do
        redirect_to("/photos/#{comment.photo_id}")
      end
    end
  end

  def update
    the_id = params.fetch(:rt_comment_id)
    comment = Comment.where({ :id => the_id }).at(0)

    comment.name = params.fetch(:qs_body, comment.body)
    comment.dob = params.fetch(:qs_author_id, comment.author_id)
    comment.bio = params.fetch(:qs_photo_id, comment.photo_id)

    comment.save

    render({ :json => comment.as_json })
  end

  def destroy
    the_id = params.fetch(:rt_comment_id)
    comment = Comment.where({ :id => the_id }).at(0)

    comment.destroy

    current_user.comments_count = current_user.comments_count - 1
    current_user.save

    photo = Photo.where({ :id => comment.photo_id }).at(0)
    photo.comments_count = photo.comments_count - 1
    photo.save

    render({ :json => comment.as_json })
  end
 
end
