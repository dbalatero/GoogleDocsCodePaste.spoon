local header = [[
{\rtf1\ansi\ansicpg1252\cocoartf2636
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 RobotoMono-Regular;}
{\colortbl;\red255\green255\blue255;\red33\green118\blue199;\red180\green187\blue194;\red251\green251\blue251;
\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c14902\c54510\c82353;\cssrgb\c75686\c78039\c80392;\cssrgb\c98824\c98824\c98824;
\cssrgb\c0\c0\c0;}
\margl1440\margr1440\vieww20180\viewh8400\viewkind0
\deftab720

\itap1\trowd \taflags1 \trgaph108\trleft-108 \trbrdrt\brdrnil \trbrdrl\brdrnil \trbrdrt\brdrnil \trbrdrr\brdrnil
\clvertalt \clshdrawnil \clwWidth640\clftsWidth3 \clbrdrt\brdrs\brdrw20\brdrcf3 \clbrdrl\brdrs\brdrw20\brdrcf3 \clbrdrb\brdrs\brdrw20\brdrcf3 \clbrdrr\brdrs\brdrw20\brdrcf4 \clpadt133 \clpadl133 \clpadb133 \clpadr133 \gaph\cellx4320
\clvertalt \clcbpat4 \clwWidth19420\clftsWidth3 \clbrdrt\brdrs\brdrw20\brdrcf3 \clbrdrl\brdrs\brdrw20\brdrcf4 \clbrdrb\brdrs\brdrw20\brdrcf3 \clbrdrr\brdrs\brdrw20\brdrcf3 \clpadt133 \clpadl133 \clpadb133 \clpadr133 \gaph\cellx10640
\pard\intbl\itap1\pardeftab720\qr\partightenfactor0

\f0\fs32 \cf2 \expnd0\expndtw0\kerning0

]]

local middle = [[
\cell
\pard\intbl\itap1\pardeftab720\partightenfactor0

]]

local footer = [[

\cell \lastrow\row
}
]]

local function generateLineNumbers(code)
  local lines = hs.fnutils.split(code, "\n", nil, true)
  local count = #lines

  local numbers = {
    -- line 1
    [[\outl0\strokewidth0 \strokec2 1
\f0\fs24 \cf0 \strokec5 \]]
  }

  for i=2,count do
    local value = tostring(i)

    if i < count then
      value = value .. "\\par"
    end

    table.insert(
      numbers,
      [[\f0\fs32 \cf2 \strokec2 ]] .. value
    )
  end

  return table.concat(numbers, "\n\n")
end

local function generateHighlightedCode(code, language)
  -- Write to tmp file
  local file = io.open("/tmp/code.txt", "w+")
  io.output(file)
  io.write(code)
  io.close(file)

  local codeRtf = hs.execute("cat /tmp/code.txt | /usr/local/bin/highlight --no-trailing-nl -O rtf --font 'Roboto Mono' --font-size 16 --syntax " .. language .. " -s 'solarized-light'")
  hs.execute("rm /tmp/code.txt")

  return codeRtf
end

local function generateRtf(code, language)
  return header ..
    generateLineNumbers(code) ..
    middle ..
    generateHighlightedCode(code, language) ..
    footer
end

local function generateLineNumbersPre(code)
  local lines = hs.fnutils.split(code, "\n", nil, true)
  local count = #lines

  local numbers = {}

  for i=1,count do
    local value = tostring(i)
    table.insert(numbers, value)
  end

  return table.concat(numbers, "\n")
end


local function generateHtml(code, language)
  -- Write to tmp file
  local file = io.open("/tmp/code.txt", "w+")
  io.output(file)
  io.write(code)
  io.close(file)

  local codeHtml = hs.execute("cat /tmp/code.txt | /usr/local/bin/highlight -f --no-trailing-nl -O html --inline-css --font 'Roboto Mono' --font-size 10 --syntax " .. language .. " -s 'github'")
  hs.execute("rm /tmp/code.txt")

  local html = [[
<table cellspacing="0" style="border: 1px solid #c1c7cd;">
  <tr>
    <td valign="top" style="background-color:#fff5ee; padding-left: 4px; border: 0; text-align: right;">
<pre style="color:#657b83; font-size:10pt; font-family:'Roboto Mono',monospace;white-space: pre-wrap;">]]

  html = html .. generateLineNumbersPre(code)
  html = html .. [[
</pre>
    </td>
    <td valign="top" style="background-color:#fff5ee; padding-left: 24px;">
<pre style="color:#000000; background-color:#fff5ee; font-size:10pt; font-family:'Roboto Mono',monospace;white-space: pre-wrap;">]]

  html = html .. codeHtml

  html = html .. [[</pre>
    </td>
  </tr>
</table>
  ]]

  p(html)

  return html
end

return {
  generateRtf = generateRtf,
  generateHtml = generateHtml,
}
