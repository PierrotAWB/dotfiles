local function short_branch()
    local branch_name = require 'lualine.components.branch'.branch()
    if #branch_name > 10 then
        return branch_name:sub(1, 7) .. '...' -- Truncate to 10 characters with "..." to indicate truncation
    else
        return branch_name
    end
end

require('lualine').setup {
    options = {
        disabled_filetypes = { 'packer', 'NvimTree', 'NvimTree_1' },
    },
    sections = {
        lualine_b = {
            'branch',
            'diff',
        },
        lualine_c = {
            {
                'filename',
                file_status = true,        -- Displays file status (readonly status, modified status)
                newfile_status = false,    -- Display new file status (new file means no write after created)
                path = 1,                  -- 1: Relative path
                shorting_target = 40,      -- Shortens path to leave 40 spaces in the window
                symbols = {
                    modified = '[+]',      -- Text to show when the file is modified.
                    readonly = '[RO]',     -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                    newfile = '[New]',     -- Text to show for newly created file before first write
                }
            }
        },
        lualine_x = {}
    }
}
