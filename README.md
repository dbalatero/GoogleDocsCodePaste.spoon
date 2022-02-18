# 🍯 GoogleDocsCodePaste.spoon

This plugin lets you paste a code snippet from your macOS clipboard to Google Docs. The snippet will be pasted as a 2x1 table with line numbers and syntax highlighting.

<img width="709" alt="image" src="https://user-images.githubusercontent.com/59429/154708376-b686c02e-d70b-41d3-8699-8bf26dcb6f65.png" />

## Usage

1. Copy a block of code into your clipboard.
1. Switch to your Google Doc.
1. Hit the paste `hotkey` you'll bind in the **Installation** section.
1. Select the language from the popup chooser.
1. It will paste a code block into your doc!

## Installation

**Pre-requisite:** Ensure you have [Hammerspoon](https://www.hammerspoon.org) installed.

Clone the repo:

```
mkdir -p ~/.hammerspoon/Spoons
git clone git@github.com:dbalatero/GoogleDocsCodePaste.spoon.git \
  ~/.hammerspoon/Spoons/GoogleDocsCodePaste.spoon
```

Run the install script to ensure you have all the right dependencies:

```
~/.hammerspoon/Spoons/GoogleDocsCodePaste.spoon/bin/install
```

Finally, add a snippet of code to your `~/.hammerspoon/init.lua`:

```lua
local docs = require('GoogleDocsCodePaste')

-- Bind this to whatever mods + key you want:
hs.hotkey.bind({'cmd', 'ctrl', 'alt'}, 'v', docs.pasteToGoogleDocs)
```

## Contributing

Please open issues on the repo to quickly discuss any ideas you have, then create a PR and send it to dbalatero.
