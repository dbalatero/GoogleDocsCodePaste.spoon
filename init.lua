-- Setup load paths.
local function scriptPath()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)")
end

local rootDir = scriptPath()
package.path = rootDir .. "lib/?.lua;" .. package.path

-----------------------------------------

local chooseLanguage = require('GoogleDocsCodePaste.language_chooser')
local utils = require('GoogleDocsCodePaste.utils')
local template = require('GoogleDocsCodePaste.rtf_template')

local function firePaste(language)
  -- Get code from clipboard
  local code = utils.trim(hs.pasteboard.getContents())

  -- Convert to styled text
  local rtf = template.generateRtf(code, language)
  local newClipboardContents = hs.styledtext.getStyledTextFromData(rtf, 'rtf')

  local changeCount = hs.pasteboard.changeCount()

  clipboardHasUpdated = function()
    return changeCount ~= hs.pasteboard.changeCount()
  end

  hs.pasteboard.writeObjects(newClipboardContents)

  hs.timer.waitUntil(
    clipboardHasUpdated,
    function()
      -- Fire a paste
      hs.eventtap.keyStroke({'cmd'}, 'v', 0)

      -- We need to wait to give a chance for the paste to finish.
      hs.timer.doAfter(1, function()
        -- Restore the clipboard
        hs.pasteboard.setContents(code)
      end)
    end,
    0.1
  )
end

local function pasteToGoogleDocs()
  chooseLanguage(firePaste)
end

return {
  pasteToGoogleDocs = pasteToGoogleDocs,
}
