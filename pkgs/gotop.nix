{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gotop";
  version = "unstable-20210713";

  src = fetchFromGitHub {
    owner = "xxxserxxx";
    repo = pname;
    rev = "994e8bc4a47fbb2d8e218cec8cfeebc8b392238a";
    sha256 = "sha256-qvKQGL/M+zXN723y1A+Reme1BRboZkLLzP38wIAeY1U=";
  };

  runVend = true;
  vendorSha256 = "sha256-GcIaUIuTiSY1aKxRtclfl7hMNaZZx4uoVG7ahjF/4Hs=";

  buildFlagsArray = [ "-ldflags=-s -w -X main.Version=v${version}" ];

  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  meta = with lib; {
    description = "A terminal based graphical activity monitor inspired by gtop and vtop";
    homepage = "https://github.com/xxxserxxx/gotop";
    changelog = "https://github.com/xxxserxxx/gotop/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = [ maintainers.magnetophon ];
    platforms = platforms.unix;
  };
}
