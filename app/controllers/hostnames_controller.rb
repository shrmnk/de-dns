class HostnamesController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_name, only: [:show]
  before_action :prepare_zone, only: [:create]

  def index
    @hostnames = current_user.hostnames
  end

  def show
    @hostname = current_user.hostnames.find_by(name: @name) || not_found
  end

  def create
    @hostname = @zone.hostnames.new(hostname_params)

    if @hostname.save
      render :show
    else
      validation_error(@hostname)
    end
  end

  private

  def prepare_name
    @name = params[:name]
  end

  def prepare_zone
    @zone = current_user.zones.find_by(name: params[:zone_name])
  end

  def hostname_params
    params.require(:hostname).permit(
      :name,
      :a,
      :aaaa,
      :mx,
      :zone_id
    )
  end

end
