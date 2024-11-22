{
  programs.nixvim = {
    enable = true;
    
    colorschemes.dracula.enable = true;

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };

    keymaps = [
      {
	action = "<cmd>Telescope live_grep<CR>";
	key = "<leader>g";
      }
    ];

    # Harmless Fun

    autoCmd = [
      {
	event = [ "BufEnter" "BufWinEnter" ];
	pattern = [ "*.c" "*h" "*.cpp" "*.hpp" ];
	command = "echo 'Entering a C or C++ file'";
      }
    ];

    # Not working :(
    highlight = {
      Comment.fg = "#ff00ff";
      Comment.bg = "#000000";
      Comment.underline = true;
      Comment.bold = true;
    };

    plugins = {

    lsp = {
	  enable = true;
	  servers = {
	    
	    # C/C++
	    clangd.enable = true;

        # Nix
        nil_ls.enable = true;
	  };
	};

	lualine.enable = true;

    # Completion engine
    cmp-nvim-lsp.enable = true;
    cmp-path.enable = true;
    cmp-buffer.enable = true;
    cmp_luasnip.enable = true;

	cmp = {
	  enable = true;
	  autoEnableSources = true;
	  settings.sources = [
    	   { name = "nvim_lsp"; }
    	   { name = "path"; }
    	   { name = "buffer"; }
           { name = "luasnip"; }
  	  ];


 	 settings.mapping = {
	    "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = ''
              function(fallback)
                local luasnip = require('luasnip')
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expandable() then
                  luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end
            '';
        };      	  
	};

	# All commands available straight away
	telescope.enable = true;
	# Telescope depends
	web-devicons.enable = true;

	# $ nvim . will open oil instead of netrw
	oil.enable = true;

	# All parses included, as simple as that
	treesitter.enable = true;

        # Required above
	luasnip.enable = true;
    };
  };
}

