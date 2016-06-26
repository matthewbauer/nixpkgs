{stdenv, sdk, writeText, platformName}:

let

Info = writeText "Info.plist" ''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Identifier</key>
<string>${platformName}</string>
<key>Name</key>
<string>${platformName}</string>
<key>Version</key>
<string>1.1</string>
<key>DefaultProperties</key>
<dict>
<key>DEFAULT_COMPILER</key>
<string>com.apple.compilers.llvm.clang.1_0</string>
<key>DEPLOYMENT_TARGET_CLANG_ENV_NAME</key>
<string>MACOSX_DEPLOYMENT_TARGET</string>
<key>DEPLOYMENT_TARGET_CLANG_FLAG_NAME</key>
<string>mmacosx-version-min</string>
<key>DEPLOYMENT_TARGET_SETTING_NAME</key>
<string>MACOSX_DEPLOYMENT_TARGET</string>
<key>EMBEDDED_PROFILE_NAME</key>
<string>embedded.provisionprofile</string>
</dict>
<key>DTCompiler</key>
<string>com.apple.compilers.llvm.clang.1_0</string>
</dict>
</plist>
'';

Version = writeText "version.plist" ''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>BuildVersion</key>
<string>1</string>
<key>CFBundleShortVersionString</key>
<string>1.1</string>
<key>CFBundleVersion</key>
<string>10010</string>
<key>ProjectName</key>
<string>OSXPlatformSupport</string>
<key>SourceVersion</key>
<string>10010000000000000</string>
</dict>
</plist>
'';

NativeBuildSystem = writeText "NativeBuildSystem.xcspec" ''
{
    Type = BuildSystem;
    Identifier = com.apple.build-system.native;
    BasedOn = "default:com.apple.build-system.native";
    Name = "Native Build System";
    Properties = ();
}
'';

CoreBuildSystem = writeText "CoreBuildSystem.xcspec" ''
{
    Type = BuildSystem;
    Identifier = com.apple.build-system.core;
    BasedOn = "com.apple.buildsettings.standard";
    Name = "Core Build System";
    IsGlobalDomainInUI = Yes;
    Properties = ();
}
'';

Architectures = writeText "Architectures.xcspec" ''
(
	{
		Type = Architecture;
		Identifier = Standard;
		Name = "Standard Architectures (64-bit Intel)";
		ListInEnum = YES;
		SortNumber = 0;
		RealArchitectures = (
			"x86_64",
		);
		ArchitectureSetting = "ARCHS_STANDARD";
	},
)
'';

PackageTypes = writeText "PackageTypes.xcspec" ''
(
    // Mach-O executable
    {   Type = PackageType;
        Identifier = com.apple.package-type.mach-o-executable;
        Name = "Mach-O Executable";
        Description = "Mach-O executable";
        DefaultBuildSettings = {
            EXECUTABLE_PREFIX = "";
            EXECUTABLE_SUFFIX = "";
            EXECUTABLE_NAME = "$(EXECUTABLE_PREFIX)$(PRODUCT_NAME)$(EXECUTABLE_VARIANT_SUFFIX)$(EXECUTABLE_SUFFIX)";
            EXECUTABLE_PATH = "$(EXECUTABLE_NAME)";
        };
        ProductReference = {
            FileType = compiled.mach-o.executable;
            Name = "$(EXECUTABLE_NAME)";
            IsLaunchable = YES;
        };
    },

    // Mach-O object file
    {   Type = PackageType;
        Identifier = com.apple.package-type.mach-o-objfile;
        Name = "Mach-O Object File";
        Description = "Mach-O Object File";
        DefaultBuildSettings = {
            EXECUTABLE_PREFIX = "";
            EXECUTABLE_SUFFIX = "";
            EXECUTABLE_NAME = "$(EXECUTABLE_PREFIX)$(PRODUCT_NAME)$(EXECUTABLE_VARIANT_SUFFIX)$(EXECUTABLE_SUFFIX)";
            EXECUTABLE_PATH = "$(EXECUTABLE_NAME)";
        };
        ProductReference = {
            FileType = compiled.mach-o.objfile;
            Name = "$(EXECUTABLE_NAME)";
            IsLaunchable = NO;
        };
    },

    // Mach-O dynamic library
    {   Type = PackageType;
        Identifier = com.apple.package-type.mach-o-dylib;
        Name = "Mach-O Dynamic Library";
        Description = "Mach-O dynamic library";
        DefaultBuildSettings = {
            EXECUTABLE_PREFIX = "";
            EXECUTABLE_SUFFIX = "";
            EXECUTABLE_NAME = "$(EXECUTABLE_PREFIX)$(PRODUCT_NAME)$(EXECUTABLE_VARIANT_SUFFIX)$(EXECUTABLE_SUFFIX)";
            EXECUTABLE_PATH = "$(EXECUTABLE_NAME)";
        };
        ProductReference = {
            FileType = compiled.mach-o.dylib;
            Name = "$(EXECUTABLE_NAME)";
            IsLaunchable = NO;
        };
    },

    // Static library ('ar' archive containing .o files)
    {   Type = PackageType;
        Identifier = com.apple.package-type.static-library;
        Name = "Mach-O Static Library";
        Description = "Mach-O static library";
        DefaultBuildSettings = {
            EXECUTABLE_PREFIX = "lib";
            EXECUTABLE_SUFFIX = ".a";
            EXECUTABLE_NAME = "$(EXECUTABLE_PREFIX)$(PRODUCT_NAME)$(EXECUTABLE_VARIANT_SUFFIX)$(EXECUTABLE_SUFFIX)";
            EXECUTABLE_PATH = "$(EXECUTABLE_NAME)";
        };
        ProductReference = {
            FileType = archive.ar;
            Name = "$(EXECUTABLE_NAME)";
            IsLaunchable = NO;
        };
    },

    // Mach-O bundle (not related to a CFBundle)
    {   Type = PackageType;
        Identifier = com.apple.package-type.mach-o-bundle;
        Name = "Mach-O Loadable";
        Description = "Mach-O loadable";
        DefaultBuildSettings = {
            EXECUTABLE_PREFIX = "";
            EXECUTABLE_SUFFIX = ".dylib";
            EXECUTABLE_NAME = "$(EXECUTABLE_PREFIX)$(PRODUCT_NAME)$(EXECUTABLE_VARIANT_SUFFIX)$(EXECUTABLE_SUFFIX)";
            EXECUTABLE_PATH = "$(EXECUTABLE_NAME)";
        };
        ProductReference = {
            FileType = compiled.mach-o.bundle;
            Name = "$(EXECUTABLE_NAME)";
            IsLaunchable = NO;
        };
    },

    // CFBundle wrapper
    {   Type = PackageType;
        Identifier = com.apple.package-type.wrapper;
        Name = "Wrapper";
        Description = "Wrapper";
        DefaultBuildSettings = {
            WRAPPER_PREFIX = "";
            WRAPPER_SUFFIX = ".bundle";
            WRAPPER_NAME = "$(WRAPPER_PREFIX)$(PRODUCT_NAME)$(WRAPPER_SUFFIX)";
            CONTENTS_FOLDER_PATH = "$(WRAPPER_NAME)/Contents";
            EXECUTABLE_PREFIX = "";
            EXECUTABLE_SUFFIX = "";
            EXECUTABLE_NAME = "$(EXECUTABLE_PREFIX)$(PRODUCT_NAME)$(EXECUTABLE_VARIANT_SUFFIX)$(EXECUTABLE_SUFFIX)";
            EXECUTABLE_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/MacOS";
            EXECUTABLE_PATH = "$(EXECUTABLE_FOLDER_PATH)/$(EXECUTABLE_NAME)";
            INFOPLIST_PATH = "$(CONTENTS_FOLDER_PATH)/Info.plist";
            INFOSTRINGS_PATH = "$(LOCALIZED_RESOURCES_FOLDER_PATH)/InfoPlist.strings";
            PKGINFO_PATH = "$(CONTENTS_FOLDER_PATH)/PkgInfo";
            PBDEVELOPMENTPLIST_PATH = "$(CONTENTS_FOLDER_PATH)/pbdevelopment.plist";
            VERSIONPLIST_PATH = "$(CONTENTS_FOLDER_PATH)/version.plist";
            PUBLIC_HEADERS_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/Headers";
            PRIVATE_HEADERS_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/PrivateHeaders";
            EXECUTABLES_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/Executables";               // Not the same as EXECUTABLE_FOLDER_PATH
            FRAMEWORKS_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/Frameworks";
            SHARED_FRAMEWORKS_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/SharedFrameworks";
            SHARED_SUPPORT_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/SharedSupport";
            UNLOCALIZED_RESOURCES_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/Resources";
            LOCALIZED_RESOURCES_FOLDER_PATH = "$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/$(DEVELOPMENT_LANGUAGE).lproj";
            DOCUMENTATION_FOLDER_PATH = "$(LOCALIZED_RESOURCES_FOLDER_PATH)/Documentation";
            PLUGINS_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/PlugIns";
            SCRIPTS_FOLDER_PATH = "$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/Scripts";
            JAVA_FOLDER_PATH = "$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/Java";
        };
        ProductReference = {
            FileType = wrapper.cfbundle;
            Name = "$(WRAPPER_NAME)";
            IsLaunchable = NO;
        };
    },

    // Shallow CFBundle wrapper
    {   Type = PackageType;
        Identifier = com.apple.package-type.wrapper.shallow;
        BasedOn = com.apple.package-type.wrapper;
        Name = "Wrapper (Shallow)";
        Description = "Shallow Wrapper";
        DefaultBuildSettings = {
            CONTENTS_FOLDER_PATH = "$(WRAPPER_NAME)";
            EXECUTABLE_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)";
            UNLOCALIZED_RESOURCES_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)";
            SHALLOW_BUNDLE = YES;
        };
        ProductReference = {
            FileType = wrapper.cfbundle;
            Name = "$(WRAPPER_NAME)";
            IsLaunchable = NO;
        };
    },

    // Application wrapper
    {   Type = PackageType;
        Identifier = com.apple.package-type.wrapper.application;
        BasedOn = com.apple.package-type.wrapper;
        Name = "Application Wrapper";
        Description = "Application Wrapper";
        DefaultBuildSettings = {
            GENERATE_PKGINFO_FILE = YES;
        };
        ProductReference = {
            FileType = wrapper.application;
            Name = "$(WRAPPER_NAME)";
            IsLaunchable = YES;
        };
    },

    // Shallow Application wrapper
    {   Type = PackageType;
        Identifier = com.apple.package-type.wrapper.application.shallow;
        BasedOn = com.apple.package-type.wrapper.shallow;
        Name = "Application Wrapper (Shallow)";
        Description = "Shallow Application Wrapper";
        DefaultBuildSettings = {
            UNLOCALIZED_RESOURCES_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)";
            GENERATE_PKGINFO_FILE = YES;
            SHALLOW_BUNDLE = YES;
        };
        ProductReference = {
            FileType = wrapper.application;
            Name = "$(WRAPPER_NAME)";
            IsLaunchable = YES;
        };
    },

    // Framework wrapper
    {   Type = PackageType;
        Identifier = com.apple.package-type.wrapper.framework;
        Name = "Framework Wrapper";
        Description = "Framework wrapper";
        DefaultBuildSettings = {
            WRAPPER_PREFIX = "";
            WRAPPER_SUFFIX = ".framework";
            WRAPPER_NAME = "$(WRAPPER_PREFIX)$(PRODUCT_NAME)$(WRAPPER_SUFFIX)";
            VERSIONS_FOLDER_PATH = "$(WRAPPER_NAME)/Versions";
            CONTENTS_FOLDER_PATH = "$(VERSIONS_FOLDER_PATH)/$(FRAMEWORK_VERSION)";
            CURRENT_VERSION = "Current";
            EXECUTABLE_PREFIX = "";
            EXECUTABLE_SUFFIX = "";
            EXECUTABLE_NAME = "$(EXECUTABLE_PREFIX)$(PRODUCT_NAME)$(EXECUTABLE_VARIANT_SUFFIX)$(EXECUTABLE_SUFFIX)";
            EXECUTABLE_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)";
            EXECUTABLE_PATH = "$(EXECUTABLE_FOLDER_PATH)/$(EXECUTABLE_NAME)";
            INFOPLIST_PATH = "$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/Info.plist";
            INFOPLISTSTRINGS_PATH = "$(LOCALIZED_RESOURCES_FOLDER_PATH)/InfoPlist.strings";
            PKGINFO_PATH = "$(WRAPPER_NAME)/PkgInfo";
            PBDEVELOPMENTPLIST_PATH = "$(CONTENTS_FOLDER_PATH)/pbdevelopment.plist";
            VERSIONPLIST_PATH = "$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/version.plist";
            PUBLIC_HEADERS_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/Headers";
            PRIVATE_HEADERS_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/PrivateHeaders";
            EXECUTABLES_FOLDER_PATH = "$(LOCALIZED_RESOURCES_FOLDER_PATH)";               // Not the same as EXECUTABLE_FOLDER_PATH
            FRAMEWORKS_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/Frameworks";
            SHARED_FRAMEWORKS_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/SharedFrameworks";
            SHARED_SUPPORT_FOLDER_PATH = "$(UNLOCALIZED_RESOURCES_FOLDER_PATH)";
            UNLOCALIZED_RESOURCES_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/Resources";
            LOCALIZED_RESOURCES_FOLDER_PATH = "$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/$(DEVELOPMENT_LANGUAGE).lproj";
            DOCUMENTATION_FOLDER_PATH = "$(LOCALIZED_RESOURCES_FOLDER_PATH)/Documentation";
            PLUGINS_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)/PlugIns";
            SCRIPTS_FOLDER_PATH = "$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/Scripts";
            JAVA_FOLDER_PATH = "$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/Java";
            CODESIGNING_FOLDER_PATH = "$(TARGET_BUILD_DIR)/$(CONTENTS_FOLDER_PATH)";
        };
        ProductReference = {
            FileType = wrapper.framework;
            Name = "$(WRAPPER_NAME)";
            IsLaunchable = NO;
        };
    },

    // Static framework wrapper (like a framework, except that it contains a libX.a instead of a dylib)
    {   Type = PackageType;
        Identifier = com.apple.package-type.wrapper.framework.static;
        Name = "Mach-O Static Framework";
        Description = "Mach-O static framework";
        BasedOn = com.apple.package-type.wrapper.framework;
        DefaultBuildSettings = {
            EXECUTABLE_PREFIX = "";
            EXECUTABLE_SUFFIX = "";
            EXECUTABLE_NAME = "$(EXECUTABLE_PREFIX)$(PRODUCT_NAME)$(EXECUTABLE_VARIANT_SUFFIX)$(EXECUTABLE_SUFFIX)";
        };
        ProductReference = {
            FileType = wrapper.framework.static;
            Name = "$(WRAPPER_NAME)";
            IsLaunchable = NO;
        };
    },

    // Shallow Framework Package
    {   Type = PackageType;
        Identifier = com.apple.package-type.wrapper.framework.shallow;
        Name = "Shallow Framework Wrapper";
        Description = "Shallow framework wrapper";
        BasedOn = com.apple.package-type.wrapper.framework;
        DefaultBuildSettings = {
            CONTENTS_FOLDER_PATH = "$(WRAPPER_NAME)";
            VERSIONS_FOLDER_PATH = "$(WRAPPER_NAME)";
            UNLOCALIZED_RESOURCES_FOLDER_PATH = "$(CONTENTS_FOLDER_PATH)";
            SHALLOW_BUNDLE = YES;
        };
        ProductReference = {
            FileType = wrapper.framework;
            Name = "$(WRAPPER_NAME)";
            IsLaunchable = NO;
        };
    },

    // Unit Test Bundle wrapper
    {   Type = PackageType;
        Identifier = com.apple.package-type.bundle.unit-test;
        BasedOn = com.apple.package-type.wrapper;
        Name = "Unit Test Bundle";
        Description = "Unit Test Bundle";
        DefaultBuildSettings = {
            WRAPPER_SUFFIX = "xctest";
        };
        ProductReference = {
            FileType = wrapper.cfbundle;
            Name = "$(WRAPPER_NAME)";
            IsLaunchable = NO;
        };
    },
)
'';

ProductTypes = writeText "ProductTypes.xcspec" ''
(
    //
    // Single-file product types
    //

    // Tool (normal Unix command-line executable)
    {   Type = ProductType;
        Identifier = com.apple.product-type.tool;
        Class = PBXToolProductType;
        Name = "Command-line Tool";
        Description = "Standalone command-line tool";
        IconNamePrefix = "TargetExecutable";
        DefaultTargetName = "Command-line Tool";
        DefaultBuildProperties = {
            FULL_PRODUCT_NAME = "$(EXECUTABLE_NAME)";
            EXECUTABLE_PREFIX = "";
            EXECUTABLE_SUFFIX = "";
            REZ_EXECUTABLE = YES;
            INSTALL_PATH = "/usr/local/bin";
            FRAMEWORK_FLAG_PREFIX = "-framework";
            LIBRARY_FLAG_PREFIX = "-l";
            LIBRARY_FLAG_NOSPACE = YES;
            GCC_DYNAMIC_NO_PIC = NO;
            GCC_SYMBOLS_PRIVATE_EXTERN = YES;
            GCC_INLINES_ARE_PRIVATE_EXTERN = YES;
            STRIP_STYLE = "all";
            CODE_SIGNING_ALLOWED = YES;
        };
        PackageTypes = (
            com.apple.package-type.mach-o-executable   // default
        );
    },

    // Object file
    {   Type = ProductType;
        Identifier = com.apple.product-type.objfile;
        Class = XCStandaloneExecutableProductType;
        Name = "Object File";
        Description = "Object File";
        IconNamePrefix = "TargetPlugin";
        DefaultTargetName = "Object File";
        DefaultBuildProperties = {
            FULL_PRODUCT_NAME = "$(EXECUTABLE_NAME)";
            MACH_O_TYPE = "mh_object";
            LINK_WITH_STANDARD_LIBRARIES = NO;
            REZ_EXECUTABLE = YES;
            EXECUTABLE_SUFFIX = ".$(EXECUTABLE_EXTENSION)";
            EXECUTABLE_EXTENSION = "o";
            PUBLIC_HEADERS_FOLDER_PATH = "/usr/local/include";
            PRIVATE_HEADERS_FOLDER_PATH = "/usr/local/include";
            INSTALL_PATH = "$(HOME)/Objects";
            FRAMEWORK_FLAG_PREFIX = "-framework";
            LIBRARY_FLAG_PREFIX = "-l";
            LIBRARY_FLAG_NOSPACE = YES;
            SKIP_INSTALL = YES;
            STRIP_STYLE = "debugging";
            GCC_INLINES_ARE_PRIVATE_EXTERN = YES;
            KEEP_PRIVATE_EXTERNS = YES;
            DEAD_CODE_STRIPPING = NO;
        };
        PackageTypes = (
            com.apple.package-type.mach-o-objfile   // default
        );
    },

    // Dynamic library
    {   Type = ProductType;
        Identifier = com.apple.product-type.library.dynamic;
        Class = PBXDynamicLibraryProductType;
        Name = "Dynamic Library";
        Description = "Dynamic library";
        IconNamePrefix = "TargetLibrary";
        DefaultTargetName = "Dynamic Library";
        DefaultBuildProperties = {
            FULL_PRODUCT_NAME = "$(EXECUTABLE_NAME)";
            MACH_O_TYPE = "mh_dylib";
            REZ_EXECUTABLE = YES;
            EXECUTABLE_SUFFIX = ".$(EXECUTABLE_EXTENSION)";
            EXECUTABLE_EXTENSION = "dylib";
            PUBLIC_HEADERS_FOLDER_PATH = "/usr/local/include";
            PRIVATE_HEADERS_FOLDER_PATH = "/usr/local/include";
            INSTALL_PATH = "/usr/local/lib";
            DYLIB_INSTALL_NAME_BASE = "$(INSTALL_PATH)";
            LD_DYLIB_INSTALL_NAME = "$(DYLIB_INSTALL_NAME_BASE:standardizepath)/$(EXECUTABLE_PATH)";
            DYLIB_COMPATIBILITY_VERSION = "1";
            DYLIB_CURRENT_VERSION = "1";
            FRAMEWORK_FLAG_PREFIX = "-framework";
            LIBRARY_FLAG_PREFIX = "-l";
            LIBRARY_FLAG_NOSPACE = YES;
            STRIP_STYLE = "debugging";
            GCC_INLINES_ARE_PRIVATE_EXTERN = YES;
            CODE_SIGNING_ALLOWED = YES;
        };
        PackageTypes = (
            com.apple.package-type.mach-o-dylib   // default
        );
    },

    // Static library
    {   Type = ProductType;
        Identifier = com.apple.product-type.library.static;
        Class = PBXStaticLibraryProductType;
        Name = "Static Library";
        Description = "Static library";
        IconNamePrefix = "TargetLibrary";
        DefaultTargetName = "Static Library";
        DefaultBuildProperties = {
            FULL_PRODUCT_NAME = "$(EXECUTABLE_NAME)";
            MACH_O_TYPE = "staticlib";
            REZ_EXECUTABLE = YES;
            EXECUTABLE_PREFIX = "lib";
            EXECUTABLE_SUFFIX = ".$(EXECUTABLE_EXTENSION)";
            EXECUTABLE_EXTENSION = "a";
            PUBLIC_HEADERS_FOLDER_PATH = "/usr/local/include";
            PRIVATE_HEADERS_FOLDER_PATH = "/usr/local/include";
            INSTALL_PATH = "/usr/local/lib";
            FRAMEWORK_FLAG_PREFIX = "-framework";
            LIBRARY_FLAG_PREFIX = "-l";
            LIBRARY_FLAG_NOSPACE = YES;
            STRIP_STYLE = "debugging";
            SEPARATE_STRIP = YES;
        };
        AlwaysPerformSeparateStrip = YES;
        PackageTypes = (
            com.apple.package-type.static-library   // default
        );
    },

    //
    // Wrapper product types
    //

    // Bundle
    {   Type = ProductType;
        Identifier = com.apple.product-type.bundle;
        Class = PBXBundleProductType;
        Name = "Bundle";
        Description = "Generic bundle";
        IconNamePrefix = "TargetPlugin";
        DefaultTargetName = "Bundle";
        DefaultBuildProperties = {
            FULL_PRODUCT_NAME = "$(WRAPPER_NAME)";
            MACH_O_TYPE = "mh_bundle";
            WRAPPER_PREFIX = "";
            WRAPPER_SUFFIX = ".$(WRAPPER_EXTENSION)";
            WRAPPER_EXTENSION = "bundle";
            WRAPPER_NAME = "$(WRAPPER_PREFIX)$(PRODUCT_NAME)$(WRAPPER_SUFFIX)";
            FRAMEWORK_FLAG_PREFIX = "-framework";
            LIBRARY_FLAG_PREFIX = "-l";
            LIBRARY_FLAG_NOSPACE = YES;
            STRIP_STYLE = "non-global";
            GCC_INLINES_ARE_PRIVATE_EXTERN = YES;
            CODE_SIGNING_ALLOWED = YES;
        };
        PackageTypes = (
            com.apple.package-type.wrapper,             // default
            com.apple.package-type.wrapper.shallow      // Not clear if this is needed in the presence of the Shallow Bundle product type below.
        );
        IsWrapper = YES;
        HasInfoPlist = YES;
        HasInfoPlistStrings = YES;
    },

    // Shallow Bundle Product
    {   Type = ProductType;
        Identifier = com.apple.product-type.bundle.shallow;
        BasedOn = com.apple.product-type.bundle;
        Class = PBXBundleProductType;
        Name = "Bundle (Shallow)";
        Description = "Bundle (Shallow)";
        PackageTypes = (
            com.apple.package-type.wrapper.shallow
        );
    },

    // Application
    {   Type = ProductType;
        Identifier = com.apple.product-type.application;
        BasedOn = com.apple.product-type.bundle;
        Class = PBXApplicationProductType;
        Name = "Application";
        Description = "Application";
        IconNamePrefix = "TargetApp";
        DefaultTargetName = "Application";
        DefaultBuildProperties = {
            MACH_O_TYPE = "mh_execute";
            GCC_DYNAMIC_NO_PIC = NO;
            GCC_SYMBOLS_PRIVATE_EXTERN = YES;
            GCC_INLINES_ARE_PRIVATE_EXTERN = YES;
            WRAPPER_SUFFIX = ".$(WRAPPER_EXTENSION)";
            WRAPPER_EXTENSION = "app";
            INSTALL_PATH = "$(LOCAL_APPS_DIR)";
            STRIP_STYLE = "all";
            CODE_SIGNING_ALLOWED = YES;
        };
        PackageTypes = (
            com.apple.package-type.wrapper.application  // default
        );
        CanEmbedAddressSanitizerLibraries = YES;
        RunpathSearchPathForEmbeddedFrameworks = "@executable_path/../Frameworks";
        ValidateEmbeddedBinaries = YES;
    },

    // Shallow Application Product
    {   Type = ProductType;
        Identifier = com.apple.product-type.application.shallow;
        BasedOn = com.apple.product-type.application;
        Class = PBXApplicationProductType;   // see radar 5604879, this shouldn't be necesary
        Name = "Application (Shallow Bundle)";
        Description = "Application (Shallow Bundle)";
        PackageTypes = (
            com.apple.package-type.wrapper.application.shallow
        );
    },

    // Framework
    {   Type = ProductType;
        Identifier = com.apple.product-type.framework;
        BasedOn = com.apple.product-type.bundle;
        Class = PBXFrameworkProductType;
        Name = "Framework";
        Description = "Framework";
        IconNamePrefix = "TargetFramework";
        DefaultTargetName = "Framework";
        DefaultBuildProperties = {
            MACH_O_TYPE = "mh_dylib";
            FRAMEWORK_VERSION = "A";
            WRAPPER_SUFFIX = ".$(WRAPPER_EXTENSION)";
            WRAPPER_EXTENSION = "framework";
            INSTALL_PATH = "$(LOCAL_LIBRARY_DIR)/Frameworks";
            DYLIB_INSTALL_NAME_BASE = "$(INSTALL_PATH)";
            LD_DYLIB_INSTALL_NAME = "$(DYLIB_INSTALL_NAME_BASE:standardizepath)/$(EXECUTABLE_PATH)";
            STRIP_STYLE = "debugging";
            CODE_SIGNING_ALLOWED = YES;
        };
        PackageTypes = (
            com.apple.package-type.wrapper.framework   // default
        );
    },

    // Shallow Framework Product
    {   Type = ProductType;
        Identifier = com.apple.product-type.framework.shallow;
        BasedOn = com.apple.product-type.framework;
        Class = PBXFrameworkProductType;
        Name = "Framework (Shallow Bundle)";
        Description = "Framework (Shallow Bundle)";
        PackageTypes = (
            com.apple.package-type.wrapper.framework.shallow
        );
    },

    // Static framework
    {   Type = ProductType;
        Identifier = com.apple.product-type.framework.static;
        BasedOn = com.apple.product-type.framework;
        Class = XCStaticFrameworkProductType;
        Name = "Static Framework";
        Description = "Static Framework";
        IconNamePrefix = "TargetFramework";
        DefaultTargetName = "Static Framework";
        DefaultBuildProperties = {
            MACH_O_TYPE = "staticlib";
            FRAMEWORK_VERSION = "A";
            WRAPPER_SUFFIX = ".$(WRAPPER_EXTENSION)";
            WRAPPER_EXTENSION = "framework";
            INSTALL_PATH = "$(LOCAL_LIBRARY_DIR)/Frameworks";
            DYLIB_INSTALL_NAME_BASE = "";
            LD_DYLIB_INSTALL_NAME = "";
            SEPARATE_STRIP = YES;
            GCC_INLINES_ARE_PRIVATE_EXTERN = NO;
            CODE_SIGNING_ALLOWED = NO;
        };
        AlwaysPerformSeparateStrip = YES;
        PackageTypes = (
            com.apple.package-type.wrapper.framework.static   // default
        );
    },

    // Unit Test Bundle
    {   Type = ProductType;
        Identifier = com.apple.product-type.bundle.unit-test;
        BasedOn = com.apple.product-type.bundle;
        Class = PBXXCTestBundleProductType;
        Name = "Unit Test Bundle";
        Description = "Unit Test Bundle";
        DefaultBuildProperties = {
            WRAPPER_EXTENSION = "xctest";
            PRODUCT_SPECIFIC_LDFLAGS = "-framework XCTest";
            PRODUCT_TYPE_FRAMEWORK_SEARCH_PATHS = "$(TEST_FRAMEWORK_SEARCH_PATHS)";
            TEST_FRAMEWORK_SEARCH_PATHS = (
                "$(inherited)",
                "$(PLATFORM_DIR)/Developer/Library/Frameworks",
            );
        };
        PackageTypes = (
            com.apple.package-type.bundle.unit-test
        );
    },

    // UI Testing Bundle
    {   Type = ProductType;
        Identifier = com.apple.product-type.bundle.ui-testing;
        BasedOn = com.apple.product-type.bundle.unit-test;
        Class = PBXXCTestBundleProductType;
        Name = "UI Testing Bundle";
        Description = "UI Testing Bundle";
        DefaultBuildProperties = {
            WRAPPER_EXTENSION = "xctest";
            USES_XCTRUNNER = "YES";
            PRODUCT_SPECIFIC_LDFLAGS = "-framework XCTest";
            PRODUCT_TYPE_FRAMEWORK_SEARCH_PATHS = "$(TEST_FRAMEWORK_SEARCH_PATHS)";
            TEST_FRAMEWORK_SEARCH_PATHS = (
                "$(inherited)",
                "$(PLATFORM_DIR)/Developer/Library/Frameworks",
            );
        };
        PackageTypes = (
            com.apple.package-type.bundle.unit-test
        );
    },
)
'';

in

stdenv.mkDerivation {
  name = "nixpkgs.platform";
  buildCommand = ''
    mkdir -p $out/
    cd $out/
    cp ${Info} ./Info.plist
    cp ${Version} ./version.plist

    mkdir -p $out/Developer/Library/Xcode/Specifications/

    cp ${NativeBuildSystem} $out/Developer/Library/Xcode/Specifications/NativeBuildSystem.xcspec
    cp ${CoreBuildSystem} $out/Developer/Library/Xcode/Specifications/CoreBuildSystem.xcspec
    cp ${Architectures} $out/Developer/Library/Xcode/Specifications/Architectures.xcspec
    cp ${PackageTypes} $out/Developer/Library/Xcode/Specifications/PackageTypes.xcspec
    cp ${ProductTypes} $out/Developer/Library/Xcode/Specifications/ProductTypes.xcspec

    mkdir -p $out/Developer/SDKs/
    cd $out/Developer/SDKs/
    ln -s ${sdk}
  '';
}
