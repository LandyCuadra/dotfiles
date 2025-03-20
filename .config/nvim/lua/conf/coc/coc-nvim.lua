local opts = {
  noremap = true,
  silent = true,
  expr = true,
  replace_keycodes = true
}

-- Shorten function name
local keymap = vim.keymap.set

-- Autocomplete
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
keymap("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keymap("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keymap("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keymap("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)", { silent = true })
-- Use <c-space> to trigger completion
keymap("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- Use `<leader>lk` and `<leader>lj` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keymap("n", "<leader>lk", "<Plug>(coc-diagnostic-prev)", { silent = true })
keymap("n", "<leader>lj", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation
keymap("n", "gd", "<Plug>(coc-definition)", { silent = true })
keymap("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keymap("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keymap("n", "gr", "<Plug>(coc-references)", { silent = true })


-- Use K to show documentation in preview window
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

keymap("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
  group = "CocGroup",
  command = "silent call CocActionAsync('highlight')",
  desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keymap("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })


-- Formatting selected code
keymap("x", "<leader>lf", "<Plug>(coc-format)", { silent = true })
keymap("n", "<leader>lf", "<Plug>(coc-format)", { silent = true })


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
  group = "CocGroup",
  pattern = "typescript,json",
  command = "setl formatexpr=CocAction('formatSelected')",
  desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
  group = "CocGroup",
  pattern = "CocJumpPlaceholder",
  command = "call CocActionAsync('showSignatureHelp')",
  desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = { silent = true, nowait = true }
keymap("x", "<leader>la", "<Plug>(coc-codeaction-selected)", opts)
keymap("n", "<leader>la", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keymap("n", "<leader>lac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keymap("n", "<leader>las", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keymap("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keymap("n", "<leader>lre", "<Plug>(coc-codeaction-refactor)", { silent = true })
keymap("x", "<leader>lr", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keymap("n", "<leader>lr", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keymap("n", "<leader>ll", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keymap("x", "if", "<Plug>(coc-funcobj-i)", opts)
keymap("o", "if", "<Plug>(coc-funcobj-i)", opts)
keymap("x", "af", "<Plug>(coc-funcobj-a)", opts)
keymap("o", "af", "<Plug>(coc-funcobj-a)", opts)
keymap("x", "ic", "<Plug>(coc-classobj-i)", opts)
keymap("o", "ic", "<Plug>(coc-classobj-i)", opts)
keymap("x", "ac", "<Plug>(coc-classobj-a)", opts)
keymap("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true, expr = true }
keymap("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keymap("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keymap("i", "<C-f>",
  'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keymap("i", "<C-b>",
  'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keymap("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keymap("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keymap("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
keymap("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true }
-- Show all diagnostics
keymap("n", "<space>laa", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
keymap("n", "<leader>li", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
keymap("n", "<space>lc", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
keymap("n", "<space>lo", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keymap("n", "<space>cs", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
keymap("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keymap("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
keymap("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
