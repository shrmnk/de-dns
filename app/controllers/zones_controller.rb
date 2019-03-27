class ZonesController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_name, only: [:show]
  before_action :prepare_cloudflare_account, only: %i[new create]

  def index
    @zones = current_user.zones
  end

  def show
    @zone = current_user.zones.find_by(name: @name) || not_found
  end

  def new
    @cloudflare_zones = @cloudflare_account.cloudflare_zones
  end

  def create
    @zone = @cloudflare_account.zones.new(zone_params)

    if @zone.save
      render :show
    else
      validation_error(@zone)
    end
  end

  private

  def prepare_name
    @name = params[:name]
  end

  def prepare_cloudflare_account
    @cloudflare_account = current_user
                          .cloudflare_accounts
                          .find(params[:cloudflare_account_id])
  end

  def zone_params
    params.require(:zone).permit(:name, :identifier)
  end

end
