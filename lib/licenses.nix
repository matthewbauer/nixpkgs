{ lib }:
let

  spdx = lic: lic // {
    url = "http://spdx.org/licenses/${lic.spdxId}.html";
  };

in

/*

  A quick list of license restrictions that can affect evaluation of
  Nixpkgs. Note that some of these restrictions may not be enforceable
  in your jurisdictions. This is irrelevant to Nixpkgs, however. We
  will enforce the copyright holder’s wishes regardless of court
  decisions.

    - free: If true, this license meets the FSF definition of free
            software.

    - redistributable: If true, we can legally redistribute this
                       software in the Nix binary cache. This is
                       always true for free licenses.

    - copyleft: If true, this license is *strong* copyleft. No
                references to it can come to software from another
                license. Weak copleft licenses should considered not
                copyleft for Nix’s purposes.

    - commercial: Whether software under this license can be used
                       for commercial usage. For free licenses, this
                       is alway true.

    - modifiable: Whether it is okay to modify this copyrighted work.
                  This is always true for free licenses.

    - attribution: Whether you need to attribute the author to modify
                   this work. This is always false for free licenses.

 */

 /* Note that custom licenses which are only used for one package in
    Nixpkgs should probably not be here. Instead the license
    definition should be put directly into meta.license. */

lib.mapAttrs (n: v: v // {
  shortName = n;
} // lib.optionalAttrs ((v.modifiable or false) == false) {
  attribution = false;
} // lib.optionalAttrs ((v.free or false) == true) {
  redistributable = true;
  commercial = true;
  modifiable = true;
  attribution = false;
}) rec {

  /* License identifiers from spdx.org where possible. If you cannot
     find your license here, then look for a similar license or add it
     to this list. The URL mentioned above is a good source for
     inspiration.
   */

  afl21 = spdx {
    spdxId = "AFL-2.1";
    fullName = "Academic Free License v2.1";

    free = true;
    copyleft = false;
  };

  afl3 = spdx {
    spdxId = "AFL-3.0";
    fullName = "Academic Free License v3.0";

    free = true;
    copyleft = false;
  };

  agpl3 = spdx {
    spdxId = "AGPL-3.0-only";
    fullName = "GNU Affero General Public License v3.0 only";

    free = true;
    copyleft = true;
  };

  agpl3Plus = agpl3 // {
    spdxId = "AGPL-3.0-or-later";
    fullName = "GNU Affero General Public License v3.0 or later";
  };

  amazonsl = {
    fullName = "Amazon Software License";
    url = http://aws.amazon.com/asl/;

    free = false;
    redistributable = true;
    commercial = true;
    modifiable = true;
    attribution = true;
  };

  amd = {
    fullName = "AMD License Agreement";
    url = http://developer.amd.com/amd-license-agreement/;

    free = false;
    redistributable = false;
    commercial = false;
    modifiable = false;
  };

  apsl20 = spdx {
    spdxId = "APSL-2.0";
    fullName = "Apple Public Source License 2.0";

    free = true;
    copyleft = false;
  };

  arphicpl = {
    fullName = "Arphic Public License";
    url = https://www.freedesktop.org/wiki/Arphic_Public_License/;

    free = true;
    copyleft = true;
  };

  artistic1 = spdx {
    spdxId = "Artistic-1.0";
    fullName = "Artistic License 1.0";

    free = false; # many passages restrict user’s freedom, corrected
                  # by the artistic 2.0 license
    copyleft = false;
  };

  artistic2 = spdx {
    spdxId = "Artistic-2.0";
    fullName = "Artistic License 2.0";

    free = true;
    copyleft = false;
  };

  asl20 = spdx {
    spdxId = "Apache-2.0";
    fullName = "Apache License 2.0";

    free = true;
    copyleft = false;
  };

  boost = spdx {
    spdxId = "BSL-1.0";
    fullName = "Boost Software License 1.0";

    free = true;
    copyleft = false;
  };

  beerware = spdx {
    spdxId = "Beerware";
    fullName = ''Beerware License'';

    free = true;
    copyleft = false;
  };

  bsd0 = spdx {
    spdxId = "0BSD";
    fullName = "BSD Zero Clause License";

    free = true;
    copyleft = false;
  };

  bsd2 = spdx {
    spdxId = "BSD-2-Clause";
    fullName = ''BSD 2-clause "Simplified" License'';

    free = true;
    copyleft = false;
  };

  bsd3 = spdx {
    spdxId = "BSD-3-Clause";
    fullName = ''BSD 3-clause "New" or "Revised" License'';

    free = true;
    copyleft = false;
  };

  bsdOriginal = spdx {
    spdxId = "BSD-4-Clause";
    fullName = ''BSD 4-clause "Original" or "Old" License'';

    free = true;
    copyleft = false;
  };

  bsl11 = {
    fullName = "Business Source License 1.1";
    url = https://mariadb.com/bsl11;

    free = false; # subject to ‘change date’
    copyleft = true;
    redistributable = true;
    commercial = false;
    modifiable = true;
    attribution = true;
  };

  clArtistic = spdx {
    spdxId = "ClArtistic";
    fullName = "Clarified Artistic License";

    free = true;
    copyleft = false;
  };

  cc0 = spdx {
    spdxId = "CC0-1.0";
    fullName = "Creative Commons Zero v1.0 Universal";

    free = true;
    copyleft = false;
  };

  cc-by-nc-sa-20 = spdx {
    spdxId = "CC-BY-NC-SA-2.0";
    fullName = "Creative Commons Attribution Non Commercial Share Alike 2.0";

    free = false;
    copyleft = true;
    redistributable = true;
    commercial = false;
    modifiable = true;
    attribution = true;
  };

  cc-by-nc-sa-25 = spdx (cc-by-nc-sa-20 // {
    spdxId = "CC-BY-NC-SA-2.5";
    fullName = "Creative Commons Attribution Non Commercial Share Alike 2.5";
  });

  cc-by-nc-sa-30 = spdx (cc-by-nc-sa-20 // {
    spdxId = "CC-BY-NC-SA-3.0";
    fullName = "Creative Commons Attribution Non Commercial Share Alike 3.0";
  });

  cc-by-nc-sa-40 = spdx (cc-by-nc-sa-20 // {
    spdxId = "CC-BY-NC-SA-4.0";
    fullName = "Creative Commons Attribution Non Commercial Share Alike 4.0";
  });

  cc-by-nc-40 = spdx (cc-by-nc-sa-20 // {
    spdxId = "CC-BY-NC-4.0";
    fullName = "Creative Commons Attribution Non Commercial 4.0 International";
  });

  cc-by-nd-30 = spdx {
    spdxId = "CC-BY-ND-3.0";
    fullName = "Creative Commons Attribution-No Derivative Works v3.00";

    free = false;
    copyleft = false;
    redistributable = true;
    commercial = true;
    modifiable = false;
  };

  cc-by-sa-25 = spdx {
    spdxId = "CC-BY-SA-2.5";
    fullName = "Creative Commons Attribution Share Alike 2.5";

    free = false;
    copyleft = true;
    redistributable = true;
    commercial = true;
    modifiable = true;
    attribution = true;
  };

  cc-by-30 = spdx {
    spdxId = "CC-BY-3.0";
    fullName = "Creative Commons Attribution 3.0";

    free = false;
    copyleft = false;
    redistributable = true;
    commercial = true;
    modifiable = true;
    attribution = true;
  };

  cc-by-40 = spdx (cc-by-30 // {
    spdxId = "CC-BY-4.0";
    fullName = "Creative Commons Attribution 4.0";
  });

  cc-by-sa-30 = spdx {
    spdxId = "CC-BY-SA-3.0";
    fullName = "Creative Commons Attribution Share Alike 3.0";

    free = false;
    copyleft = true;
    redistributable = true;
    commercial = true;
    modifiable = true;
    attribution = true;
  };

  cc-by-sa-40 = spdx (cc-by-sa-30 // {
    spdxId = "CC-BY-SA-4.0";
    fullName = "Creative Commons Attribution Share Alike 4.0";
  });

  cddl = spdx {
    spdxId = "CDDL-1.0";
    fullName = "Common Development and Distribution License 1.0";

    free = true;
    copyleft = false;
  };

  cecill20 = spdx {
    spdxId = "CECILL-2.0";
    fullName = "CeCILL Free Software License Agreement v2.0";

    free = true;
    copyleft = true;
  };

  cecill-b = spdx {
    spdxId = "CECILL-B";
    fullName  = "CeCILL-B Free Software License Agreement";

    free = true;
    copyleft = false;
  };

  cecill-c = spdx {
    spdxId = "CECILL-C";
    fullName  = "CeCILL-C Free Software License Agreement";

    free = true;
    copyleft = false;
  };

  cpal10 = spdx {
    spdxId = "CPAL-1.0";
    fullName = "Common Public Attribution License 1.0";

    free = true;
    copyleft = false;
  };

  cpl10 = spdx {
    spdxId = "CPL-1.0";
    fullName = "Common Public License 1.0";

    free = true;
    copyleft = false;
  };

  doc = spdx {
    spdxId = "DOC";
    fullName = "DOC License";

    free = false;
    copyleft = false;
    redistributable = true;
    commercial = true;
    modifiable = true;
    attribution = false;
  };

  eapl = {
    fullName = "EPSON AVASYS PUBLIC LICENSE";
    url = http://avasys.jp/hp/menu000000700/hpg000000603.htm;
    free = false;
  };

  efl10 = spdx {
    spdxId = "EFL-1.0";
    fullName = "Eiffel Forum License v1.0";
  };

  efl20 = spdx {
    spdxId = "EFL-2.0";
    fullName = "Eiffel Forum License v2.0";
  };

  epl10 = spdx {
    spdxId = "EPL-1.0";
    fullName = "Eclipse Public License 1.0";
  };

  epl20 = spdx {
    spdxId = "EPL-2.0";
    fullName = "Eclipse Public License 2.0";
  };

  epson = {
    fullName = "Seiko Epson Corporation Software License Agreement for Linux";
    url = https://download.ebz.epson.net/dsc/du/02/eula/global/LINUX_EN.html;
    free = false;
  };

  eupl11 = spdx {
    spdxId = "EUPL-1.1";
    fullName = "European Union Public License 1.1";
  };

  fdl12 = spdx {
    spdxId = "GFDL-1.2";
    fullName = "GNU Free Documentation License v1.2";
  };

  fdl13 = spdx {
    spdxId = "GFDL-1.3";
    fullName = "GNU Free Documentation License v1.3";
  };

  ffsl = {
    fullName = "Floodgap Free Software License";
    url = http://www.floodgap.com/software/ffsl/license.html;
    free = false;
  };

  free = {
    fullName = "Unspecified free software license";

    free = true;
    copyleft = false;
  };

  g4sl = {
    fullName = "Geant4 Software License";
    url = https://geant4.web.cern.ch/geant4/license/LICENSE.html;
  };

  geogebra = {
    fullName = "GeoGebra Non-Commercial License Agreement";
    url = https://www.geogebra.org/license;

    free = false;
  };

  gpl1 = spdx {
    spdxId = "GPL-1.0";
    fullName = "GNU General Public License v1.0 only";

    free = true;
    copyleft = true;
  };

  gpl1Plus = spdx {
    spdxId = "GPL-1.0+";
    fullName = "GNU General Public License v1.0 or later";

    free = true;
    copyleft = true;
  };

  gpl2 = spdx {
    spdxId = "GPL-2.0";
    fullName = "GNU General Public License v2.0 only";

    free = true;
    copyleft = true;
  };

  gpl2ClasspathPlus = {
    fullName = "GNU General Public License v2.0 or later (with Classpath exception)";
    url = https://fedoraproject.org/wiki/Licensing/GPL_Classpath_Exception;

    free = true;
    copyleft = false;
  };

  gpl2Oss = {
    fullName = "GNU General Public License version 2 only (with OSI approved licenses linking exception)";
    url = https://www.mysql.com/about/legal/licensing/foss-exception;

    free = true;
    copyleft = false;
  };

  gpl2Plus = spdx {
    spdxId = "GPL-2.0+";
    fullName = "GNU General Public License v2.0 or later";

    free = true;
    copyleft = true;
  };

  gpl3 = spdx {
    spdxId = "GPL-3.0";
    fullName = "GNU General Public License v3.0 only";

    free = true;
    copyleft = true;
  };

  gpl3Plus = spdx {
    spdxId = "GPL-3.0+";
    fullName = "GNU General Public License v3.0 or later";

    free = true;
    copyleft = true;
  };

  gpl3ClasspathPlus = {
    fullName = "GNU General Public License v3.0 or later (with Classpath exception)";
    url = https://fedoraproject.org/wiki/Licensing/GPL_Classpath_Exception;

    free = true;
    copyleft = false;
  };

  hpnd = spdx {
    spdxId = "HPND";
    fullName = "Historic Permission Notice and Disclaimer";

    free = true;
    copyleft = false;
  };

  # Intel's license, seems free
  iasl = {
    fullName = "iASL";
    url = http://www.calculate-linux.org/packages/licenses/iASL;
  };

  ijg = spdx {
    spdxId = "IJG";
    fullName = "Independent JPEG Group License";
  };

  inria-compcert = {
    fullName  = "INRIA Non-Commercial License Agreement for the CompCert verified compiler";
    url       = "http://compcert.inria.fr/doc/LICENSE";
    free      = false;
  };

  inria-icesl = {
    fullName = "INRIA Non-Commercial License Agreement for IceSL";
    url      = "http://shapeforge.loria.fr/icesl/EULA_IceSL_binary.pdf";
    free     = false;
  };

  ipa = spdx {
    spdxId = "IPA";
    fullName = "IPA Font License";
  };

  ipl10 = spdx {
    spdxId = "IPL-1.0";
    fullName = "IBM Public License v1.0";
  };

  isc = spdx {
    spdxId = "ISC";
    fullName = "ISC License";
  };

  lgpl2 = spdx {
    spdxId = "LGPL-2.0";
    fullName = "GNU Library General Public License v2 only";

    free = true;
    copyleft = false;
  };

  lgpl2Plus = spdx {
    spdxId = "LGPL-2.0+";
    fullName = "GNU Library General Public License v2 or later";

    free = true;
    copyleft = false;
  };

  lgpl21 = spdx {
    spdxId = "LGPL-2.1";
    fullName = "GNU Library General Public License v2.1 only";

    free = true;
    copyleft = false;
  };

  lgpl21Plus = spdx {
    spdxId = "LGPL-2.1+";
    fullName = "GNU Library General Public License v2.1 or later";

    free = true;
    copyleft = false;
  };

  lgpl3 = spdx {
    spdxId = "LGPL-3.0";
    fullName = "GNU Lesser General Public License v3.0 only";

    free = true;
    copyleft = false;
  };

  lgpl3Plus = spdx {
    spdxId = "LGPL-3.0+";
    fullName = "GNU Lesser General Public License v3.0 or later";

    free = true;
    copyleft = false;
  };

  libpng = spdx {
    spdxId = "Libpng";
    fullName = "libpng License";
  };

  libtiff = spdx {
    spdxId = "libtiff";
    fullName = "libtiff License";
  };

  llgpl21 = {
    fullName = "Lisp LGPL; GNU Lesser General Public License version 2.1 with Franz Inc. preamble for clarification of LGPL terms in context of Lisp";
    url = http://opensource.franz.com/preamble.html;

    free = true;
    copyleft = false;
  };

  lppl12 = spdx {
    spdxId = "LPPL-1.2";
    fullName = "LaTeX Project Public License v1.2";
  };

  lppl13c = spdx {
    spdxId = "LPPL-1.3c";
    fullName = "LaTeX Project Public License v1.3c";
  };

  lpl-102 = spdx {
    spdxId = "LPL-1.02";
    fullName = "Lucent Public License v1.02";
  };

  miros = {
    fullName = "MirOS License";
    url = https://opensource.org/licenses/MirOS;
  };

  # spdx.org does not (yet) differentiate between the X11 and Expat versions
  # for details see http://en.wikipedia.org/wiki/MIT_License#Various_versions
  mit = spdx {
    spdxId = "MIT";
    fullName = "MIT License";
  };

  mpl10 = spdx {
    spdxId = "MPL-1.0";
    fullName = "Mozilla Public License 1.0";
  };

  mpl11 = spdx {
    spdxId = "MPL-1.1";
    fullName = "Mozilla Public License 1.1";
  };

  mpl20 = spdx {
    spdxId = "MPL-2.0";
    fullName = "Mozilla Public License 2.0";
  };

  mspl = spdx {
    spdxId = "MS-PL";
    fullName = "Microsoft Public License";
  };

  msrla = {
    fullName  = "Microsoft Research License Agreement";
    url       = "http://research.microsoft.com/en-us/projects/pex/msr-la.txt";
    free = false;
  };

  ncsa = spdx {
    spdxId = "NCSA";
    fullName  = "University of Illinois/NCSA Open Source License";
  };

  notion_lgpl = {
    url = "https://raw.githubusercontent.com/raboof/notion/master/LICENSE";
    fullName = "Notion modified LGPL";
  };

  nposl3 = spdx {
    spdxId = "NPOSL-3.0";
    fullName = "Non-Profit Open Software License 3.0";
  };

  ofl = spdx {
    spdxId = "OFL-1.1";
    fullName = "SIL Open Font License 1.1";
  };

  openldap = spdx {
    spdxId = "OLDAP-2.8";
    fullName = "Open LDAP Public License v2.8";

    free = false;
    redistributable = true;
    commercial = true;
    modifiable = true;
    attribution = false;
  };

  openssl = spdx {
    spdxId = "OpenSSL";
    fullName = "OpenSSL License";

    free = true;
    copyleft = false;
  };

  osl21 = spdx {
    spdxId = "OSL-2.1";
    fullName = "Open Software License 2.1";

    free = true;
    copyleft = false;
  };

  osl3 = spdx {
    spdxId = "OSL-3.0";
    fullName = "Open Software License 3.0";

    free = true;
    copyleft = false;
  };

  php301 = spdx {
    spdxId = "PHP-3.01";
    fullName = "PHP License v3.01";

    free = true;
    copyleft = false;
  };

  postgresql = spdx {
    spdxId = "PostgreSQL";
    fullName = "PostgreSQL License";

    free = false;
    redistributable = true;
    commercial = true;
    modifiable = true;
    attribution = false;
  };

  psfl = spdx {
    spdxId = "Python-2.0";
    fullName = "Python Software Foundation License version 2";

    free = true;
    copyleft = false;
  };

  publicDomain = {
    fullName = "Public Domain";

    free = true;
    copyleft = false;
  };

  qpl = spdx {
    spdxId = "QPL-1.0";
    fullName = "Q Public License 1.0";

    free = true;
    copyleft = false;
  };

  qwt = {
    fullName = "Qwt License, Version 1.0";
    url = http://qwt.sourceforge.net/qwtlicense.html;

    free = true;
    copyleft = false;
  };

  ruby = spdx {
    spdxId = "Ruby";
    fullName = "Ruby License";

    free = true;
    copyleft = false;
  };

  sgi-b-20 = spdx {
    spdxId = "SGI-B-2.0";
    fullName = "SGI Free Software License B v2.0";

    free = true;
    copyleft = false;
  };

  sleepycat = spdx {
    spdxId = "Sleepycat";
    fullName = "Sleepycat License";

    free = true;
    copyleft = true;
  };

  tcltk = spdx {
    spdxId = "TCL";
    fullName = "TCL/TK License";

    free = false;
    redistributable = true;
    commercial = true;
    modifiable = true;
  };

  ufl = {
    fullName = "Ubuntu Font License 1.0";
    url = https://assets.ubuntu.com/v1/81e5605d-ubuntu-font-licence-1.0.txt;

    free = false;
    redistributable = true;
    commercial = true;
    modifiable = true;
  };

  unfree = {
    fullName = "Unfree";

    free = false;
    redistributable = false;
    commercial = true;
    modifiable = false;
  };

  unfreeRedistributable = {
    fullName = "Unfree redistributable";

    free = false;
    redistributable = true;
    commercial = true;
    modifiable = false;
  };

  unfreeNoncommercial = {
    fullName = "Unfree redistributable";

    free = false;
    redistributable = true;
    commercial = false;
    modifiable = false;
  };

  unlicense = spdx {
    spdxId = "Unlicense";
    fullName = "The Unlicense";

    free = true;
    copyleft = false;
  };

  upl = {
    fullName = "Universal Permissive License";
    url = "https://oss.oracle.com/licenses/upl/";

    free = true;
    copyleft = false;
  };

  vim = spdx {
    spdxId = "Vim";
    fullName = "Vim License";

    free = true;
    copyleft = false;
  };

  vsl10 = spdx {
    spdxId = "VSL-1.0";
    fullName = "Vovida Software License v1.0";
  };

  watcom = spdx {
    spdxId = "Watcom-1.0";
    fullName = "Sybase Open Watcom Public License 1.0";
  };

  w3c = spdx {
    spdxId = "W3C";
    fullName = "W3C Software Notice and License";

    free = false;
    copyleft = false;
  };

  wadalab = {
    fullName = "Wadalab Font License";
    url = https://fedoraproject.org/wiki/Licensing:Wadalab?rd=Licensing/Wadalab;
  };

  wtfpl = spdx {
    spdxId = "WTFPL";
    fullName = "Do What The F*ck You Want To Public License";

    free = true;
    copyleft = false;
  };

  wxWindows = spdx {
    spdxId = "WXwindows";
    fullName = "wxWindows Library Licence, Version 3.1";

    free = true;
    copyleft = false;
  };

  zlib = spdx {
    spdxId = "Zlib";
    fullName = "zlib License";

    free = true;
    copyleft = false;
  };

  zpl20 = spdx {
    spdxId = "ZPL-2.0";
    fullName = "Zope Public License 2.0";

    free = true;
    copyleft = false;
  };

  zpl21 = spdx {
    spdxId = "ZPL-2.1";
    fullName = "Zope Public License 2.1";

    free = true;
    copyleft = false;
  };
}
