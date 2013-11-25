require 'formula'

class Adium < Formula
  homepage 'https://adium.im'
  url 'https://hg.adium.im/adium/archive/7a7aed005b2b.tar.gz'
  sha1 '35ba8de03db415639a8dd2a86e0a82ac9f9b96c4'
  version '1.5.9-beta+7a7aed005b2b'

  def patches
    # fixes bug regarding SIPE plugin (http://sourceforge.net/p/sipe/bugs/216/)
    "http://repo.or.cz/w/siplcs.git/blob_plain/HEAD:/contrib/adium-patches/adium-1.5.8-disable-ssl-mitigation.patch"
  end

  def install
    system "make clean"
    system "make adium"
    prefix.install "build/Release-Debug/Adium.app"

    # Make symlinks for SIPE plugin
    # (http://tuxtutorials.com/using-adium-1-5-4-with-office-communicator-2011)
    ln_s 'Current', "#{prefix}/Adium.app/Contents/Frameworks/libpurple.framework/Versions/0.10.0"
    ln_s 'Current', "#{prefix}/Adium.app/Contents/Frameworks/libglib.framework/Versions/2.0.0"
    ln_s 'Current', "#{prefix}/Adium.app/Contents/Frameworks/libintl.framework/Versions/8"
  end

  def caveats; <<-EOS.undent
    Be sure to install the SIPE plugin (discussed here: http://tuxtutorials.com/using-adium-1-5-4-with-office-communicator-2011).

    It probably isn't available from that link anymore so you'll need to get it from the shared drive.
    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test adium`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "--version"`.
    system "false"
  end
end
