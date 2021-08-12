-- Copyright (C) Yuansheng Wang

local ngx = ngx
local ngx_say = ngx.say
local ngx_exit = ngx.exit
local ngx_header = ngx.header

local _M = {}


function _M.say(code, body)
    code = code or 200

    if not body then
        ngx_exit(code)
        return
    end

    ngx.status = code
    ngx_say(body)
    ngx_exit(code)
end


function _M.set_header(name, value)
    if ngx.headers_sent then
      error("headers have already been sent", 2)
    end


    ngx_header[name] = value
  end


return _M
