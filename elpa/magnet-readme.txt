The default paths used to store configuration files and persistent
data are not consistent across Emacs packages.  This isn't just a
problem with third-party packages but even with built-in packages.

Some packages put these files directly in `user-emacs-directory' or
$HOME or in a subdirectory of either of the two or elsewhere.
Furthermore sometimes file names are used that don't provide any
insight into what mode might have created them.

This package sets out to fix this by changing the values of path
variables to put files in either `magnet-etc-directory' or
`magnet-var-directory', using subdirectories when appropriate and
descriptive file names.  In a way this is similar to a color-theme
- a path-theme if you will.  Except that there is no way to unload
it - that wouldn't make any sense.  This package also does not
provide any mode, all work is done when `magnet.el' is loaded and
any configuration has to happen before doing so.

One of the variables changed by this package is `custom-file', so
we cannot use Customize to configure `magnet'.  Instead the
following variables before loading `magnet.el' using `setq'.

* `magnet-etc-directory'       (default ~/.emacs.d/etc/)
   Hopefully the only location where Emacs config files are stored.
   Config files are stored either directly in this directory or in
   a subdirectory.

* `magnet-var-directory'       (default ~/.emacs.d/var/)
   Hopefully the only location where Emacs data files are stored.
   Data files are stored either directly in this directory or in
   a subdirectory.

* `magnet-set-defaults'        (default t)
   Whether magnet sets the default values using `set-default'.
   When nil use `set' instead.  This affects whether Customize
   thinks a variable has been customized or not after `magnet'
   has been loaded.

* `magnet-load-custom-file'    (default t)
   Whether loading `magnet.el' also loads the `custom-file'.
   One shouldn't set `custom-file' (as loading `magnet.el' does)
   without ensuring that it is also loaded.

* `magnet-add-to-magnetized-custom-groups'  (default t)
   Whether loading `magnet.el' adds modified options to a
   `magnetized' Custom group.")

Status:

This is work in progress and very incomplete at the moment.  Only
very few packages have been themed so far.  Eventually all built-in
and many popular third-party packages should be themed.

This is a pre-release.  Version numbers are inspired by how Emacs
is versioned.  1.1.0 will be the first stable version theming an
acceptable number of packages.

Conventions:

This is not set in stone.

* Packages are customized completely or not at all.
* If a default value satisfies our needs it is still repeated here.
* Emacs lisp files end with ".el".
* If a package has several files of a kind then it is placed in a
  suitably named subdirectory of it's own.

Contributing:

Please send me pull requests with your additions and corrections:

  https://github.com/tarsius/magnet/pulls

For a list of people who have contributed see:

  https://github.com/tarsius/magnet/graphs/contributors
