class AsciiCow < Formula
  desc "Turn an image into colorful ASCII art spoken by a cow"
  homepage "https://github.com/andrewmacheret/ascii-cow"
  url "https://github.com/andrewmacheret/ascii-cow/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "e4e96d251834d593d4ef6ba0a9ef12e055bbf33f021eff15d5edba413e46bc34"
  license all_of: ["MIT", "Beerware"]
  head "https://github.com/andrewmacheret/ascii-cow.git", branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "cowsay"
  depends_on "imagemagick"

  uses_from_macos "curl"
  uses_from_macos "ncurses"
  uses_from_macos "perl"

  # im2a isn't in Homebrew. It's built in here instead of as its own formula,
  # because Homebrew only trusts the formula named on the command line, not
  # other formulae from this tap that it depends on.
  resource "im2a" do
    url "https://github.com/tzvetkoff/im2a/archive/refs/tags/v0.6.2.tar.gz"
    sha256 "7c32b98b8ecc679a9f1e81bf5a8911f051644aa26dd3d265acbb1a0de03e9e5c"
  end

  def install
    resource("im2a").stage do
      system "autoreconf", "--force", "--install", "--verbose"
      # im2a's configure only looks for Magick++-config in /usr and /opt/imagemagick
      system "./configure", "--with-magick++-config=#{formula_opt_bin("imagemagick")}/Magick++-config",
                            *std_configure_args(prefix: libexec)
      system "make", "install"
    end

    libexec.install "ascii-cow.sh" => "ascii-cow"
    path = [libexec/"bin", formula_opt_bin("imagemagick"), formula_opt_bin("cowsay")].join(":")
    (bin/"ascii-cow").write_env_script libexec/"ascii-cow", PATH: "#{path}:$PATH"
    pkgshare.install "example.jpg"
  end

  test do
    cp pkgshare/"example.jpg", "a cow.jpg"
    output = shell_output("#{bin}/ascii-cow -f 'a cow.jpg' -w 20")
    assert_match "\e[38;5;", output # colored art from im2a
    assert_match "(oo)", output # the cow
    assert_match "(oo)", shell_output("#{bin}/ascii-cow -f #{test_fixtures("test.png")} -h 4 -t")
  end
end
