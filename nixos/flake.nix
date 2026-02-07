{
  description = "My fLake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, auto-cpufreq, nur, home-manager, ... }: {
    nixosConfigurations.balkan = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        auto-cpufreq.nixosModules.default
        nur.modules.nixos.default
        home-manager.nixosModules.home-manager{
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.kerim = import ./home.nix;
            backupFileExtension = "backup";
          };
        } 
      ];
    };
  };
}
