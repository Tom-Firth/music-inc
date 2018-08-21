class AlbumsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      sql_query = "title ILIKE :query OR author ILIKE :query"
      @albums = Album.where(sql_query, query: "%#{params[:query]}%").page(params[:page]).per(6)
    else
      @albums = Album.page(params[:page]).per(6)
    end
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.user = current_user
    @album.author = current_user.name

    if @album.save
      redirect_to @album
    else
      render 'new'
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to @album
    else
      render 'new'
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album.user == current_user
      @album.destroy
    end
    redirect_to albums_path
  end

  private

  def album_params
    params.require(:album).permit(:title, :cover, :description)
  end
end
