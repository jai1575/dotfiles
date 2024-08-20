local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local align = { provider = "%=", hl = { bg = "none" }}
local space = { provider = " ", hl = { bg = "#0F1232" }}
local spacer = { provider = "|", hl = { fg = "000000", bg = "#0F1232" }}
local diamond = { provider = "󰣏", hl = { fg = "#000000", bg = "#0F1232" }}
local threedot = { provider = "󰇙", hl = { fg = "#000000", bg = "#0F1232" }}
local heartt = { provider = "", hl = { fg = "#000000", bg = "#0F1232" }}
local sparkle = { provider = "", hl = { fg = "#000000", bg = "#0F1232" }}
local bash = { provider = "", hl = { fg = "purple", bg = "#0F1232" } }
local terminal = { provider = "T ", hl = { fg = "red", bg = "#0F1232" } }


local colors = {
  bright_bg = utils.get_highlight("Folded").bg,
  bright_fg = utils.get_highlight("Folded").fg,
  red = utils.get_highlight("DiagnosticError").fg,
  dark_red = utils.get_highlight("DiffDelete").bg,
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("NonText").fg,
  orange = utils.get_highlight("Constant").fg,
  purple = utils.get_highlight("Statement").fg,
  cyan = utils.get_highlight("Special").bg,
  diag_warn = utils.get_highlight("DiagnosticWarn").fg,
  diag_error = utils.get_highlight("DiagnosticError").fg,
  diag_hint = utils.get_highlight("DiagnosticHint").fg,
  diag_info = utils.get_highlight("DiagnosticInfo").fg,
  git_del = utils.get_highlight("diffDeleted").fg,
  git_add = utils.get_highlight("diffAdded").fg,
  git_change = utils.get_highlight("diffChanged").fg,
}

local vimode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,

  static = {
    mode_names = {
      n = "N",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "V",
      vs = "Vs",
      V = "V_",
      Vs = "Vs",
      ["\22"] = "^V",
      ["\22s"] = "^V",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "I",
      ic = "Ic",
      ix = "Ix",
      R = "R",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "C",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
    mode_colors = {
      n = "red" ,
      i = "green",
      v = "cyan",
      V =  "cyan",
      ["\22"] =  "cyan",
      c =  "orange",
      s =  "purple",
      S =  "purple",
      ["\19"] =  "purple",
      R =  "orange",
      r =  "orange",
      ["!"] =  "red",
      t =  "red",
    }
  },

  utils.surround({"",""}, "#0F1232", {
    provider = function(self) 
      return "  -%2("..self.mode_names[self.mode].."%) "
    end,
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = self.mode_colors[mode], bold = true, bg = "#0F1232", }
    end,
  }),

  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
}

local fileinfo = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local fileicon = {
  utils.surround({"",""}, "#0F1232", {
    init = function(self)
      local filename = self.filename
      local extension = vim.fn.fnamemodify(filename, ":e")
      self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    
    provider = function(self)
      if vim.api.nvim_buf_get_name(0) ~= "" then
      return self.icon and (" " .. self.icon) end
    end,

    hl = function(self)
      return { fg = self.icon_color, bg = "#0F1232" }
    end,
  }),
}

local filename = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":.")
    if filename == "" then return " " end
    if string.match(filename, "NvimTree") then return " " end
    --if not conditions.width_percent_below(#file_name, 0.25) then
    --  filename = vim.fn.pathshorten(filename) end
    return filename .. " "
  end,
  hl = { fg = utils.get_highlight("Directory").fg, bg = "#0F1232" },
}

local fileflag = {
  utils.surround({"",""}, "#0F1232", {
    {
      condition = function()
        return vim.bo.modified
      end,
      provider = " ",
      hl = { fg = "purple" },
    },
    {
      condition = function()
        return not vim.bo.modifiable or vim.bo.readonly
      end,
      provider = "󰈡 ",
      hl = { fg = "orange" }, 
    },
  }),
}

local filenmod = {
  hl = function()
    if vim.bo.modified then
      return { fg = "cyan", bold = true, force = true }
    end
  end,
}

local filecode = {
  provider = function(self)
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
    return enc ~= "utf-8" and " " .. enc .. " "
  end,
  hl = { fg = "cyan", bg = "#0F1232" }
}

local fileformat = {
  provider = function()
    local fmt = vim.bo.fileformat
    if fmt ~= "unix" then return " " .. fmt .. " " end
  end,
  hl = { fg = "cyan", bg = "#0F1232" }
}

local ruler = {
  provider = " %L:%c%o ",
  hl = { fg = utils.get_highlight("Directory").fg, bg = "#0F1232" }
}

local simpletime = {
  provider = function()
    local clkcss = { "󱐿","󱑀","󱑁","󱑂","󱑃","󱑄","󱑅","󱑆","󱑇","󱑈","󱑉","󱑊" }
    return " " .. clkcss[tonumber(os.date("%I"))] .. os.date(" %p") .. " "
  end,
  hl = { fg = utils.get_highlight("Directory").fg, bg = "#0F1232" }
}

local currtime1 = {
  provider = function()
    return os.date(" %a ") .. os.date("*t").day .. " "
  end,
  hl = { fg = "purple", bg = "#0F1232"}
}
local currtime2 = {
  provider = function()
    local time_clocks = { "󱐿","󱑀","󱑁","󱑂","󱑃","󱑄","󱑅","󱑆","󱑇","󱑈","󱑉","󱑊" }
    return " " .. time_clocks[tonumber(os.date("%I"))] .. os.date(" %p") .. "  "
  end,
  hl = { fg = "red", bg = "#0F1232"}
}

local tab_bufnr = {
  provider = function(self)
    return " " .. tostring(self.bufnr)
  end,
  hl = { fg = "cyan", bg = "#0F1232" },
}

local tab_filename = {
  provider = function(self)
    local filename = self.filename
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
    return " " .. filename
  end,
  hl = function(self)
    return { bold = self.is_active or self.is_visible, italic = true }
  end,
}

local tab_fileflags = {
  {
    condition = function(self)
      return vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) and not vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
    end,

    provider = "  ",

    hl = { fg = "green", bg = "#0F1232" }
  },
  {
    condition = function(self)
      return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr }) or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
    end,

    provider = function(self)
      if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
        return " "
      else
        return " 󰈡"
      end
    end,

    hl = { fg = "orange" },
  },
  {
    condition = function(self)
      return vim.api.nvim_get_option_value("readonly", { buf = self.bufnr }) and vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,

    provider = function(self)
      return "  "
    end,

    hl = { fg = "green", bg = "#0F1232" }
  }
}

local tab_active = {
  condition = function(self)
    return self.is_active or self.is_visible
  end,
  provider = "",
}

local tab_fileinfo = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,

  on_click = {
    callback = function(_, minwid, _, button)
      if button == "m" then
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid { force = false })
        end)
      else
	vim.api.nvim_win_set_buf(0, minwid)
      end
    end,
minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_buffer_callback",
  },
  tab_bufnr,
  fileicon,
  --tab_filename,
  tab_fileflags,
}

local tab_closebtn = {
  condition = function(self)
    return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
  end,
  { provider = "  " },
  hl = { fg = "red", bg = "#0F1232" },
  
  on_click = {
    callback = function(_, minwid)
      vim.schedule(function()
        vim.api.nvim_buf_delete(minwid, { force = false })
	vim.cmd.redrawtabline()
      end)
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_close_buffer_callback",
  },
}

local get_bufs = function()
  return vim.tbl_filter(function(bufnr)
    return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
  end, vim.api.nvim_list_bufs())
end

local buflist_cache = {}

vim.api.nvim_create_autocmd({ "VimEnter","UIEnter","BufAdd","BufDelete" }, {
  callback = function()
    vim.schedule(function()
      local buffers = get_bufs()
      for i, v in ipairs(buffers) do
        buflist_cache[i] = v end
      for i = #buffers + 1, #buflist_cache do
        buflist_cache[i] = nil end

      if #buflist_cache > 1 then
        vim.o.showtabline = 2
      elseif vim.o.showtabline ~= 1 then
	vim.o.showtabline = 1 end
    end)
  end,
})

local tab_bufblock = utils.surround({""," "}, "#0F1232", { tab_fileinfo, tab_closebtn, tab_active })

local buflist = utils.make_buflist(
  tab_bufblock,
  { provider = "", hl = { fg = "grey", bg = "purple" } },
  { provider = "", hl = { fg = "grey", bg = "purple"} },

  function()
    return buflist_cache end,
  false
)

local bufferline = { buflist, align, utils.surround({" ",""}, "#0F1232", {currtime1, sparkle, currtime2 }), }

fileinfo = utils.insert(
  fileinfo,
  fileicon,
  space,
  utils.insert(filenmod, filename),
  fileformat,
  filecode,
  fileflag,
  { provider = "%<" }
)

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    utils.on_colorscheme(setup_colors)
  end,
  group = "Heirline"
})

local inactive_statusline = { 
  condition = conditions.is_not_active,
  space, fileinfo, align
}
local active_statusline = {
  condition = conditions.is_active,
  vimode, sparkle, fileinfo, align, utils.surround({"",""}, "#0F1232", { ruler, sparkle, simpletime })
}

local norm_statusline = {
  condition = function()
    return not conditions.buffer_matches({bufname = {"NvimTree"}}) and not conditions.buffer_matches({buftype = {"terminal"}})
  end,
  inactive_statusline,
  active_statusline
}

local active_tree_statusline = {
  condition = conditions.is_active,
  space, fileinfo, align, utils.surround({"",""}, "#0F1232", {  simpletime })
}
local inactive_tree_statusline = {
  condition = conditions.is_not_active,
  space, fileinfo, align,
}
local tree_statusline = {
  condition = function()
    return conditions.buffer_matches({bufname = {"NvimTree"}})
  end,
  inactive_tree_statusline,
  active_tree_statusline,
}

local terminal_statusline = {
  condition = function()
    return conditions.buffer_matches({buftype = {"terminal"}})
  end,
  utils.surround({"", ""}, "#0F1232", { space, terminal, heartt, space, bash, space }), align, utils.surround({"",""}, "#0F1232", { ruler, heartt, simpletime })
}

heirline_statusline = {
  norm_statusline,
  tree_statusline,
  terminal_statusline,
}
--heirline_winbar = {}
--heirline-statuscolumn = {}

require("heirline").setup({
  statusline = heirline_statusline,
  --winbar = {},
  tabline = bufferline,
  --statuscolumn = {},
  opts = {
    colors = colors,
  }
})
