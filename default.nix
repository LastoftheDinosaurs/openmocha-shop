# This is the shell.nix file for setting up a Node.js development environment with MedusaJS.
# It includes the necessary dependencies like Node.js, Yarn, PostgreSQL, Redis, and Podman.

{ pkgs ? import <nixpkgs> {} }:

let

  # To use this shell.nix on NixOS your user needs to be configured as such:
  # users.extraUsers.adisbladis = {
  #   subUidRanges = [{ startUid = 100000; count = 65536; }];
  #   subGidRanges = [{ startGid = 100000; count = 65536; }];
  # };

  # Provides a script that copies required files to ~/
  podmanSetupScript = let
    registriesConf = pkgs.writeText "registries.conf" ''
      [registries.search]
      registries = ['docker.io']

      [registries.block]
      registries = []
    '';
  in pkgs.writeScript "podman-setup" ''
    #!${pkgs.runtimeShell}

    # Ensure necessary configuration files are present
    if ! test -f ~/.config/containers/policy.json; then
      install -Dm555 ${pkgs.skopeo.src}/default-policy.json ~/.config/containers/policy.json
    fi

    if ! test -f ~/.config/containers/registries.conf; then
      install -Dm555 ${registriesConf} ~/.config/containers/registries.conf
    fi
  '';

  # Provides a fake "docker" binary mapping to podman
  dockerCompat = pkgs.runCommandNoCC "docker-podman-compat" {} ''
    mkdir -p $out/bin
    ln -s ${pkgs.podman}/bin/podman $out/bin/docker
  '';

in pkgs.mkShell {

  buildInputs = [
    dockerCompat            # Compatibility layer to use Podman as Docker
    pkgs.medusa             # MedusaJS CLI and dependencies
    pkgs.vault-medusa       # Medusa Vault plugin for secure storage
    pkgs.podman             # Podman for managing containers
    pkgs.runc               # Container runtime for Podman
    pkgs.conmon             # Container monitor for Podman
    pkgs.skopeo             # Tool for interacting with container registries
    pkgs.slirp4netns        # User-mode networking for rootless containers
    pkgs.fuse-overlayfs     # Overlay filesystem support for Podman
    pkgs.nodejs-18_x        # Node.js 18.x for running the Medusa server
    pkgs.yarn               # Yarn package manager
    pkgs.postgresql         # PostgreSQL for the database
    pkgs.redis              # Redis for event queues
  ];

  shellHook = ''
    # Install required Podman configuration
    ${podmanSetupScript}

    echo "Welcome to the MedusaJS development environment!";

    # Ensure Podman socket is available
    if [ ! -S /run/podman/podman.sock ]; then
      echo "Podman socket not found. Starting Podman socket...";
      podman system service --time=0 &
      sleep 5  # Give the Podman service a moment to start
    fi

    # Start Podman Compose using the correct directory
    if [ -f /etc/nixos/shells/medusajs/docker-compose.yml ]; then
      echo "Starting Podman Compose services...";
      podman-compose -f /etc/nixos/shells/medusajs/docker-compose.yml up -d
    fi

    export NODE_ENV="development";
  '';

  exitHook = ''
    # Stop Podman Compose using the correct directory
    if [ -f /etc/nixos/shells/medusajs/docker-compose.yml ]; then
      echo "Stopping Podman Compose services...";
      podman-compose -f /etc/nixos/shells/medusajs/docker-compose.yml down
    fi

    # Podman socket is managed by Podman itself; no need to stop it manually
  '';
}

