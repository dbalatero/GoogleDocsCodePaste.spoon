local M = {}

M.trim = function(s)
  return s:gsub("%s+$", "")
end

function M.fileExists(name)
  local f = io.open(name, "r")

  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

return M
