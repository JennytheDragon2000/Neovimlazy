-- Auto-save with sudo when writing to readonly files

-- Automatically turn off readonly when opening files we can't write
vim.api.nvim_create_autocmd({"BufRead", "BufEnter"}, {
	pattern = "*",
	callback = function()
		local file = vim.fn.expand("<afile>:p")
		if file ~= "" and vim.fn.filereadable(file) == 1 and vim.fn.filewritable(file) == 0 then
			vim.opt_local.readonly = false
			vim.opt_local.modifiable = true
		end
	end,
})

-- Write with sudo using termopen for interactive password prompt
vim.cmd([[
	function! SudoWrite()
		if !filewritable(expand('%')) && filereadable(expand('%'))
			let l:original_file = expand('%:p')
			let l:tempfile = tempname()
			" Write buffer to temp file
			execute 'write! ' . l:tempfile
			" Open a terminal buffer to run sudo interactively
			let l:cmd = 'sudo cp ' . shellescape(l:tempfile) . ' ' . shellescape(l:original_file) . ' && echo "File saved successfully"'
			execute 'terminal ' . l:cmd
			" Wait for user to press key after password entry
			echo "Press Enter when done..."
			" Auto-close terminal and reload on success
			autocmd TermClose * ++once call delete(l:tempfile) | set nomodified | edit! | echo "Saved with sudo"
		else
			write
		endif
	endfunction
	
	command! W call SudoWrite()
]])

-- Map :w to check for sudo automatically
vim.cmd([[
	cnoreabbrev <expr> w getcmdtype() == ':' && getcmdpos() == 2 ? 'W' : 'w'
]])
