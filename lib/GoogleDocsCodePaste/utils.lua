local M = {}

M.trim = function(s)
  return s:gsub("%s+$", "")
end

return M
