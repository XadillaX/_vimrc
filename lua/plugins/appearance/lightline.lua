-- cspell:disable
vim.g.vim_lightline_artify = 2

vim.g['lightline#asyncrun#indicator_none'] = ''
vim.g['lightline#asyncrun#indicator_run'] = 'Running...'

local lightline_config = {
  colorscheme = 'sonokai',
  separator = { left = '', right = '' },
  subseparator = { left = '', right = '' },
  tabline_separator = { left = '', right = '' },
  tabline_subseparator = { left = '', right = '' },
  tab_component_function = {
    artify_activetabnum = 'lightline#custom#artify_active_tabnum',
    artify_inactivetabnum = 'lightline#custom#artify_inactive_tabnum',
    artify_filename = 'lightline#custom#artify_tabname',
    tabnum = 'lightline#custom#tabnum',
    filename = 'lightline#tab#filename',
    modified = 'lightline#tab#modified',
    readonly = 'lightline#tab#readonly',
  },
  component = {
    git_buffer = '%{get(b:, "coc_git_status", "")}',
    git_global = '%{lightline#custom#git_global()}',
    artify_mode = '%{lightline#custom#artify_mode()}',
    artify_lineinfo = '%2{lightline#custom#artify_line_percent()} %3{lightline#custom#artify_line_num()}:%-2{lightline#custom#artify_column_num()}',
    vim_logo = '',
    mode = '%{lightline#mode()}',
    filename = '%t',
    fileformat = '%{&fenc!=#""?&fenc:&enc}[%{&ff}]',
    modified = '%M',
    paste = '%{&paste?"PASTE":""}',
    readonly = '%R',
    lineinfo = '%2p%% %3l:%-2v',
  },
  component_function = {
    devicons_filetype = 'lightline#custom#devicons',
    coc_status = 'lightline#custom#coc_status',
  },
  component_expand = {
    linter_warnings = 'lightline#custom#coc_diagnostic_warning',
    linter_errors = 'lightline#custom#coc_diagnostic_error',
    linter_ok = 'lightline#custom#coc_diagnostic_ok',
    asyncrun_status = 'lightline#asyncrun#status',
  },
  component_type = {
    linter_warnings = 'warning',
    linter_errors = 'error',
  },
}

if vim.g.vim_lightline_artify == 0 then
  lightline_config.active = {
    left = {
      { 'mode', 'paste' },
      { 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' },
    },
    right = {
      { 'lineinfo' },
      { 'linter_errors', 'linter_warnings', 'linter_ok' },
      { 'asyncrun_status', 'coc_status' },
    },
  }
  lightline_config.inactive = {
    left = { { 'filename', 'modified', 'fileformat', 'devicons_filetype' } },
    right = { { 'lineinfo' } },
  }
  lightline_config.tabline = {
    left = { { 'vim_logo', 'tabs' } },
    right = { { 'git_global' }, { 'git_buffer' } },
  }
  lightline_config.tab = {
    active = { 'tabnum', 'filename', 'modified' },
    inactive = { 'tabnum', 'filename', 'modified' },
  }
else
  lightline_config.active = {
    left = {
      { 'artify_mode', 'paste' },
      { 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' },
    },
    right = {
      { 'artify_lineinfo' },
      { 'linter_errors', 'linter_warnings', 'linter_ok' },
      { 'asyncrun_status', 'coc_status' },
    },
  }
  lightline_config.inactive = {
    left = { { 'filename', 'modified', 'fileformat', 'devicons_filetype' } },
    right = { { 'artify_lineinfo' } },
  }
  lightline_config.tabline = {
    left = { { 'vim_logo', 'tabs' } },
    right = { { 'git_global' }, { 'git_buffer' } },
  }
  lightline_config.tab = {
    active = { 'artify_activetabnum', 'artify_filename', 'modified' },
    inactive = { 'artify_inactivetabnum', 'filename', 'modified' },
  }
end

vim.g.lightline = lightline_config
