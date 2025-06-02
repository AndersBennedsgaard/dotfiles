require("codecompanion").setup({
  display = {
    action_palette = {
      provider = "telescope",
    },
  },
  strategies = {
    chat = {
      adapter = "devstral",
    },
    inline = {
      adapter = "devstral",
    },
  },
  adapters = {
    devstral = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "devstral",
        schema = {
          model = {
            default = "devstral:latest",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
    gemma3 = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "gemma3",
        schema = {
          model = {
            default = "gemma3:27b",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
    codegemma = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "codegemma",
        schema = {
          model = {
            default = "codegemma:7b",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
    deepseekCoder = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "deepseekCoder", -- Give this adapter a different name to differentiate it from the default ollama adapter
        schema = {
          model = {
            default = "deepseek-coder-v2:latest",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
    codellama = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "codellama",
        schema = {
          model = {
            default = "codellama:7b",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
  },
})
