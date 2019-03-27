json.cloudflare_account do
  json.partial! 'cloudflare_accounts/cloudflare_account',
                cloudflare_account: @cloudflare_account
end
