Rails.application.routes.draw do
  # Routes for signing up
  
  match("/sign_up", { :controller => "users", :action => "registration_form", :via => "get" })

  match("/insert_user", { :controller => "users", :action => "create", :via => "post" })

  # Routes for signing in
  match("/sign_in", { :controller => "users", :action => "session_form", :via => "get" })

  match("/verify_credentials", { :controller => "users", :action => "add_cookie", :via => "post" })

  # Route for signing out

  match("/sign_out", { :controller => "users", :action => "remove_cookies", :via => "get" })

  # Homepage

  match("/", { :controller => "users", :action => "index", :via => "get" })

  # User routes

  # CREATE
  match("/post_user", {:controller => "users", :action => "create", :via => "post"})

  # READ
  match("/users", {:controller => "users", :action => "index", :via => "get"})
  match("/users/:rt_username", {:controller => "users", :action => "show", :via => "get"})
  match("/users/:rt_username/own_photos", {:controller => "users", :action => "own_photos", :via => "get"})
  match("/users/:rt_username/liked_photos", {:controller => "users", :action => "liked_photos", :via => "get"})
  match("/users/:rt_username/feed", {:controller => "users", :action => "feed", :via => "get"})
  match("/users/:rt_username/discover", {:controller => "users", :action => "discover", :via => "get"})
  

  # UPDATE
  match("/patch_user/:rt_user_id", {:controller => "users", :action => "update", :via => "post"})

  # DELETE
  match("/delete_user/:rt_user_id", {:controller => "users", :action => "destroy", :via => "get"})
  

  
  # Photo routes

  # CREATE
  match("/post_photo", { :controller => "photos", :action => "create", :via => "post"})

  # READ
  match("/photos", { :controller => "photos", :action => "index", :via => "get"})

  match("/photos/:rt_photo_id", { :controller => "photos", :action => "show", :via => "get"})
  
  match("/photos/:rt_photo_id/comments", { :controller => "photos", :action => "comments", :via => "get"})
  match("/photos/:rt_photo_id/likes", { :controller => "photos", :action => "likes", :via => "get"})
  match("/photos/:rt_photo_id/fans", { :controller => "photos", :action => "fans", :via => "get"})

  # UPDATE
  match("/patch_photo/:rt_photo_id", { :controller => "photos", :action => "update", :via => "post"})

  # DELETE
  match("/delete_photo/:rt_photo_id", { :controller => "photos", :action => "destroy", :via => "get"})


  # Like routes

  # CREATE
  match("/post_like", {:controller => "likes", :action => "create", :via => "post"})

  # READ
  match("/likes", {:controller => "likes", :action => "index", :via => "get"})
  match("/likes/:rt_like_id", {:controller => "likes", :action => "show", :via => "get"})

  # UPDATE
  match("/patch_like/:rt_like_id", {:controller => "likes", :action => "update", :via => "get"})

  # DELETE
  match("/delete_like/:rt_like_id", {:controller => "likes", :action => "destroy", :via => "get"})
  
  # Comment routes

  # CREATE
  match("/post_comment", { :controller => "comments", :action => "create", :via => "post"})

  # READ
  match("/comments", { :controller => "comments", :action => "index", :via => "get"})
  match("/comments/:rt_comment_id", { :controller => "comments", :action => "show", :via => "get"})

  # UPDATE
  match("/patch_comment/:rt_comment_id", { :controller => "comments", :action => "update", :via => "get"})

  # DELETE
  match("/post_comment", { :controller => "comments", :action => "create", :via => "get"})

  match("/delete_comment/:rt_comment_id", { :controller => "comments", :action => "destroy", :via => "get"})


  # Follow Request routes
  match("/insert_follow_request", { :controller => "follow_requests", :action => "create", :via => "post"})

  match("/delete_follow_request/:rt_follow_request_id", { :controller => "follow_requests", :action => "destroy", :via => "get"})

  match("/modify_follow_request/:rt_follow_request_id", { :controller => "follow_requests", :action => "update", :via => "post"})

  # ============

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
