{ pkgs ? import <nixpkgs> {}
, lib ? import <nixpkgs/lib> }:

pkgs.buildGoModule rec {
  pname = "aleph-prometheus-exporter";
  version = "master";
  rev = "c2631254c47de1ef66f4c69bab6dc6424c778d31";

  # src = pkgs.fetchFromGitHub {
  #   inherit rev;
  #   owner = "alephcool";
  #   repo = "aleph-prometheus-exporter";
  #   sha256 = "sha256-oT2Avj9QTy+BC6lfmYYMdxeJoodEO3BMQRV/aNFUYJk=";
  # };

  src = ./../..;

  vendorSha256 = "sha256-JRrFRetkKBAHG/gw0uJcGLW6AdcpFpmIeLJMHxfiSrk=";

  # FIXME: tests fail due to read-only nix store
  doCheck = false;

  passthru.tests = { inherit (pkgs.nixosTests.prometheus-exporters) node; };

  proxyVendor = true;

  meta = with lib; {
    description = "Exposes some metrics from the aleph api as prometheus metrics";
    homepage = "https://github.com/alephcool/aleph-prometheus-exporter";
  };
}
