{ inputs, pkgs, ... }:

let
  treesitter-languages = with pkgs.vimPlugins.nvim-treesitter-parsers; [
	c cpp vue javascript html css vim lua fennel glsl diff commonlisp
	typescript markdown markdown_inline nix rust svelte
  ];
in
{
  programs.bash.bashrcExtra = ''
	export EDITOR=vim
  '';

  # Prefer a one file NVIM configuration. Makes it simple and more maintainable. Do I need to configurate plugins for EVERY little thing?
  xdg.configFile."nvim/init.lua".source = ./init.lua;

  # I am putting all my LSPs here....
  # Should LSPs go in a project's flake/nix? Probably not, but worth testing.
  home.pacakges = with pkgs; [
	inputs.nil.packages.${pkgs.system}.nil
	lua-language-server
	gopls
	prisma-language-server
	typescript-language-server
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

	# with pkgs.nur.repos.m15a.vimExtraPlugins; # Having problems with deprecation here. 
	plugins = treesitter-languages ++ (with pkgs.vimPlugins; [
		# line
		lualine-nvim
		indent-blankline-nvim
		# incline-nvim
		
		# language server
		nvim-lspconfig
		cmp-nvim-lsp
		cmp-buffer
		nvim-cmp
		typescript-nvim
		lsp-inlayhints-nvim

		# Treesitter
		nvim-treesitter 
		cmp-treesitter 

		# telescope
		plenary-nvim
		telescope-nvim
		telescope-file-browser-nvim

		# theme
		oxocarbon-nvim

		# git
		gitsigns-nvim
		# diffview-nvim
		
		# other	
		nvim-web-devicons
	]); 
  };
}

