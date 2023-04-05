local status_ok, gitlinker = pcall(require, "gitlinker")
if not status_ok then
  return
end

local status_ok_job, job = pcall(require,"plenary.job")
if not status_ok_job then
  return
end

gitlinker.setup {
  opts = {
    add_current_line_on_normal_mode = true,
    action_callback = function(url)
      -- default open in chrome
      local command = {command = 'open', args = {url, '-a', '/Applications/Google Chrome.app'}}
      if url:find('kata-ai', 1, true) then
        command = {command = 'open', args = {url}}
      end
      job:new(command):start()
    end,
    print_url = false,
  },
  callbacks = {
    ["gitlab.com"] = function(url_data)
      url_data.host = "gitlab.com"
      return
      require"gitlinker.hosts".get_gitlab_type_url(url_data)
    end,
  }
}


vim.cmd([[
function! GitLinker()
  lua require"gitlinker".get_buf_range_url("v")
endfunction

command GitLinker :call GitLinker()
]])
