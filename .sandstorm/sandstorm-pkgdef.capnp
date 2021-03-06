@0x92c21f00b607b183;

using Spk = import "/sandstorm/package.capnp";
using Util = import "/sandstorm/util.capnp";

const pkgdef :Spk.PackageDefinition = (
  id = "j1qx7dpgs60mes0ge0f0epj9pmmca9na04mrp1wn5e6d17qfhq20",

  manifest = (

    appVersion = 0,  # Increment this for every release.
    appTitle = (defaultText = "OpenProject"),
    appMarketingVersion = (defaultText = "stable/5 sandstorm-1"),


    metadata = (
      # Data which is not needed specifically to execute the app, but is useful
      # for purposes like marketing and display.  These fields are documented at
      # https://docs.sandstorm.io/en/latest/developing/publishing-apps/#add-required-metadata
      # and (in deeper detail) in the sandstorm source code, in the Metadata section of
      # https://github.com/sandstorm-io/sandstorm/blob/master/src/sandstorm/package.capnp
      icons = (
        # Various icons to represent the app in various contexts.
        #appGrid = (svg = embed "path/to/appgrid-128x128.svg"),
        #grain = (svg = embed "path/to/grain-24x24.svg"),
        #market = (svg = embed "path/to/market-150x150.svg"),
        #marketBig = (svg = embed "path/to/market-big-300x300.svg"),
      ),

      website = "http://example.com",
      # This should be the app's main website url.

      codeUrl = "http://example.com",
      # URL of the app's source code repository, e.g. a GitHub URL.
      # Required if you specify a license requiring redistributing code, but optional otherwise.

      license = (none = void),
      # The license this package is distributed under.  See
      # https://docs.sandstorm.io/en/latest/developing/publishing-apps/#license

      categories = [],
      # A list of categories/genres to which this app belongs, sorted with best fit first.
      # See the list of categories at
      # https://docs.sandstorm.io/en/latest/developing/publishing-apps/#categories

      author = (
        contactEmail = "openproject@wholezero.org",
        upstreamAuthor = "OpenProject Inc.",

        #pgpSignature = embed "path/to/pgp-signature",
        # PGP signature attesting responsibility for the app ID. This is a binary-format detached
        # signature of the following ASCII message (not including the quotes, no newlines, and
        # replacing <app-id> with the standard base-32 text format of the app's ID):
        #
        # "I am the author of the Sandstorm.io app with the following ID: <app-id>"
        #
        # You can create a signature file using `gpg` like so:
        #
        #     echo -n "I am the author of the Sandstorm.io app with the following ID: <app-id>" | gpg --sign > pgp-signature
        #
        # Further details including how to set up GPG and how to use keybase.io can be found
        # at https://docs.sandstorm.io/en/latest/developing/publishing-apps/#verify-your-identity
      ),

      #pgpKeyring = embed "path/to/pgp-keyring",
      # A keyring in GPG keyring format containing all public keys needed to verify PGP signatures in
      # this manifest (as of this writing, there is only one: `author.pgpSignature`).
      #
      # To generate a keyring containing just your public key, do:
      #
      #     gpg --export <key-id> > keyring
      #
      # Where `<key-id>` is a PGP key ID or email address associated with the key.

      #description = (defaultText = embed "path/to/description.md"),
      # The app's description in Github-flavored Markdown format, to be displayed e.g.
      # in an app store. Note that the Markdown is not permitted to contain HTML nor image tags (but
      # you can include a list of screenshots separately).

      shortDescription = (defaultText = "Project management"),

      screenshots = [
        # Screenshots to use for marketing purposes.  Examples below.
        # Sizes are given in device-independent pixels, so if you took these
        # screenshots on a Retina-style high DPI screen, divide each dimension by two.

        #(width = 746, height = 795, jpeg = embed "path/to/screenshot-1.jpeg"),
        #(width = 640, height = 480, png = embed "path/to/screenshot-2.png"),
      ],
      #changeLog = (defaultText = embed "path/to/sandstorm-specific/changelog.md"),
      # Documents the history of changes in Github-flavored markdown format (with the same restrictions
      # as govern `description`). We recommend formatting this with an H1 heading for each version
      # followed by a bullet list of changes.
    ),

    actions = [
      ( title = (defaultText = "New OpenProject Instance"),
        nounPhrase = (defaultText = "instance"),
        command = .startCommand
      )
    ],

    continueCommand = .continueCommand,
  ),

  sourceMap = (
    searchPath = [
      ( sourcePath = "/opt/app",
        hidePaths = ["openproject-ce/.git",
                    ]
      ),
      ( sourcePath = "." ),  # Search this directory first.
      ( sourcePath = "/",    # Then search the system root directory.
        hidePaths = [ "home", "proc", "sys",
                      "etc/passwd", "etc/hosts", "etc/host.conf",
                      "etc/nsswitch.conf", "etc/resolv.conf" ]
      )
    ]
  ),

  fileList = "sandstorm-files.list",

  alwaysInclude = ["opt/app/openproject-ce/vendored-plugins", "opt/ruby/openproject-ce-bundle",
                   "opt/app/openproject-ce/app", "opt/app/openproject-ce/config", "opt/app/openproject-ce/public",
                   "opt/app/openproject-ce/read-only-cache", "opt/ruby/rbenv", "opt/node/nodenv"],

  bridgeConfig = (
    # Used for integrating permissions and roles into the Sandstorm shell
    # and for sandstorm-http-bridge to pass to your app.
    # Uncomment this block and adjust the permissions and roles to make
    # sense for your app.
    # For more information, see high-level documentation at
    # https://docs.sandstorm.io/en/latest/developing/auth/
    # and advanced details in the "BridgeConfig" section of
    # https://github.com/sandstorm-io/sandstorm/blob/master/src/sandstorm/package.capnp
    viewInfo = (
      # For details on the viewInfo field, consult "ViewInfo" in
      # https://github.com/sandstorm-io/sandstorm/blob/master/src/sandstorm/grain.capnp

      permissions = [
      # Permissions which a user may or may not possess.  A user's current
      # permissions are passed to the app as a comma-separated list of `name`
      # fields in the X-Sandstorm-Permissions header with each request.
      #
      # IMPORTANT: only ever append to this list!  Reordering or removing fields
      # will change behavior and permissions for existing grains!  To deprecate a
      # permission, or for more information, see "PermissionDef" in
      # https://github.com/sandstorm-io/sandstorm/blob/master/src/sandstorm/grain.capnp
        (
          name = "admin",
          title = (defaultText = "admin"),
          description = (defaultText = "grants full admin access"),
        ),
        (
          name = "invited",
          title = (defaultText = "invited"),
          description = (defaultText = "grants ordinary user status without needing an admin invite"),
        ),
      ],
      roles = [
        (
          title = (defaultText = "admin"),
          permissions  = [true, true],
          verbPhrase = (defaultText = "can participate in and create projects and activate guests"),
          description = (defaultText = "admins have full control of all project data."),
        ),
        (
          title = (defaultText = "collaborator"),
          permissions  = [false, true],
          verbPhrase = (defaultText = "can participate in projects"),
          description = (defaultText = "collaborators may participate in projects they have access to."),
        ),
        (
          title = (defaultText = "guest"),
          permissions = [false, false],
          verbPhrase = (defaultText = "can be activated by admins"),
          description = (defaultText = "unprivileged guest users must be activated by admins to participate."),
        ),
      ],
    ),
    #apiPath = "/api",
    # Apps can export an API to the world.  The API is to be used primarily by Javascript
    # code and native apps, so it can't serve out regular HTML to browsers.  If a request
    # comes in to your app's API, sandstorm-http-bridge will prefix the request's path with
    # this string, if specified.
  ),
);

const commandEnvironment : List(Util.KeyValue) =
  [
    (key = "PATH", value = "/opt/node/nodenv/versions/0.12.7/bin:/opt/ruby/rbenv/versions/2.3.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"),
  ];

const startCommand :Spk.Manifest.Command = (
  argv = ["/sandstorm-http-bridge", "10000", "--", "/bin/bash", "start.sh"],
  environ = .commandEnvironment
);

const continueCommand :Spk.Manifest.Command = (
  argv = ["/sandstorm-http-bridge", "10000", "--", "/bin/bash", "continue.sh"],
  environ = .commandEnvironment
);
