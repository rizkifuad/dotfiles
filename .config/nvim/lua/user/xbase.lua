local status_ok, xbase = pcall(require, "xbase")
if not status_ok then
  return
end

xbase.setup {
  -- NOTE: Defaults
  --- Log level. Set to ERROR to ignore everything
  log_level = vim.log.levels.DEBUG,
  --- Statusline provider configurations
  statusline = {
    watching = { icon = "", color = "#1abc9c" },
    device_running = { icon = "", color = "#4a6edb" },
    success = { icon = "", color = "#1abc9c" },
    failure = { icon = "", color = "#db4b4b" },
  },
  --- TODO(nvim): Limit devices platform to select from
  simctl = {
    iOS = {
      "iPhone 13 mini",
    },
  },
  --- Log buffer configurations
  log_buffer = {
    --- Whether toggling the buffer should auto focus to it?
    focus = true,
    --- Split Log buffer height
    height = 20,
    --- Vsplit Log buffer width
    width = 75,
    --- Default log buffer direction: { "horizontal", "vertical" }
    default_direction = "horizontal",
  },
  --- Mappings
  mappings = {
    --- Whether xbase mapping should be disabled.
    enable = true,
    --- Open build picker. showing targets and configuration.
    build_picker = "<leader>xb", --- set to 0 to disable
    --- Open run picker. showing targets, devices and configuration
    run_picker = "<leader>r", --- set to 0 to disable
    --- Open watch picker. showing run or build, targets, devices and configuration
    watch_picker = "<leader>xs", --- set to 0 to disable
    --- A list of all the previous pickers
    all_picker = "<leader>xef", --- set to 0 to disable
    --- horizontal toggle log buffer
    toggle_split_log_buffer = "<leader>xls",
    --- vertical toggle log buffer
    toggle_vsplit_log_buffer = "<leader>xlv",
  }
}
