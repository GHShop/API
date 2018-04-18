class ArtistController < ApplicationController
  before_action do
    all { authenticate!(User::Level::Manager, scopes: ["ghshop.own", "ghshop.manage"]) }
  end

  def index
    artists = Artist.all
    ArtistRenderer.render artists
  end

  def show
    if artist = Artist.find params["id"]
      ArtistRenderer.render artist
    else
      not_found! t("artist.errors.not_found", {id: params["id"]})
    end
  end

  def create
    artist = Artist.new(artist_params.validate!)

    if artist.valid? && artist.save
      ArtistRenderer.render artist
    else
      bad_request! t("artist.error.create")
    end
  end

  def update
    if artist = Artist.find params["id"]
      artist.set_attributes(artist_params.validate!)
      if artist.valid? && artist.save
        ArtistRenderer.render artist
      else
        bad_request! t("artist.error.update")
      end
    else
      not_found! t("artist.errors.not_found", {id: params["id"]})
    end
  end

  def destroy
    if artist = Artist.find params["id"]
      artist.destroy
      ArtistRenderer.render artist
    else
      not_found! t("artist.errors.not_found", {id: params["id"]})
    end
  end

  def artist_params
    params.validation do
      required(:introduction) { |f| !f.nil? }
      required(:name) { |f| !f.nil? }
      optional(:user_id) { |f| !f.nil? && f.numeric? }
    end
  end
end
