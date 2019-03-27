json.cloudflare_zones do
  json.array! @cloudflare_zones do |name, identifier|
    json.identifier identifier
    json.name name
  end
end
