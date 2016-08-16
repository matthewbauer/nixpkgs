# run "python parse-deps.py > ./deps.nix < ./DEPS" to regenerate this.

{ fetchgit }:

{
  "third_party/sfntly/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/googlei18n/sfntly.git";
    rev = "130f832eddf98467e6578b548cb74ce17d04a26d";
    sha256 = "1v2zapgw9pi8ahshps8k5jwyd0nwh9jnspf00diqgayzicdx46dn";
  };
  "third_party/flac" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/flac.git";
    rev = "2c4b86af352b23498315c016dc207e3fb2733fc0";
    sha256 = "1n13ljg8bd5s2chfs5xsj0454qkwyhfck3daklz8bmlsx4d4a0yv";
  };
  "third_party/skia" = fetchgit {
    url = "https://chromium.googlesource.com/skia.git";
    rev = "b95c8954fceebf67629d894d26cf57a170507612";
    sha256 = "1j1q2q72gv2x07qs55xdqwblqbkyrwwzqxaz9mwd9z5ix6wzgng4";
  };
  "chrome/test/data/perf/frame_rate/content" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/frame_rate/content.git";
    rev = "c10272c88463efeef6bb19c9ec07c42bc8fe22b9";
    sha256 = "0yi9xc0qihr1pw9fllsy9x9p19211p534qn7j70l7bply6x1r2dp";
  };
  "third_party/openmax_dl" = fetchgit {
    url = "https://chromium.googlesource.com/external/webrtc/deps/third_party/openmax.git";
    rev = "6670e52d32351145a6b6c198dab3f6a536edf3db";
    sha256 = "1p1b0qrkxv6i8cjbvlm8rv5l093pm1dywg1xxi5b2yka94bg3yy0";
  };
  "third_party/mesa/src" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/mesa.git";
    rev = "ef811c6bd4de74e13e7035ca882cc77f85793fef";
    sha256 = "1a1n9a0qzij772d2dixwq9p7ih2pwq9aqjnqlrx7na2xx37gwxwm";
  };
  "third_party/opus/src" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/opus.git";
    rev = "655cc54c564b84ef2827f0b2152ce3811046201e";
    sha256 = "1j84n747zlw7hxc3kp5g7020zp35gxan1iy4wnwn7jlns8mqksd9";
  };
  "third_party/hunspell_dictionaries" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/hunspell_dictionaries.git";
    rev = "c106afdcec5d3de2622e19f1b3294c47bbd8bd72";
    sha256 = "001j9y9kxxxlsqhwj8c7nqfl029ihfgpb8bs2gry03zfcghjlbi5";
  };
  "third_party/libvpx_new/source/libvpx" = fetchgit {
    url = "https://chromium.googlesource.com/webm/libvpx.git";
    rev = "89cc68252846478fa7f2d570d96ff93776cefac6";
    sha256 = "0xq350ndzbzl3hhr04g95k7p97k061rzigvcpmyriz4daj2fx1db";
  };
  "buildtools" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/buildtools.git";
    rev = "14288a03a92856fe1fc296d39e6a25c2d83cd6cf";
    sha256 = "1cvh230smrphgzvwap7wb14xfjywxsvk7gl1y3yrkd6ip55zjd0i";
  };
  "third_party/scons-2.0.1" = fetchgit {
    url = "https://chromium.googlesource.com/native_client/src/third_party/scons-2.0.1.git";
    rev = "1c1550e17fc26355d08627fbdec13d8291227067";
    sha256 = "0w7hw5larlgc2bvxpvz82vf6b25g5b7p267cbzj29clnw1n548fq";
  };
  "third_party/libwebm/source" = fetchgit {
    url = "https://chromium.googlesource.com/webm/libwebm.git";
    rev = "75a6d2da8b63e0c446ec0ce1ac942c2962d959d7";
    sha256 = "09j359aafyiy685cfrsy1mlpqxzwjws1mmcf6ajlqz6476qggdh9";
  };
  "third_party/libaddressinput/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/libaddressinput.git";
    rev = "5eeeb797e79fa01503fcdcbebdc50036fac023ef";
    sha256 = "1dbg04ii0j59iwraxpzpzxjshlrar9n21pc2pba5nrkf8yiz7bnk";
  };
  "tools/gyp" = fetchgit {
    url = "https://chromium.googlesource.com/external/gyp.git";
    rev = "ed163ce233f76a950dce1751ac851dbe4b1c00cc";
    sha256 = "1w24ag0b6wvda4cnb4pxb3kz8vbiz2a9hn57cgsy8isb5c7pv54d";
  };
  "chrome/test/data/perf/canvas_bench" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/canvas_bench.git";
    rev = "a7b40ea5ae0239517d78845a5fc9b12976bfc732";
    sha256 = "0cs215p1353dfp0s8x33jhz7ih0fh9ajwwax6d5q15la274axwxj";
  };
  "third_party/libexif/sources" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/libexif/sources.git";
    rev = "9d467f7d21e4749ee22ee7520e561ac7b38484b9";
    sha256 = "0gmfip77bqmw0rx83gsaqhlcl5k6wwrjfrf8bz32d9w198g6bkjg";
  };
  "third_party/libphonenumber/phonenumbers" = fetchgit {
    url = "https://chromium.googlesource.com/external/libphonenumber/cpp/src/phonenumbers.git";
    rev = "0d6e3e50e17c94262ad1ca3b7d52b11223084bca";
    sha256 = "0lb3jnpipx62pzrr0m4vazbpqiary99cylxs5glrmhhm12gxipg7";
  };
  "third_party/libphonenumber/resources" = fetchgit {
    url = "https://chromium.googlesource.com/external/libphonenumber/resources.git";
    rev = "b6dfdc7952571ff7ee72643cd88c988cbe966396";
    sha256 = "0mihcw3k1akb8pil58lih3pf5n5zg2621pby4d8l7v6z5pphd36z";
  };
  "third_party/safe_browsing/testing" = fetchgit {
    url = "https://chromium.googlesource.com/external/google-safe-browsing/testing.git";
    rev = "9d7e8064f3ca2e45891470c9b5b1dce54af6a9d6";
    sha256 = "12wc8hvi8vdhw32p58sl0hcxb0dsb73j0ab0qkkhl5s77gv1n248";
  };
  "third_party/libyuv" = fetchgit {
    url = "https://chromium.googlesource.com/libyuv/libyuv.git";
    rev = "20343f45c612e485cd898aeaae2250df2d0b2d2d";
    sha256 = "1jikfivbjjsmsqznqh4pcl97rwm4zhdsdr6xafn2d3a2v2h03p86";
  };
  "sdch/open-vcdiff" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/google/open-vcdiff.git";
    rev = "21d7d0b9c3d0c3ccbdb221c85ae889373f0a2a58";
    sha256 = "0gv7ywsxwfz1ysickcp3imr0dpb65750prx33mzm2y75wkcgwyrb";
  };
  "third_party/pyftpdlib/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/pyftpdlib.git";
    rev = "2be6d65e31c7ee6320d059f581f05ae8d89d7e45";
    sha256 = "1hdr9fki6lj2q4zk5b77mlz7i0k5krhg5rkc2hpwkv6r29yq38dr";
  };
  "third_party/catapult" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/catapult-project/catapult.git";
    rev = "a489be785184f64356555a8170452a6d6880cc5d";
    sha256 = "13vkzckx723z2zbrw4sba1hc0lva9ckk51ifa0fpbp2g70nsz26k";
  };
  "media/cdm/api" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/cdm.git";
    rev = "1dea7088184dec2ebe4a8b3800aabb0afbb4b88a";
    sha256 = "18xg22ym1mnqqxv0q2d4202wxbcn669w2kraphdsy0p7gf68i615";
  };
  "third_party/snappy/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/snappy.git";
    rev = "762bb32f0c9d2f31ba4958c7c0933d22e80c20bf";
    sha256 = "1yhdcvmgf47zbniynxx35mdgh9y1lqkp26mc7xi7h9ysxzw87d94";
  };
  "breakpad/src" = fetchgit {
    url = "https://chromium.googlesource.com/breakpad/breakpad/src.git";
    rev = "481608d284106df9400d447e95574799670cabaf";
    sha256 = "0x351b3lymckiq4fml5xrbzy1p61gk9l9rxvlhg66f0h6ky0mc3w";
  };
  "third_party/webrtc" = fetchgit {
    url = "https://chromium.googlesource.com/external/webrtc/trunk/webrtc.git";
    rev = "6224e9b8b854aa8681eb64990681671204d096f8";
    sha256 = "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";
  };
  "third_party/openh264/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/cisco/openh264";
    rev = "b37cda248234162033e3e11b0335f3131cdfe488";
    sha256 = "0h6m81hydndhm6d731bvwz2bcj5nc8shrnlqx66yrg0vy71dyxrd";
  };
  "third_party/pywebsocket/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/google/pywebsocket.git";
    rev = "2d7b73c3acbd0f41dcab487ae5c97c6feae06ce2";
    sha256 = "01wxfzlyxj2034kwkfbam4g69828mjprs7z6zhdbsk4f1yfr5k6s";
  };
  "third_party/webdriver/pylib" = fetchgit {
    url = "https://chromium.googlesource.com/external/selenium/py.git";
    rev = "5fd78261a75fe08d27ca4835fb6c5ce4b42275bd";
    sha256 = "0grjcv25ajbf8zbhp8s1qajba980aspz52pzicfnk4csmpamcwkw";
  };
  "third_party/bidichecker" = fetchgit {
    url = "https://chromium.googlesource.com/external/bidichecker/lib.git";
    rev = "97f2aa645b74c28c57eca56992235c79850fa9e0";
    sha256 = "16104w158srs0n47kp3mvgsnvh0j0y170mx5xbx7kqn083nkvi7g";
  };
  "third_party/usrsctp/usrsctplib" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/sctplab/usrsctp";
    rev = "c60ec8b35c3fe6027d7a3faae89d1c8d7dd3ce98";
    sha256 = "1ffg5ybvwarzc17cwpqfmaahaqm2rlig0bgxrbrdbkq3lrjnrlxm";
  };
  "third_party/webgl/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/khronosgroup/webgl.git";
    rev = "1012e1f8baea808f3bc9fcef945d66b5f740c32b";
    sha256 = "0gyfhmq0x74z62p0ww6ckrsp1msi6x3pckagwpb733ridz4kbj21";
  };
  "testing/gmock" = fetchgit {
    url = "https://chromium.googlesource.com/external/googlemock.git";
    rev = "0421b6f358139f02e102c9c332ce19a33faf75be";
    sha256 = "1xiky4v98maxs8fg1avcd56y0alv3hw8qyrlpd899zgzbq2k10pp";
  };
  "third_party/smhasher/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/smhasher.git";
    rev = "e87738e57558e0ec472b2fc3a643b838e5b6e88f";
    sha256 = "0b4yxi80kixp0dr51q3a80ia2nv70spp1mhsbl31rwmlczzby827";
  };
  "third_party/webpagereplay" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/chromium/web-page-replay.git";
    rev = "7564939bdf6482d57b9bd5e9c931679f96d8cf75";
    sha256 = "144annzhy3im47mngi89y3c8qfq49sw1gg7kfnliybnabp5w97qp";
  };
  "third_party/jsoncpp/source" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/open-source-parsers/jsoncpp.git";
    rev = "f572e8e42e22cfcf5ab0aea26574f408943edfa4";
    sha256 = "1jwk6cn94ry2r9p60x5flz06vinrr1k5vaqspxcnw4f1wi5ak93j";
  };
  "native_client" = fetchgit {
    url = "https://chromium.googlesource.com/native_client/src/native_client.git";
    rev = "fb00463cb1ebd46a46c050101f8b6a6c999d5dc1";
    sha256 = "02wkzfxy1q2aqvz9cbgn78vgrqmrh7iiqc20y8nb68bdxhq9b73a";
  };
  "third_party/dom_distiller_js/dist" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/chromium/dom-distiller-dist.git";
    rev = "e21fe06cb71327ec62431f823e783d7b02f97b26";
    sha256 = "12zzg8frflpq9sy7cn5hgr4ymjnhvaym1jjksprnxv6y50fdyjxk";
  };
  "tools/page_cycler/acid3" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/acid3.git";
    rev = "6be0a66a1ebd7ebc5abc1b2f405a945f6d871521";
    sha256 = "0dmkrbhb4kb7vk33i3zc0kv9ihbkxwy4cfvaw5fnfx9zp77jgdpv";
  };
  "third_party/leveldatabase/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/leveldb.git";
    rev = "706b7f8d43b0aecdc75c5ee49d3e4ef5f27b9faf";
    sha256 = "1rks0pirglqxm8ll28z8v33l4ivpypypq5am639g6y689d4sr7xi";
  };
  "third_party/cld_2/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/CLD2Owners/cld2.git";
    rev = "84b58a5d7690ebf05a91406f371ce00c3daf31c0";
    sha256 = "0rcs9bcy203ls7955b8s7lkvy40lfdh260l3kg8b3h9ibhyz9jd8";
  };
  "third_party/libsrtp" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/libsrtp.git";
    rev = "8eecac0feef4c65e2debb42718a10eab91551f35";
    sha256 = "045jfskv5ygwr4gpadifrjvlfn19rrdnhqxrdlvann9aacygqixg";
  };
  "third_party/ffmpeg" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/third_party/ffmpeg.git";
    rev = "b828a1bc02572754455e97508e4b78fc06d5e6fa";
    sha256 = "1yr4lcldpcmx4a8pr7wrnxvc5ndv2597xipj51sibfd0cq29asza";
  };
  "third_party/pdfium" = fetchgit {
    url = "https://pdfium.googlesource.com/pdfium.git";
    rev = "58340b0f837343671f1eb033371a41441eae80cd";
    sha256 = "0fjrsc0v1hc7d0whj63ih0qw1w7vwri5qlzkfvyhijhbc7yam22p";
  };
  "third_party/libjingle/source/talk" = fetchgit {
    url = "https://chromium.googlesource.com/external/webrtc/trunk/talk.git";
    rev = "04170d694b177d0e4b2c4f191daad36e88f765b2";
    sha256 = "0j1wpwrqj65sklw21xrb59v1yyrhqq0wkacfji0g7qr8r4d1r7bm";
  };
  "third_party/libjpeg_turbo" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/libjpeg_turbo.git";
    rev = "e4e75037f29745f1546b6ebf5cf532e841c04c2c";
    sha256 = "0pavvzhkvgfidqv7jyw9f649ws1af9m8v5qnkqr8z50g9kgqh5hf";
  };
  "third_party/libphonenumber/test" = fetchgit {
    url = "https://chromium.googlesource.com/external/libphonenumber/cpp/test.git";
    rev = "f351a7e007f9c9995494499120bbc361ca808a16";
    sha256 = "15mk5sb7aqvm0h1i4y9djc67qqsqji6nqiff8nlsdghrr09mrfpq";
  };
  "testing/gtest" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/google/googletest.git";
    rev = "6f8a66431cb592dad629028a50b3dd418a408c87";
    sha256 = "0bdba2lr6pg15bla9600zg0r0vm4lnrx0wqz84p376wfdxra24vw";
  };
  "third_party/icu" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/icu.git";
    rev = "052cebbb5f0695b797b0053cb302a2ca29b8044a";
    sha256 = "07y934yrq1plx8d38ygzhj5ldqfm18pisa8j2lnsrg6p68pnar2f";
  };
  "third_party/colorama/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/colorama.git";
    rev = "799604a1041e9b3bc5d2789ecbd7e8db2e18e6b8";
    sha256 = "0pq80idlwfm7c2xz3ssjr1rg28rdlhqyss0bfpm595v4wh5s2v37";
  };
  "tools/swarming_client" = fetchgit {
    url = "https://chromium.googlesource.com/external/swarming.client.git";
    rev = "a72f46e42dba1335e8001499b4621acad2d26728";
    sha256 = "1ziw8lmkra8fs4mlwkv92648qvgsi3ibai2wba15yjzba8bv2z2p";
  };
  "third_party/py_trace_event/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/py_trace_event.git";
    rev = "dd463ea9e2c430de2b9e53dea57a77b4c3ac9b30";
    sha256 = "0450mcid9rq8b3358v15lqxdg3lc4v9cl0fxkq3cg5hii6zj9s9f";
  };
  "third_party/yasm/source/patched-yasm" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/yasm/patched-yasm.git";
    rev = "7da28c6c7c6a1387217352ce02b31754deb54d2a";
    sha256 = "102ym0k028psivbvcxr1mxsy4cagl89byvbm5j3xig751bh96s7d";
  };
  "third_party/re2/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/google/re2.git";
    rev = "dba3349aba83b5588e85e5ecf2b56c97f2d259b7";
    sha256 = "07kmv1fanix0p333cxvahp50jiiaw9ncbjrvpv1syx16hsb8j2if";
  };
  "third_party/angle" = fetchgit {
    url = "https://chromium.googlesource.com/angle/angle.git";
    rev = "c46018b8598dad46f6834411f27e12e90bb62a56";
    sha256 = "1kcpr6kk8rs5vqkjp5pfkqkslbvn0q0glkd5qdf86g1xmrydhfjh";
  };
  "third_party/boringssl/src" = fetchgit {
    url = "https://boringssl.googlesource.com/boringssl.git";
    rev = "c880e42ba1c8032d4cdde2aba0541d8a9d9fa2e9";
    sha256 = "0wabf25xfrjbwhml7bfhrxh1644apncykx06q3py28pxmpy7b1b1";
  };
  "third_party/pdfsqueeze" = fetchgit {
    url = "https://chromium.googlesource.com/external/pdfsqueeze.git";
    rev = "5936b871e6a087b7e50d4cbcb122378d8a07499f";
    sha256 = "0ri51z2hzmqx9d030q4ysp9wi8gqhdrwcpi2n5c173y6gl1dbbjh";
  };
  "chrome/installer/mac/third_party/xz/xz" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/xz.git";
    rev = "eecaf55632ca72e90eb2641376bce7cdbc7284f7";
    sha256 = "199xxjrn6xsaphw9fmbxg8nx507hiqfcsnq02wzw454vmylxq1ic";
  };
  "third_party/lighttpd" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/lighttpd.git";
    rev = "9dfa55d15937a688a92cbf2b7a8621b0927d06eb";
    sha256 = "1bbpdc5b55a803y897af9zgyh6qci65gvzkc82bkr4qdqy7w9zzm";
  };
  "third_party/google_toolbox_for_mac/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/google/google-toolbox-for-mac.git";
    rev = "401878398253074c515c03cb3a3f8bb0cc8da6e9";
    sha256 = "0q3c4lcp9gcp7cc9nsq50ahz63dazdp897g45jckd8fyml1z8cxn";
  };
  "chrome/tools/test/reference_build/chrome_mac" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/reference_builds/chrome_mac.git";
    rev = "8dc181329e7c5255f83b4b85dc2f71498a237955";
    sha256 = "1ab0s4h3h06z0bmaiib5qfpb6n6xfingsgilr611ds6v6xf3j6z8";
  };
  "third_party/nss" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/nss.git";
    rev = "225bfc39c93dfb7c7d0d1162f81e9bb5cd356c30";
    sha256 = "19qzmimvh5z43lkmh7ahi0dwh36drvqzfmklrlay62cg6d2c705r";
  };
}
