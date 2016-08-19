# run "python parse-deps.py > ./deps.nix < ./DEPS" to regenerate this.

{ fetchgit }:

{
  "third_party/sfntly/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/googlei18n/sfntly.git";
    rev = "130f832eddf98467e6578b548cb74ce17d04a26d";
    sha256 = "1v2zapgw9pi8ahshps8k5jwyd0nwh9jnspf00diqgayzicdx46dn";
  };
  "third_party/flatbuffers/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/google/flatbuffers.git";
    rev = "6f751d5d26fd566f8c9060358101a2596677f9cf";
    sha256 = "1klkl7vx84dxh0k6an25ixr17xnsgnqajk25b8ibd0xqsd71757k";
  };
  "third_party/flac" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/flac.git";
    rev = "812243a85937e06102ba312c6caf8823e243b35b";
    sha256 = "0mnn0vnz86fr1bya9lwhiyjj3hjgyy562qd0crd020xcrkszwb6f";
  };
  "third_party/skia" = fetchgit {
    url = "https://chromium.googlesource.com/skia.git";
    rev = "c20d6706cc0220956c43a020a1a71c4e73a468e0";
    sha256 = "12a1fh6p1wjvk4xdhl3b8lhd8ma9vdy130wjn1gwpf2b0pdc5y9r";
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
  "third_party/SPIRV-Tools/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/KhronosGroup/SPIRV-Tools.git";
    rev = "9166854ac93ef81b026e943ccd230fed6c8b8d3c";
    sha256 = "0xza1y8qv5s9y9kh7cbh0yk3qz7wp9zcckggzw6j8d9fk6684l9i";
  };
  "third_party/hunspell_dictionaries" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/hunspell_dictionaries.git";
    rev = "dc6e7c25bf47cbfb466e0701fd2728b4a12e79d5";
    sha256 = "1aqr4jlpvw8q4bqfmpd3sw3i6a7kaqxxa6h5fbbgk3hna9l3jwc5";
  };
  "third_party/shaderc/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/google/shaderc.git";
    rev = "cd8793c34907073025af2622c28bcee64e9879a4";
    sha256 = "07kn4vr78wq93c3l9crv7n9rmf2aci504ra8bp2ndvlmqs7cpi3c";
  };
  "buildtools" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/buildtools.git";
    rev = "06e80a0e17319868d4a9b13f9bb6a248dc8d8b20";
    sha256 = "17vx4bbj9glhsrwf2cqfg1fi2781qn2kckkdinlrxp42cbx91prj";
  };
  "third_party/scons-2.0.1" = fetchgit {
    url = "https://chromium.googlesource.com/native_client/src/third_party/scons-2.0.1.git";
    rev = "1c1550e17fc26355d08627fbdec13d8291227067";
    sha256 = "0w7hw5larlgc2bvxpvz82vf6b25g5b7p267cbzj29clnw1n548fq";
  };
  "third_party/libwebm/source" = fetchgit {
    url = "https://chromium.googlesource.com/webm/libwebm.git";
    rev = "9a235e0bc94319c5f7184bd69cbe5468a74a025c";
    sha256 = "1nmdbyms1qgqkqlfvwipgr77s2figlsadnf7fg7a03kdcv6xjr8z";
  };
  "third_party/libaddressinput/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/libaddressinput.git";
    rev = "5eeeb797e79fa01503fcdcbebdc50036fac023ef";
    sha256 = "1dbg04ii0j59iwraxpzpzxjshlrar9n21pc2pba5nrkf8yiz7bnk";
  };
  # "tools/gyp" = fetchgit {
  #   url = "https://chromium.googlesource.com/external/gyp.git";
  #   rev = "bce1c7793010574d88d7915e2d55395213ac63d1";
  #   sha256 = "07vjxdlh2dclg88jrsvnzjnl6773m0a6sx778q62n2q34gyj1rlb";
  # };
  "third_party/libyuv" = fetchgit {
    url = "https://chromium.googlesource.com/libyuv/libyuv.git";
    rev = "76aee8ced7ca74c724d69c1dcf9891348450c8e8";
    sha256 = "076r9wi27i99s857n7d7jfrk1pdnahzbsdj2bp60sk5dhqg9fhg3";
  };
  "third_party/safe_browsing/testing" = fetchgit {
    url = "https://chromium.googlesource.com/external/google-safe-browsing/testing.git";
    rev = "9d7e8064f3ca2e45891470c9b5b1dce54af6a9d6";
    sha256 = "12wc8hvi8vdhw32p58sl0hcxb0dsb73j0ab0qkkhl5s77gv1n248";
  };
  "third_party/libvpx/source/libvpx" = fetchgit {
    url = "https://chromium.googlesource.com/webm/libvpx.git";
    rev = "669e7b7454ccb4088e300965a5e8ff2586f0d0db";
    sha256 = "1rym9lqlz92xa0vvkc1fxg4i0n9af8v578rxr7d33aj63x8iml7k";
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
    rev = "caaf30d6a5c59aa329826835b1bd048919fbec93";
    sha256 = "0qkh3xikzvvyhncs2b8afxjn3q5xakpik2l506wskzqpivw4im4j";
  };
  "media/cdm/api" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/cdm.git";
    rev = "245af7782c9f54d776722a2c7b53372ee040e5fc";
    sha256 = "127zarwgjy6lxikpzm9xjvdcqg3l4pf96c115psw02m09kb50apz";
  };
  "third_party/snappy/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/snappy.git";
    rev = "762bb32f0c9d2f31ba4958c7c0933d22e80c20bf";
    sha256 = "1yhdcvmgf47zbniynxx35mdgh9y1lqkp26mc7xi7h9ysxzw87d94";
  };
  "breakpad/src" = fetchgit {
    url = "https://chromium.googlesource.com/breakpad/breakpad/src.git";
    rev = "5aac5eabb0fd7cbd3bf7805fb922fe2f90e80155";
    sha256 = "0vwxy5xyxagzps3xi45ml99rk8qaavdg8gy7w8xxb6x969hpiihd";
  };
  "third_party/webrtc" = fetchgit {
    url = "https://chromium.googlesource.com/external/webrtc/trunk/webrtc.git";
    rev = "29d1d6e59788c5faff3c387470b399169033e50f";
    sha256 = "0vav4q80rqcdx4rwn93sqanw5rnvc6l1afq9hrmkd2fhaq8niiz9";
  };
  "third_party/libjpeg_turbo" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/libjpeg_turbo.git";
    rev = "7260e4d8b8e1e40b17f03fafdf1cd83296900f76";
    sha256 = "04q30dqijlb05gggcmimjslwxxagd7qnjzc9y15p01zcf6h485pi";
  };
  "third_party/libFuzzer/src" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/llvm-project/llvm/lib/Fuzzer.git";
    rev = "d05583bdc4ae06542f00e0837ceba145a0b6a7e7";
    sha256 = "1v0dwb9nb3drbn24zyr6hrrq35v58rkffksqmrrj3ingr62ni7vf";
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
  "third_party/libphonenumber/dist" = fetchgit {
    url = "https://chromium.googlesource.com/external/libphonenumber.git";
    rev = "a4da30df63a097d67e3c429ead6790ad91d36cf4";
    sha256 = "1vjg4g5dipfxqpl5c30r8c2iqcywmz8yby8lj20sadfy3bc7rkqp";
  };
  "third_party/webgl/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/khronosgroup/webgl.git";
    rev = "7d11596e11c151efdb09359934f147027ddc744c";
    sha256 = "0kr2x6551504j7nnhz0b3ps83c29h9ib609g5yjn0ki6sy6s27s1";
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
    rev = "3cd3a3f6f06a1b87b14b9162c7eb16d23d141241";
    sha256 = "1mbdrcxbbly9sj8v45nbdj0gskrbqq81n4q9cl3c1jq88473z75v";
  };
  "third_party/jsoncpp/source" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/open-source-parsers/jsoncpp.git";
    rev = "f572e8e42e22cfcf5ab0aea26574f408943edfa4";
    sha256 = "1jwk6cn94ry2r9p60x5flz06vinrr1k5vaqspxcnw4f1wi5ak93j";
  };
  "native_client" = fetchgit {
    url = "https://chromium.googlesource.com/native_client/src/native_client.git";
    rev = "7d72623057456b133aae9e97f264b3a204e97edc";
    sha256 = "07lvgbs1iivs93775kwdvxs73hspjxz92sj2vmharv05mxsib9hd";
  };
  "third_party/dom_distiller_js/dist" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/chromium/dom-distiller-dist.git";
    rev = "ce63d90f1897919023ebb63d8debd758843a1794";
    sha256 = "0dgqpgiz0jxwra7aysd2sirjzf8zrpd73srm21dnkyvzh95jvx7p";
  };
  "tools/page_cycler/acid3" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/acid3.git";
    rev = "6be0a66a1ebd7ebc5abc1b2f405a945f6d871521";
    sha256 = "0dmkrbhb4kb7vk33i3zc0kv9ihbkxwy4cfvaw5fnfx9zp77jgdpv";
  };
  "third_party/glslang/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/google/glslang.git";
    rev = "210c6bf4d8119dc5f8ac21da2d4c87184f7015e0";
    sha256 = "0iasvi3sybai0h5z38g19xfn5nz6d99hc88l55y76b9bhy5r7mbp";
  };
  "third_party/leveldatabase/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/leveldb.git";
    rev = "a7bff697baa062c8f6b8fb760eacf658712b611a";
    sha256 = "12sik8bc9w5lp85hrd6lyy0q58n889xvmzfl1h847p13v1r3rflg";
  };
  "third_party/cld_2/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/CLD2Owners/cld2.git";
    rev = "84b58a5d7690ebf05a91406f371ce00c3daf31c0";
    sha256 = "0rcs9bcy203ls7955b8s7lkvy40lfdh260l3kg8b3h9ibhyz9jd8";
  };
  "chrome/test/data/perf/canvas_bench" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/canvas_bench.git";
    rev = "a7b40ea5ae0239517d78845a5fc9b12976bfc732";
    sha256 = "0cs215p1353dfp0s8x33jhz7ih0fh9ajwwax6d5q15la274axwxj";
  };
  "third_party/ffmpeg" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/third_party/ffmpeg.git";
    rev = "36ddd4acc0052eaaf6d5d7b9d5c234245a879dd9";
    sha256 = "1hk8gsh6k1c1q5q0l2spxmg4mavajj1sfnh28khbmv7b4wqsrvhk";
  };
  "third_party/pdfium" = fetchgit {
    url = "https://pdfium.googlesource.com/pdfium.git";
    rev = "d4a13ae223f2c7d5e4ffae45daecb4cd5bdbef47";
    sha256 = "0yk8w13ngw8cc85vmjv32fxdcx873x8wizv08gzfx8z95r7blacr";
  };
  "third_party/openh264/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/cisco/openh264";
    rev = "b37cda248234162033e3e11b0335f3131cdfe488";
    sha256 = "0h6m81hydndhm6d731bvwz2bcj5nc8shrnlqx66yrg0vy71dyxrd";
  };
  "third_party/libsrtp" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/libsrtp.git";
    rev = "720780acf8fa41c4a6ad515d0382d62f8f5195eb";
    sha256 = "07l9z66kzqrcn2dh91q3ppvvny0142d7zy0rh5hl8j4r3y8rkj2p";
  };
  "testing/gtest" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/google/googletest.git";
    rev = "6f8a66431cb592dad629028a50b3dd418a408c87";
    sha256 = "0bdba2lr6pg15bla9600zg0r0vm4lnrx0wqz84p376wfdxra24vw";
  };
  "third_party/icu" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/icu.git";
    rev = "ed402a5ce032d31570740f8c71918efad577e5d2";
    sha256 = "11svbnl6xbrqm41phnvb3jgyg1divy2bggqpppl4ajhqyii0mqlv";
  };
  "third_party/colorama/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/colorama.git";
    rev = "799604a1041e9b3bc5d2789ecbd7e8db2e18e6b8";
    sha256 = "0pq80idlwfm7c2xz3ssjr1rg28rdlhqyss0bfpm595v4wh5s2v37";
  };
  "tools/swarming_client" = fetchgit {
    url = "https://chromium.googlesource.com/external/swarming.client.git";
    rev = "df6e95e7669883c8fe9ef956c69a544154701a49";
    sha256 = "13q33d6jg9pdyd5bdl7b9ihbsx3m4xkyvma8q2r0bf1i6fljw1ff";
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
    rev = "f07246f6a06d5cb90d4e3b16c3fb9170ea863d4a";
    sha256 = "0pijhxs6kkzrdkbqvydz3cb7q480m8a1iw11y9fc92dwik4q2in0";
  };
  "third_party/boringssl/src" = fetchgit {
    url = "https://boringssl.googlesource.com/boringssl.git";
    rev = "54092ffeaa80ed032a50b914f14e3aa41de763df";
    sha256 = "0xiryfnz5ky54riq9c2bmfklpr6vvdrjkwi2kashslqv0z14q895";
  };
  "third_party/google_toolbox_for_mac/src" = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/google/google-toolbox-for-mac.git";
    rev = "401878398253074c515c03cb3a3f8bb0cc8da6e9";
    sha256 = "0q3c4lcp9gcp7cc9nsq50ahz63dazdp897g45jckd8fyml1z8cxn";
  };
  "third_party/lighttpd" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/lighttpd.git";
    rev = "9dfa55d15937a688a92cbf2b7a8621b0927d06eb";
    sha256 = "1bbpdc5b55a803y897af9zgyh6qci65gvzkc82bkr4qdqy7w9zzm";
  };
  "chrome/installer/mac/third_party/xz/xz" = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/xz.git";
    rev = "eecaf55632ca72e90eb2641376bce7cdbc7284f7";
    sha256 = "199xxjrn6xsaphw9fmbxg8nx507hiqfcsnq02wzw454vmylxq1ic";
  };
}
