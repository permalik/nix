-- lua/plugins/jdtls.lua
return {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
        local home = os.getenv "HOME"
        local project_root = require("jdtls.setup").find_root { "pom.xml", "gradlew", ".git" }
        if project_root == nil then
            return
        end

        local workspace_dir = home
            .. "/.cache/jdtls/workspace/"
            .. vim.fn.fnamemodify(project_root, ":p:h:t")

        local config = {
            cmd = {
                "/nix/store/g1njmakcbvmy620n1zxm2v2w2vhc7d4n-jdt-language-server-1.40.0/bin/jdtls",
                "-configuration",
                home .. "/.cache/jdtls/config",
                "-data",
                workspace_dir,
            },
            root_dir = project_root,
        }

        require("jdtls").start_or_attach(config)
    end,
}

-- local function find_jdtls_path()
--     -- find /nix/store -type f -name 'jdtls' -exec realpath {} \; > asdf.txt
--     local handle = io.popen "fd -H -t f -x realpath jdtls /nix/store 2>/dev/null"
--     if not handle then
--         return nil
--     end
--
--     local result = handle:read "*a"
--     handle:close()
--
--     local path = result:gsub("^%s+", ""):gsub("%s+$", "")
--     if path ~= "" and vim.fn.filereadable(path) == 1 then
--         return vim.fn.expand(path)
--     end
--
--     return nil
-- end
--
-- local jdtls_path = find_jdtls_path()
--
-- if not jdtls_path then
--     vim.notify("Could not locate jdtls using fd in /nix/store", vim.log.levels.ERROR)
--     return
-- end
--
-- local config = {
--     cmd = { jdtls_path },
--     root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
-- }
-- require("jdtls").start_or_attach(config)
