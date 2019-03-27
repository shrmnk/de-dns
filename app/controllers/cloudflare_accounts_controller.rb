class CloudflareAccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cloudflare_accounts = current_user.cloudflare_accounts
  end

  def show
    @cloudflare_account = current_user
                          .cloudflare_accounts
                          .find(params[:id])
  end

end
