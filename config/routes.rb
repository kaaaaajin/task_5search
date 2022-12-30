Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about"
# ネストすることによって、どの投稿に紐づいたコメントなのかをURLで判断できる
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
  resources :book_comments, only: [:create, :destroy]
  resource :favorites, only: [:create, :destroy]
  # 1人のユーザーは1つの投稿に対して1回しかいいねできない」という仕様であるため、
  # destroyをする際にもユーザーidと投稿(post_image)idが分かれば、どのいいねを削除すればいいのかが特定できます。
  # いいねのidはURLに含める必要がない(params[:id]を使わなくても良い)ため、resourcesではなくresourceを使ってURLに/:idを含めない形にしています。
  # resourceは「それ自身のidが分からなくても、関連する他のモデルのidから特定できる」場合に

 end
  resources :users, only: [:index,:show,:edit,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end