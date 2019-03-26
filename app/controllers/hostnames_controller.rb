class HostnamesController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_slug, only: [:show]

  def index
    @hostnames = current_user.hostnames
  end

  def show
    @hostname = current_user.hostnames.find_by(slug: @slug) || not_found
  end

  private

  def prepare_slug
    @slug = params[:slug]
  end

end
