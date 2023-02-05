local dap = require("dap")

require("mason-nvim-dap").setup({
  ensure_installed = { "delve" },
})

--require("mason-nvim-dap").setup_handlers({
--  function(source_name)
-- all sources with no handler get passed here

-- Keep original functionality of `automatic_setup = true`
--    require("mason-nvim-dap.automatic_setup")(source_name)
--  end,
--  delve = function()
--    require("dap-go").setup()
--  end,
--})
--

require("dap-go").setup()

local dapui = require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set("n", "<F5>", require("dap").continue)
vim.keymap.set("n", "<F10>", require("dap").step_over)
vim.keymap.set("n", "<F11>", require("dap").step_into)
vim.keymap.set("n", "<F12>", require("dap").step_out)
vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
