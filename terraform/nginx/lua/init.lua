local redis = require "resty.redis"

   auto_ssl = (require "resty.auto-ssl").new()

   auto_ssl:set("allow_domain", function(domain)
local ssl_certificate_domain_is_valid = false
--
local function ip_addr_get_type(ip)
  local R = {ERROR = 0, IPV4 = 1, IPV6 = 2, STRING = 3}
  if type(ip) ~= "string" then return R.ERROR end

  -- check for format 1.11.111.111 for ipv4
  local chunks = {ip:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$")}
  if #chunks == 4 then
    for _,v in pairs(chunks) do
      if tonumber(v) > 255 then return R.STRING end
    end
    return R.IPV4
  end

  -- check for ipv6 format, should be 8 'chunks' of numbers/letters
  -- without leading/trailing chars
  -- or fewer than 8 chunks, but with only one `::` group
  local chunks = {ip:match("^"..(("([a-fA-F0-9]*):"):rep(8):gsub(":$","$")))}
  if #chunks == 8
  or #chunks < 8 and ip:match('::') and not ip:gsub("::","",1):match('::') then
    for _,v in pairs(chunks) do
      if #v > 0 and tonumber(v, 16) > 65535 then return R.STRING end
    end
    return R.IPV6
  end

  return R.STRING
end
--
--cannot issue tls cert for an IP
if not ip_addr_get_type(domain) == 'IPV4' then
ssl_certificate_domain_is_valid = true
end
--cannot issue tls cert for an empty domain
if not domain == nil then
ssl_certificate_domain_is_valid = true
end
--cannot issue tls cert for nil domain
if not domain == '' then
ssl_certificate_domain_is_valid = true
end

   return ssl_certificate_domain_is_valid
  end)

    auto_ssl:set("storage_adapter", "resty.auto-ssl.storage_adapters.redis")
    auto_ssl:set("redis", {
    host = "workstation-redis-cluster-001.xg2iur.0001.euw2.cache.amazonaws.com"
--socket = "/tmp/redis.sock"
    })

auto_ssl:set("allow_domain", function (domain)
	return true
end)

auto_ssl:set("dir", "/tmp")
auto_ssl:init()


