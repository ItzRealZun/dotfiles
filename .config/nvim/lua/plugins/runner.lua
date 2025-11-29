return {
    "CRAG666/code_runner.nvim",
    lazy = false,
    keys = {
        {
            "<leader>r",
            ":RunCode<CR>",
            desc = "Run Code",
        },
    },
    opts = {
        filetype = {
            cpp = {
                "cd $dir &&",
                "mkdir -p temp &&",
                'clang++ "$dir/$fileName" -o "$dir/temp/$fileNameWithoutExt" -std=c++23 &&',
                '"$dir/temp/$fileNameWithoutExt"',
            },
        },
    },
}
