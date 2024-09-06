local M = {}

function M.setup()
  local c = require("conform")
  c.setup({

    formatters_by_ft = {
      bash = { "shfmt" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      json = { "jq" },
      jsonnet = { "jsonnetfmt" },
      lua = { "stylua" },
      python = { "black" },
      scss = { "prettier" },
      sh = { "shfmt" },
      terraform = { "terraform_fmt" },
      typescript = { "prettier" },
      yaml = { "yamlfix" },
      zsh = { "shfmt" },
    },

    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return {}
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
  })

  -- The best options for shfmt
  c.formatters.shfmt = {
    prepend_args = { "-i", "4" },
  }

  c.formatters.yamlfix = {
    env = {
      YAMLFIX_WHITELINES = "1",
      YAMLFIX_COMMENTS_WHITELINES = "1",
      YAMLFIX_LINE_LENGTH = "200",
    },
  }

  c.formatters.jsonnetfmt = {
    prepend_args = { "-n", "2" },
  }

  -- NOTE: Okay, I understand now why yamlfix is a better option
  -- -- The best options for yamlfmt
  -- -- https://github.com/google/yamlfmt/blob/main/docs/config-file.md#basic-formatter
  -- c.formatters.yamlfmt = {
  --   prepend_args = {
  --     "--formatter",
  --     "indent=2,include_document_start=true,retain_line_breaks=true",
  --   },
  -- }

  -- When we need to override prettier for whatever reason:
  -- c.formatters.prettier = {
  --   prepend_args = { "--single-quote" },
  -- }

  -- TODO: Add a keymap for autoformat disabling (not working)
  vim.keymap.set("n", "<leader>fm", function()
    if vim.g.fmt then
      vim.cmd("FormatDisable!")
      vim.notify("Turning autoformatting off")
    else
      vim.cmd("FormatEnable")
      vim.notify("Turning autoformatting off")
    end
  end)
end

M.setup()

return M
