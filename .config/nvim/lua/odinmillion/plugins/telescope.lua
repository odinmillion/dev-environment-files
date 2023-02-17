-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, 'telescope')
if not telescope_setup then
  return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, 'telescope.actions')
if not actions_setup then
  return
end

-- set current index in status text
local pickers = require('telescope.pickers')

local get_status_text = function(self)
  local selected = #(self:get_multi_selection())
  local num_results = (self.stats.processed or 0) - (self.stats.filtered or 0)
  local current_index = num_results == 0 and 0 or self:get_index((self.stats.jy_current_row or 0))
  if selected ~= 0 then
    return string.format('(Selected: %s) %s / %s', selected, current_index, num_results)
  end
  return string.format('%s / %s', current_index, num_results)
end

local original_update_prefix = pickers._Picker.update_prefix

pickers._Picker.update_prefix = function(self, entry, row)
  self.stats.jy_current_row = row
  self:get_status_updater(self.prompt_win, self.prompt_bufnr)()
  return original_update_prefix(self, entry, row)
end

local original_reset_track = pickers._Picker._reset_track

pickers._Picker._reset_track = function(self)
  self.stats.jy_current_row = 0
  original_reset_track(self)
end

-- configure telescope
telescope.setup({
  -- configure custom mappings
  defaults = {
    scroll_strategy = 'limit',
    layout_strategy = 'vertical',
    layout_config = { height = 0.95 },
    dynamic_preview_title = true,
    wrap_results = false,
    get_status_text = get_status_text,
    mappings = {
      i = {
        ['<C-k>'] = actions.move_selection_previous, -- move to prev result
        ['<C-j>'] = actions.move_selection_next, -- move to next result
        --[[        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist ]]
        ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
      },
    },
  },
})

telescope.load_extension('fzf')
