{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "8.8.8.8" ];
    defaultGateway = "138.197.80.1";
    defaultGateway6 = {
      address = "";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="138.197.82.230"; prefixLength=20; }
          { address="10.17.0.7"; prefixLength=16; }
        ];
        ipv6.addresses = [
          { address="fe80::8470:43ff:fe6d:a1ae"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "138.197.80.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = ""; prefixLength = 128; } ];
      };
      eth1 = {
        ipv4.addresses = [
          { address="10.108.0.5"; prefixLength=20; }
        ];
        ipv6.addresses = [
          { address="fe80::9090:adff:fec0:c193"; prefixLength=64; }
        ];
      };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="86:70:43:6d:a1:ae", NAME="eth0"
    ATTR{address}=="92:90:ad:c0:c1:93", NAME="eth1"
  '';
}