local lockfile = require("lazy.core.config").options.lockfile
local statefile = vim.fn.stdpath("state") .. "/lazy-lock-hash"

local function read(path)
  local f = io.open(path, "rb")
  if not f then
    return nil
  end
  local s = f:read("*a")
  f:close()
  return s
end

local function lock_hash()
  local content = read(lockfile)
  return content and vim.fn.sha256(content)
end

local function save_hash()
  local h = lock_hash()
  if not h then
    return
  end
  vim.fn.mkdir(vim.fn.fnamemodify(statefile, ":h"), "p")
  local f = io.open(statefile, "w")
  if f then
    f:write(h)
    f:close()
  end
end

local function changed_plugins()
  local names = {}
  for name, plugin in pairs(require("lazy.core.config").plugins) do
    if plugin._ and plugin._.updated then
      table.insert(names, name)
    end
  end
  table.sort(names)
  return names
end

-- Sync on startup if the lockfile changed externally
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local current = lock_hash()
    if not current then
      return
    end

    local previous = read(statefile)
    if current == previous then
      return
    end

    -- First run: nothing to compare against, just record the state
    if not previous then
      save_hash()
      return
    end

    vim.notify("lazy-lock.json changed, restoring plugins...", vim.log.levels.INFO)

    local ok, err = pcall(require("lazy").restore, { wait = true, show = false })
    if not ok then
      vim.notify("Plugin restore failed: " .. tostring(err) .. "\nRun :Lazy restore manually.", vim.log.levels.ERROR)
      return -- keep old hash so it retries next startup
    end

    save_hash()

    local changed = changed_plugins()
    if #changed > 0 then
      vim.notify(
        ("Restored %d plugin(s) from lazy-lock.json:\n  %s\n\nRestart Neovim to apply the changes."):format(
          #changed,
          table.concat(changed, "\n  ")
        ),
        vim.log.levels.WARN
      )
    else
      vim.notify("Plugins already match lazy-lock.json, nothing to restart.", vim.log.levels.INFO)
    end
  end,
})

-- Don't treat lazy's own lockfile writes as external changes
vim.api.nvim_create_autocmd("User", {
  pattern = { "LazyUpdate", "LazySync", "LazyInstall", "LazyClean", "LazyRestore" },
  callback = function()
    vim.schedule(save_hash)
  end,
})
