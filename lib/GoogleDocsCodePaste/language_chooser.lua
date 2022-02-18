local function chooseLanguage(onLanguage)
  local onChoose = function(choice)
    if not choice then
      return
    end

    onLanguage(choice.language)
  end

  local chooser = hs.chooser.new(onChoose)
  chooser:width(20)
  chooser:placeholderText("Choose a format language to paste as")

  chooser:choices({
    {
      text = "Bash",
      language = "bash",
    },
    {
      text = "Java",
      language = "java",
    },
    {
      text = "JavaScript",
      language = "js",
    },
    {
      text = "JSON",
      language = "json",
    },
    {
      text = "JSX",
      language = "jsx",
    },
    {
      text = "Lua",
      language = "lua",
    },
    {
      text = "Plain text (txt)",
      language = "txt",
    },
    {
      text = "Python",
      language = "python",
    },
    {
      text = "Ruby",
      language = "ruby",
    },
    {
      text = "Scala",
      language = "scala",
    },
    {
      text = "TSX",
      language = "tsx",
    },
    {
      text = "TypeScript",
      language = "tsx",
    },
    {
      text = "YAML",
      language = "yaml",
    },
  })

  chooser:show()
end

return chooseLanguage
