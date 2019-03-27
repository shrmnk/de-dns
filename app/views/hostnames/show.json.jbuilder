json.hostname do
  json.partial! 'hostnames/hostname', hostname: @hostname
end
