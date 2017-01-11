# run "python parse-deps.py > ./deps.nix < ./DEPS" to regenerate this.

{ fetchgit }:

{

  "third_party/sfntly/cpp/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/sfntly/cpp/src.git";
    rev = "1bdaae8fc788a5ac8936d68bf24f37d977a13dac";
    sha256 = "1gwr3prjbc35li9x57m68q2dliagcmnfwqpmz5jx4r70hcq3vph6";
  };
  "third_party/libc++/trunk" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/llvm-project/libcxx.git";
    rev = "48198f9110397fff47fe7c37cbfa296be7d44d3d";
    sha256 = "03ah8aph42kgn1bjb2qq3s1k4ax74a0fqbm78yasd2c0jixwjksg";
  };
  "third_party/libc++abi/trunk" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/llvm-project/libcxxabi.git";
    rev = "4ad1009ab3a59fa7a6896d74d5e4de5885697f95";
    sha256 = "00m0r8kz6barc5xf2n09vpxik1qvkv716b1njycdidz667vpzhfa";
  };
  "third_party/flac" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/flac.git";
    rev = "0635a091379d9677f1ddde5f2eec85d0f096f219";
    sha256 = "0psy0jk87qsgvfca7pnxa849yxpq59r6lzlr3wci5drim2icr4la";
  };
  "media/cdm/ppapi/api" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/cdm.git";
    rev = "7b7c6cc620e13c8057b4b6bff19e5955feb2c8fa";
    sha256 = "0ib8s7paj6iqw16v8q0przpf1mdkjv0lzl3nnmpn7bir8pz8b2j9";
  };
  "third_party/skia" = fetchgit {
    url = "https://chromium.googlesource.com/skia.git";
    rev = "0846f1b1c43f5edebc2d87a19c7bca6574ff41df";
    sha256 = "0i16v8r0yj1ng4cp8zxvfbc8zj857xqj99qpxqsqsbfxihi4hbmg";
  };
  "chrome/test/data/perf/frame_rate/content" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/frame_rate/content.git";
    rev = "c10272c88463efeef6bb19c9ec07c42bc8fe22b9";
    sha256 = "0yi9xc0qihr1pw9fllsy9x9p19211p534qn7j70l7bply6x1r2dp";
  };
  "third_party/ots" = fetchgit {
    url = "https://chromium.googlesource.com/external/ots.git";
    rev = "98897009f3ea8a5fa3e20a4a74977da7aaa8e61a";
    sha256 = "0g0bw7dzcxmq8388mywm0c78q0p3idnrwgzvb0xqgahgqhgyy4sh";
  };
  "third_party/mesa/src" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/mesa.git";
    rev = "071d25db04c23821a12a8b260ab9d96a097402f0";
    sha256 = "11y3hcqhcmm1mmc8pcp7js481gfdxx72z7mv5mb0a6qx4jrbh3ph";
  };
  "third_party/opus/src" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/opus.git";
    rev = "cae696156f1e60006e39821e79a1811ae1933c69";
    sha256 = "0ggkqld1vqfifw63c6m613js1dyi053pwwafz89giwkn21xsdjmh";
  };
  "third_party/hunspell_dictionaries" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/hunspell_dictionaries.git";
    rev = "4560bdd463a3500e2334e85c8a0e9e5d5d6774e7";
    sha256 = "062l82k2jw5s3pr39s0n8zfvzyqnb5pbs3r8mk4la8xznmicm2q8";
  };
  "third_party/brotli/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/font-compression-reference.git";
    rev = "8c9c83426beb4a58da34be76ea1fccb4054c4703";
    sha256 = "164i4vd7b7h2n3w74gwjpfd3bav0rjl71lybclvr4rixdhrw6gv3";
  };
  "third_party/cacheinvalidation/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/google-cache-invalidation-api/src.git";
    rev = "c91bd9d9fed06bf440be64f87b94a2effdb32bc4";
    sha256 = "03w4ffnw8bqd5k01b0i8vm5bvfgncl7y2g2rhf0l219hi21q2y4b";
  };
  "buildtools" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/buildtools.git";
    rev = "451dcd05a5b34936f5be67b2472cd63aaa508401";
    sha256 = "11f84p1vgvci22f8y0s3w9jz1wybmsxivv870d5swqw9ckwbd2p6";
  };
  "third_party/scons-2.0.1" = fetchgit {
    url = "https://chromium.googlesource.com/native_client/src/third_party/scons-2.0.1.git";
    rev = "1c1550e17fc26355d08627fbdec13d8291227067";
    sha256 = "0w7hw5larlgc2bvxpvz82vf6b25g5b7p267cbzj29clnw1n548fq";
  };
  "third_party/webdriver/pylib" = fetchgit {
    url = "https://chromium.googlesource.com/external/selenium/py.git";
    rev = "5fd78261a75fe08d27ca4835fb6c5ce4b42275bd";
    sha256 = "0grjcv25ajbf8zbhp8s1qajba980aspz52pzicfnk4csmpamcwkw";
  };
  "third_party/libaddressinput/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/libaddressinput.git";
    rev = "61f63da7ae6fa469138d60dec5d6bbecc6ab43d6";
    sha256 = "1dq4lzp8vrba00x58amg9f9irslviw6n3pqb0x95lrhr3xmhdsyb";
  };
  "third_party/cld_2/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/cld2.git";
    rev = "14d9ef8d4766326f8aa7de54402d1b9c782d4481";
    sha256 = "11svn836i83xl9dqain38ynarnkx15cyl70xsxqbjbaflwycqwj7";
  };
  "third_party/libsrtp" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/libsrtp.git";
    rev = "6446144c7f083552f21cc4e6768e891bcb767574";
    sha256 = "0bw82zfqbkz1dngplbzvh12y77ilna4c70jch9zqqy6jl69im73m";
  };
  "third_party/libexif/sources" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/libexif/sources.git";
    rev = "ed98343daabd7b4497f97fda972e132e6877c48a";
    sha256 = "0b3baylk2wagn53cf596g63fw7hv3hnpslxidiqbi7hkh8ikkgz2";
  };
  "third_party/pdfium" = fetchgit {
    url = "https://pdfium.googlesource.com/pdfium.git";
    rev = "f8105c665856863ad95da37fee6c12b98b953e2c";
    sha256 = "0ys5navciwfv1fpihljgm8mr908p1ikby6i4gagd5vvw2mxjlzgi";
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
    url = "https://chromium.googlesource.com/external/libyuv.git";
    rev = "d204db647e591ccf0e2589236ecea90330d65a66";
    sha256 = "1y1ixlgv8wqzz5lrrqngim5qskq5b7r7bknaq0mkjsysqgckivcw";
  };
  "sdch/open-vcdiff" = fetchgit {
    url = "https://chromium.googlesource.com/external/open-vcdiff.git";
    rev = "438f2a5be6d809bc21611a94cd37bfc8c28ceb33";
    sha256 = "0qz8yvxdibc51zp3g3c7lrwb0k3pqj2wlmsnmnh84rmyra084wj8";
  };
  "third_party/pyftpdlib/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/pyftpdlib.git";
    rev = "2be6d65e31c7ee6320d059f581f05ae8d89d7e45";
    sha256 = "1hdr9fki6lj2q4zk5b77mlz7i0k5krhg5rkc2hpwkv6r29yq38dr";
  };
  "tools/grit" = fetchgit {
    url = "https://chromium.googlesource.com/external/grit-i18n.git";
    rev = "a5890a8118c0c80cc0560e6d8d5cf65e5d725509";
    sha256 = "0j95hvyi160fhkxjyg64mmavmfiwrirniwf4hzxss1q8pqdw26j5";
  };
  "third_party/usrsctp/usrsctplib" = fetchgit {
    url = "https://chromium.googlesource.com/external/usrsctplib.git";
    rev = "190c8cbfcf8fd810aa09e0fab4ca62a8ce724e14";
    sha256 = "1fyjfr68xhvwvhm43m9wl55wff867kq04am4ypz3pr9bqmsyjwrq";
  };
  "third_party/webrtc" = fetchgit {
    url = "https://chromium.googlesource.com/external/webrtc/trunk/webrtc.git";
    rev = "378a41a7a8ab38212bc6dcd800422861227bb304";
    sha256 = "1rb3zc9wcf1m0jklrbca200y6n5b77brfvjdgd34gkwiadrp1ksl";
  };
  "tools/deps2git" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/tools/deps2git.git";
    rev = "f04828eb0b5acd3e7ad983c024870f17f17b06d9";
    sha256 = "14fm2m3d4hcr3z2p7jmif7q8dkgx1yrdr93y1zfrkya6vdiap3a9";
  };
  "third_party/libjpeg_turbo" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/libjpeg_turbo.git";
    rev = "034e9a9747e0983bc19808ea70e469bc8342081f";
    sha256 = "1cdc5rplfs24f7r5ggy0kwgmnb9pkvzcryfcg0lfihkxcfqi7qr3";
  };
  "third_party/pywebsocket/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/pywebsocket/src.git";
    rev = "cb349e87ddb30ff8d1fa1a89be39cec901f4a29c";
    sha256 = "0v4qn1dgc5awwlvpypnwhsmr37qbwdpq2flj6mk9ypqwlxn1cgyy";
  };
  "third_party/bidichecker" = fetchgit {
    url = "https://chromium.googlesource.com/external/bidichecker/lib.git";
    rev = "97f2aa645b74c28c57eca56992235c79850fa9e0";
    sha256 = "16104w158srs0n47kp3mvgsnvh0j0y170mx5xbx7kqn083nkvi7g";
  };
  "third_party/snappy/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/snappy.git";
    rev = "762bb32f0c9d2f31ba4958c7c0933d22e80c20bf";
    sha256 = "1yhdcvmgf47zbniynxx35mdgh9y1lqkp26mc7xi7h9ysxzw87d94";
  };
  "third_party/openmax_dl" = fetchgit {
    url = "https://chromium.googlesource.com/external/webrtc/deps/third_party/openmax.git";
    rev = "1a4171cedda887acc49408a8ea06bea740e74481";
    sha256 = "0mk32yqnd6mhhm6vmwnhr9rb1crf8r7g5xrsrkzbvqyv1myb7g3q";
  };
  "third_party/jsoncpp/source/lib_json" = fetchgit {
    url = "https://chromium.googlesource.com/external/jsoncpp/jsoncpp/src/lib_json.git";
    rev = "a8caa51ba2f80971a45880425bf2ae864a786784";
    sha256 = "0zha23jn3zr18rhjc0ag5jxykn38qzydvcl811jqpkdjr08yps7b";
  };
  "third_party/webgl/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/khronosgroup/webgl.git";
    rev = "cff04f76d09ab148bf79361ed7bd8f8d8ee74761";
    sha256 = "14llsa0gpfwv21hjs6xnfjyad9xwjw523y5py60b5cqj1gvmhx9v";
  };
  "testing/gmock" = fetchgit {
    url = "https://chromium.googlesource.com/external/googlemock.git";
    rev = "29763965ab52f24565299976b936d1265cb6a271";
    sha256 = "0n2ajjac7myr5bgqk0x7j8281b4whkzgr1irv5nji9n3xz5i6gz4";
  };
  "third_party/smhasher/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/smhasher.git";
    rev = "e87738e57558e0ec472b2fc3a643b838e5b6e88f";
    sha256 = "0b4yxi80kixp0dr51q3a80ia2nv70spp1mhsbl31rwmlczzby827";
  };
  "third_party/hunspell" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/hunspell.git";
    rev = "c956c0e97af00ef789afb2f64d02c9a5a50e6eb1";
    sha256 = "060xvkvfkr1xnqc6vkb49wckwirhrjqhxsb1k5fjmc163riii9mh";
  };
  "chrome/browser/resources/pdf/html_office" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/html-office-public.git";
    rev = "eeff97614f65e0578529490d44d412032c3d7359";
    sha256 = "0klwfxswyia4nmf37n8ybbv24lsx1qqa3favzmmaxdp399q8nlbp";
  };
  "native_client" = fetchgit {
    url = "https://chromium.googlesource.com/native_client/src/native_client.git";
    rev = "57cd0f2bac7fedefd895f521f08f557918bceb91";
    sha256 = "0npvr60zr9v3mf07qiz32q2632jycwcpcnqqc14i9p1p8rc7vs3x";
  };
  "third_party/leveldatabase/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/leveldb.git";
    rev = "251ebf5dc70129ad3c38193fe6c99a5b0ec6b9fa";
    sha256 = "14p3rff6c4msw6gff31sd1m80qa5rcfcp5cylkhxhvyxxh60yr21";
  };
  "tools/gyp" = fetchgit {
    url = "https://chromium.googlesource.com/external/gyp.git";
    rev = "82b08049cc0b1f9e0bdcc0702ac6b523360f635f";
    sha256 = "0q8098iwvpm1905gfx8zna24zm71547lsahxmahk6hfpqhvvzp16";
  };
  "chrome/test/data/perf/canvas_bench" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/canvas_bench.git";
    rev = "a7b40ea5ae0239517d78845a5fc9b12976bfc732";
    sha256 = "0cs215p1353dfp0s8x33jhz7ih0fh9ajwwax6d5q15la274axwxj";
  };
  "third_party/ffmpeg" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/third_party/ffmpeg.git";
    rev = "b9d631d0ad277109678e86d729acc889793b4b94";
    sha256 = "0n3pa8njfp3wj2dni01h34b02rz71nkdsv3rvw8da3c8bdply7kq";
  };
  "tools/page_cycler/acid3" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/acid3.git";
    rev = "6be0a66a1ebd7ebc5abc1b2f405a945f6d871521";
    sha256 = "0dmkrbhb4kb7vk33i3zc0kv9ihbkxwy4cfvaw5fnfx9zp77jgdpv";
  };
  "third_party/libjingle/source/talk" = fetchgit {
    url = "https://chromium.googlesource.com/external/webrtc/trunk/talk.git";
    rev = "b40ea517179d49b2a39084ab05aaae85600bfbc2";
    sha256 = "1rvvp92z88z84im053vnvj0n84z9nr191f0bm162dxlcc7ra5kcd";
  };
  "third_party/jsoncpp/source/include" = fetchgit {
    url = "https://chromium.googlesource.com/external/jsoncpp/jsoncpp/include.git";
    rev = "b0dd48e02b6e6248328db78a65b5c601f150c349";
    sha256 = "12iwr4nc7bna32xkd8dzyvmy3rig2vrkiggg52xx3b6mjadbdm7c";
  };
  "third_party/libphonenumber/test" = fetchgit {
    url = "https://chromium.googlesource.com/external/libphonenumber/cpp/test.git";
    rev = "f351a7e007f9c9995494499120bbc361ca808a16";
    sha256 = "15mk5sb7aqvm0h1i4y9djc67qqsqji6nqiff8nlsdghrr09mrfpq";
  };
  "testing/gtest" = fetchgit {
    url = "https://chromium.googlesource.com/external/googletest.git";
    rev = "8245545b6dc9c4703e6496d1efd19e975ad2b038";
    sha256 = "03gdvd0wcxgcrcll1rwdr6fzjw1cm4ivhlnrxk2wr7ni9qpmbpyh";
  };
  "third_party/trace-viewer" = fetchgit {
    url = "https://chromium.googlesource.com/external/trace-viewer.git";
    rev = "2a348ed4cbdf27a8c9f0431d34ecbabf66182f08";
    sha256 = "1yp1bzbqc6z9i4zzmd4x3rypyd5s8ifn3hvknx306kd7amz054wr";
  };
  "third_party/icu" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/icu.git";
    rev = "51c1a4ce5f362676aa1f1cfdb5b7e52edabfa5aa";
    sha256 = "1gys098nwi0bnps4m0q107m8nqjc0fcgh36zzqscx0dzacf1qni9";
  };
  "third_party/colorama/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/colorama.git";
    rev = "799604a1041e9b3bc5d2789ecbd7e8db2e18e6b8";
    sha256 = "0llfx0c2rs270431s8yi8ffmn45zxncwxmwby42q3adv45il87qq";
  };
  "third_party/webpagereplay" = fetchgit {
    url = "https://chromium.googlesource.com/external/web-page-replay.git";
    rev = "2f7b704b8b567983c040f555d3e46f9766db8e87";
    sha256 = "0wkq2jqhvi7y7mbc035v9064gnysvhgsl4s86n8cg77gp73q2ym4";
  };
  "tools/swarming_client" = fetchgit {
    url = "https://chromium.googlesource.com/external/swarming.client.git";
    rev = "c44f5725d2243ada2d8b63adf85ca76acb50fee6";
    sha256 = "0qbyv9hih6y8ci4qyz9caklrqj8sllq0zvf32kr9rpmxfwim3i5p";
  };
  "third_party/py_trace_event/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/py_trace_event.git";
    rev = "dd463ea9e2c430de2b9e53dea57a77b4c3ac9b30";
    sha256 = "197a03lgp3mn69sv4hfn38ahkbi1f8z75lblydlsl0yqx3i5x707";
  };
  "third_party/yasm/source/patched-yasm" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/yasm/patched-yasm.git";
    rev = "4671120cd8558ce62ee8672ebf3eb6f5216f909b";
    sha256 = "053hz6mms93vh5frsny12rpcp8sjm985crrydl8r36fxfjj12q71";
  };
  "third_party/angle" = fetchgit {
    url = "https://chromium.googlesource.com/angle/angle.git";
    rev = "04184fb0465ea2692b90cf0fa8b203df6c31cebf";
    sha256 = "0d0fkz5wm5lkfg7k56m2x0ll6fmbv175g8kxl8wwb9l61pr2g2n9";
  };
  "third_party/libvpx" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/libvpx.git";
    rev = "d3f3dcefb055656807e8a2f65a322bbb13cd05a4";
    sha256 = "0dcdhbd13vhmdr9kyx1nbf5fvqv95xq8f3dj81j0k2gr643mizds";
  };
  "third_party/boringssl/src" = fetchgit {
    url = "https://boringssl.googlesource.com/boringssl.git";
    rev = "ca9a538aa0f2ebdd261783efa032e69a2ea17fbc";
    sha256 = "1n10d8c8qv22icsgba5wh3qz1xfakq25dy0mh3lsvcpbrxmzmr7q";
  };
  "third_party/swig/Lib" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/swig/Lib.git";
    rev = "f2a695d52e61e6a8d967731434f165ed400f0d69";
    sha256 = "09xzq64vdr19kjq958f6y6s8kcrgshq8igc3162c81brsqg4rlv8";
  };
  "third_party/pdfsqueeze" = fetchgit {
    url = "https://chromium.googlesource.com/external/pdfsqueeze.git";
    rev = "5936b871e6a087b7e50d4cbcb122378d8a07499f";
    sha256 = "0ri51z2hzmqx9d030q4ysp9wi8gqhdrwcpi2n5c173y6gl1dbbjh";
  };
  "chrome/installer/mac/third_party/xz/xz" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/xz.git";
    rev = "eecaf55632ca72e90eb2641376bce7cdbc7284f7";
    sha256 = "1d1c9sr7hdddazj7wiy3kxqnpankiw8g0xadzph1ag6ny92cz5c9";
  };
  "third_party/lighttpd" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/lighttpd.git";
    rev = "9dfa55d15937a688a92cbf2b7a8621b0927d06eb";
    sha256 = "1bbpdc5b55a803y897af9zgyh6qci65gvzkc82bkr4qdqy7w9zzm";
  };
  "third_party/swig/mac" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/swig/mac.git";
    rev = "1b182eef16df2b506f1d710b34df65d55c1ac44e";
    sha256 = "1rjxwx609n5ml2xbz6ngrzfnd9isxy4bcwmxsnd3drxps04m8j5z";
  };
  "third_party/google_toolbox_for_mac/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/google-toolbox-for-mac.git";
    rev = "a09526298f9dd1ec49d3b3ac5608d2a257b94cef";
    sha256 = "18bj2jv86hfm5jjpgspfr27pj0yjqww661vy22gssxr2fampxp0z";
  };
  "chrome/tools/test/reference_build/chrome_mac" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/reference_builds/chrome_mac.git";
    rev = "8dc181329e7c5255f83b4b85dc2f71498a237955";
    sha256 = "1ab0s4h3h06z0bmaiib5qfpb6n6xfingsgilr611ds6v6xf3j6z8";
  };
  "third_party/nss" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/nss.git";
    rev = "bb4e75a43d007518ae7d618665ea2f25b0c60b63";
    sha256 = "193iqcixkkqqk9a2qw0gxcd41a9685m49bsbx5yvgwha55qbvzgy";
  };
}
