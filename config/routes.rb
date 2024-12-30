Rails.application.routes.draw do
  root 'playlists#new'
  post '/download', to: 'playlists#download'
end
