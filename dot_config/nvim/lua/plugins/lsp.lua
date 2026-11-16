return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          -- A code repository can contain thousands of unrelated Markdown files.
          -- Use single-file mode unless a Markdown workspace is explicitly marked.
          root_markers = { ".marksman.toml" },
          workspace_required = false,
        },
      },
    },
  },
}
