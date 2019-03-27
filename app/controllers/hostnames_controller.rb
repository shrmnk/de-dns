class HostnamesController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_name, only: [:show]

  def index
    @hostnames = current_user.hostnames
  end

  def show
    @hostname = current_user.hostnames.find_by(name: @name) || not_found
  end

  private

  def prepare_name
    @name = params[:name]
  end

end
