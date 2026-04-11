{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-wsl,
    nixos-hardware,
    home-manager,
    ...
  }: {
    nixosConfigurations.wsl = let
      username = "npc1054657282";
    in
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs username;};
        modules = [
          nixos-wsl.nixosModules.wsl
          # host目录下的主机配置是必需品。我把git也放进里面了，因为有了它才能够将本机配置与公共配置合并
          ./hosts/wsl
          # 这些是公共配置，不是主机必须，属于数字生活习惯
          # ./nixos/nixconfig.nix
          # ./nixos/font.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.${username} = {
              # 相关配置尚未实现
              imports = [
                # ./home-manager/cli.nix
                # ./home-manager/zsh.nix
              ];
              # 推测本应在以上配置中实现，由于未实现挪到此处
              home.stateVersion = "25.11";
            };
          }
        ];
      };
  };
}
