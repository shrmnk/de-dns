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

  def create
    @cloudflare_account = current_user.cloudflare_accounts.new(
      cloudflare_account_params
    )

    if @cloudflare_account.save
      render :show
    else
      validation_error(@cloudflare_account)
    end
  end

  private

  def cloudflare_account_params
    params.require(:cloudflare_account).permit(:name, :email, :key)
  end

end
