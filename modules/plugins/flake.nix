{
	inputs = {
		nvim-dap-python-src = {
			url = "github:mfussenegger/nvim-dap-python";
			flake = false;
		};
	};
	outputs = inputs:
	let
		adhocVimPlugins = pkgs: {
			nvim-dap-python = pkgs.vimUtils.buildVimPlugin {
				name = "nvim-dap-python";
				src = inputs.nvim-dap-python-src;
			};
		};
	in
	{
		overlay = _final: prev: {
			vimPlugins = prev.vimPlugins // (adhocVimPlugins prev.pkgs);
		};
	};
}
