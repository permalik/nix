{ ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      command_timeout = 5000;

      c = {
        symbol = "🇨 ";
      };

      dotnet = {
        symbol = "🥅 ";
      };

      elixir = {
        symbol = "💧 ";
      };

      golang = {
        symbol = "🐹 ";
      };

      haskell = {
        symbol = "λ ";
      };

      java = {
        symbol = "☕ ";
      };

      nodejs = {
        symbol = " ";
      };

      kotlin = {
        symbol = "🅺 ";
      };

      lua = {
        symbol = "🌙 ";
      };

      ocaml = {
        symbol = "🐫 ";
      };

      python = {
        symbol = "🐍 ";
      };

      rust = {
        symbol = "🦀 ";
      };

      zig = {
        symbol = "⚡ ";
      };

      php = {
        symbol = "🐘 ";
      };

      scala = {
        symbol = "🌟 ";
      };

      swift = {
        symbol = "🐦 ";
      };

      terraform = {
        symbol = "💠 ";
      };

      vagrant = {
        symbol = "⍱ ";
      };

      helm = {
        symbol = "* ";
      };

      kubernetes = {
        symbol = "⛵️ ";
      };

      meson = {
        symbol = "🐏 ";
      };

      rlang = {
        symbol = "📐 ";
      };

      ruby = {
        disabled = true;
      };
    };
  };
}
