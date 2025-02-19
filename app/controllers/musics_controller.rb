class MusicsController < ApplicationController
  before_action :set_music, only: [:edit, :update]

  def index
    @q = Music.all.ransack(params[:q])
    @musics = @q.result.order(created_at: :desc).paginate(page: params[:page], per_page: 5)

    respond_to do |format|
      format.html
    end
  end

  def new
    @music = Music.new
  end

  def create
    @music = Music.new(music_params)
    
    respond_to do |format|
      if @music.save
        format.html { redirect_to musics_path, notice: 'Música guardada con éxito.' }
        format.json { render :show, status: :created, location: @music }
      else
        format.html { render :new }     
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit;end

  def update
    respond_to do |format|
      if @music.update(music_params)
        format.html { redirect_to musics_url, notice: 'Música actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @music }
      else
        format.html { render :edit }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  def search_in_rapid_api
    return redirect_to home_path, alert: 'La búsqueda está vacía.' if params[:keyword].blank?

    page = params[:page] || 1
    per_page = 5
    keyword = params[:keyword]

    results = RapidApiMusicService.new(keyword).call

    results_paginated = WillPaginate::Collection.create(page, per_page, results.length) do |pager| 
      start = (pager.current_page - 1) * pager.per_page
      pager.replace(results[start, pager.per_page] || [])
    end

    respond_to do |format|
      format.html
      format.json { render json: { items: results_paginated, total_pages: results_paginated.total_pages, current_page: results_paginated.current_page }}
    end
  end

  private

  def set_music
    @music = Music.find(params[:id])
  end

  def music_params
    params.require(:music).permit(:title, :author, :album, :duration, :reference_api)
  end
end
