{ lib, fetchzip, stdenv }:

stdenv.mkDerivation rec {
  pname = "yacd";
  version = "0.3.8";

  src = fetchzip {
    url =
      "https://github.com/haishanh/yacd/releases/download/v${version}/yacd.tar.xz";
    sha256 = "sha256-YrqBRRyKtIKAzPTNp6YfTC8oGI4WTqQ1FohcaubD8XM=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -r . $out/bin
  '';

  meta = with lib; {
    description = "Yet Another Clash Dashboard";
    homepage = "https://github.com/haishanh/yacd";
    license = licenses.free;
    platforms = platforms.all;
  };
}
