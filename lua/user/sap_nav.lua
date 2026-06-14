-- SAP study guide question navigator
-- Usage: cursor on Q38 → <leader>q  (or :SAPQuestion 38)
-- In popup: n/N = next/prev question, q/Esc = close

local M = {}

local DUMP_DIR = "/home/jenny/Dumps/Solutions-Architect-Professional"
local cache = nil

-- ── data ──────────────────────────────────────────────────────────────────────

local function load_questions()
  if cache then return cache end
  local qs = {}
  local files = vim.fn.glob(DUMP_DIR .. "/precise_qa_data_*.json", false, true)
  for _, path in ipairs(files) do
    local f = io.open(path, "r")
    if f then
      local ok, data = pcall(vim.json.decode, f:read("*a"))
      f:close()
      if ok and type(data) == "table" then
        for _, q in ipairs(data) do
          local id = q.question_id
          if id and (not qs[id] or
            #(q.user_discussions or {}) > #(qs[id].user_discussions or {})) then
            qs[id] = q
          end
        end
      end
    end
  end
  cache = qs
  return qs
end

-- ── helpers ───────────────────────────────────────────────────────────────────

-- Split text into lines of at most `width` chars (no indentation applied).
local function wrap(text, width)
  local lines = {}
  text = text:gsub("%s+", " "):match("^%s*(.-)%s*$")
  while #text > width do
    local cut = width
    while cut > 1 and text:sub(cut, cut) ~= " " do cut = cut - 1 end
    if cut == 1 then cut = width end
    table.insert(lines, text:sub(1, cut):match("^%s*(.-)%s*$"))
    text = text:sub(cut + 1)
  end
  if text ~= "" then table.insert(lines, text) end
  return lines
end

-- Push wrapped lines with distinct first-line and continuation prefixes.
local function push_wrapped(push_fn, text, width, first_prefix, cont_prefix)
  cont_prefix = cont_prefix or string.rep(" ", #first_prefix)
  local parts = wrap(text, width - #first_prefix)
  for i, part in ipairs(parts) do
    push_fn((i == 1 and first_prefix or cont_prefix) .. part)
  end
end

local function qid_under_cursor()
  -- try cWORD first (handles "Q38," "Q38.")
  local word = vim.fn.expand("<cWORD>")
  local n = word:match("Q(%d+)")
  if n then return tonumber(n) end
  -- fall back: scan current line up to cursor column
  local line = vim.api.nvim_get_current_line()
  local col  = vim.fn.col(".") -- 1-based
  local n2   = line:sub(1, col):match("Q(%d+)$")
  return n2 and tonumber(n2) or nil
end

-- ── popup ─────────────────────────────────────────────────────────────────────

local function open_popup(qid)
  local qs = load_questions()
  local q  = qs[qid]
  if not q then
    vim.notify("Q" .. qid .. " not found in dump", vim.log.levels.WARN)
    return
  end

  local W = math.min(80, vim.o.columns - 4)
  local inner = W - 4   -- text area after padding

  local lines = {}
  local function push(s) table.insert(lines, s) end
  local function blank()  push("") end

  -- header
  blank()
  push_wrapped(push, q.question_text or "", inner, "  ")
  blank()

  -- options
  push("  Options:")
  for _, opt in ipairs(q.options or {}) do
    local label = opt:match("^(%u%.) ?") or ""   -- "A." or "A. "
    local body  = opt:sub(#label + 1):match("^%s*(.-)%s*$")
    local fp    = "  " .. label .. " "            -- "  A. "
    local cp    = string.rep(" ", #fp)            -- "      "
    push_wrapped(push, body, inner, fp, cp)
  end
  blank()

  -- answer
  local ans = q.official_answer and q.official_answer.correct_options or {}
  push("  ✓  Answer: " .. table.concat(ans, ", "))
  blank()

  -- best explanation
  local best, best_pts = "", -1
  for _, d in ipairs(q.user_discussions or {}) do
    local pts = tonumber((d.points or "0"):match("(%d+)") or 0) or 0
    if pts > best_pts then best_pts, best = pts, d.content or "" end
  end
  if best ~= "" then
    push("  Explanation:")
    best = best:gsub("https?://%S+", ""):gsub("%s+", " "):match("^%s*(.-)%s*$")
    best = best:sub(1, 500)
    push_wrapped(push, best, inner, "  ")
    blank()
  end

  push("  [q / Esc] close    [n] next    [N] prev")
  blank()

  -- open window
  local height = math.min(#lines, math.floor(vim.o.lines * 0.75))
  local row    = math.floor((vim.o.lines  - height) / 2)
  local col    = math.floor((vim.o.columns - W)     / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype   = "markdown"

  local win = vim.api.nvim_open_win(buf, true, {
    relative   = "editor",
    width      = W,
    height     = height,
    row        = row,
    col        = col,
    style      = "minimal",
    border     = "rounded",
    title      = " Q" .. qid .. " / 529 ",
    title_pos  = "center",
  })
  vim.wo[win].wrap      = true
  vim.wo[win].cursorline = true

  -- highlight answer line
  for i, l in ipairs(lines) do
    if l:match("✓") then
      vim.api.nvim_buf_add_highlight(buf, -1, "DiagnosticOk", i - 1, 0, -1)
    end
  end

  local function close() vim.api.nvim_win_close(win, true) end
  local km = { buffer = buf, noremap = true, silent = true }
  vim.keymap.set("n", "q",   close, km)
  vim.keymap.set("n", "<Esc>", close, km)
  vim.keymap.set("n", "n", function() close(); open_popup(qid + 1) end, km)
  vim.keymap.set("n", "N", function()
    if qid > 1 then close(); open_popup(qid - 1) end
  end, km)
end

-- ── telescope picker (optional) ───────────────────────────────────────────────

local function telescope_pick()
  local ok, telescope = pcall(require, "telescope.builtin")
  if not ok then
    vim.ui.input({ prompt = "Question number: " }, function(s)
      local n = tonumber(s)
      if n then open_popup(n) end
    end)
    return
  end

  local pickers     = require("telescope.pickers")
  local finders     = require("telescope.finders")
  local conf        = require("telescope.config").values
  local actions     = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local qs = load_questions()
  local entries = {}
  for id, q in pairs(qs) do
    local ans = q.official_answer and q.official_answer.correct_options or {}
    table.insert(entries, {
      id    = id,
      display = string.format("Q%-4d  [%s]  %s",
        id,
        table.concat(ans, ","),
        (q.question_text or ""):sub(1, 70)
      ),
    })
  end
  table.sort(entries, function(a, b) return a.id < b.id end)

  pickers.new({}, {
    prompt_title = "SAP Questions",
    finder = finders.new_table {
      results = entries,
      entry_maker = function(e)
        return { value = e, display = e.display, ordinal = e.display }
      end,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_buf, map_)
      actions.select_default:replace(function()
        actions.close(prompt_buf)
        local sel = action_state.get_selected_entry()
        if sel then open_popup(sel.value.id) end
      end)
      return true
    end,
  }):find()
end

-- ── public API ────────────────────────────────────────────────────────────────

function M.open(qid)
  if qid then
    open_popup(qid)
  else
    local n = qid_under_cursor()
    if n then
      open_popup(n)
    else
      vim.ui.input({ prompt = "Question number: " }, function(s)
        local num = tonumber(s)
        if num then open_popup(num) end
      end)
    end
  end
end

function M.pick() telescope_pick() end

function M.setup(opts)
  opts = opts or {}

  vim.api.nvim_create_user_command("SAPQuestion", function(a)
    M.open(tonumber(a.args) or nil)
  end, { nargs = "?", desc = "Show SAP question by number" })

  vim.api.nvim_create_user_command("SAPPick", function()
    M.pick()
  end, { desc = "Fuzzy-search SAP questions" })

  local key  = opts.key  or "<leader>q"
  local pick = opts.pick or "<leader>Q"

  vim.keymap.set("n", key, function() M.open() end,
    { desc = "SAP: show question under cursor", silent = true })
  vim.keymap.set("n", pick, function() M.pick() end,
    { desc = "SAP: fuzzy-search questions", silent = true })

  if opts.preload then
    vim.defer_fn(function()
      load_questions()
      vim.notify("SAP: " .. vim.tbl_count(cache) .. " questions loaded", vim.log.levels.INFO)
    end, 200)
  end
end

return M
