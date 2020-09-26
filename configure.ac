AC_INIT(guile-lzlib, 0.1)
AC_SUBST(HVERSION, "\"0.1\"")
AC_SUBST(AUTHOR, "\"Mathieu Othacehe\"")
AC_SUBST(COPYRIGHT, "'(2020)")
AC_SUBST(LICENSE, gpl3+)
AC_CONFIG_SRCDIR(lzlib.scm)
AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([1.12 gnu silent-rules subdir-objects  color-tests parallel-tests -Woverride -Wno-portability])
AM_SILENT_RULES([yes])

AC_CONFIG_FILES([Makefile lzlib/config.scm])
AC_CONFIG_FILES([pre-inst-env], [chmod +x pre-inst-env])

dnl Search for 'guile' and 'guild'.  This macro defines
dnl 'GUILE_EFFECTIVE_VERSION'.
GUILE_PKG([3.0 2.2 2.0])
GUILE_PROGS
GUILE_SITE_DIR
if test "x$GUILD" = "x"; then
   AC_MSG_ERROR(['guild' binary not found; please check your guile-2.x installation.])
fi

if test "$cross_compiling" != no; then
   GUILE_TARGET="--target=$host_alias"
   AC_SUBST([GUILE_TARGET])
fi

AC_DEFUN([GUILE_LIBLZ_FILE_NAME], [
  AC_REQUIRE([PKG_PROG_PKG_CONFIG])
  AC_CACHE_CHECK([lzlib's file name],
    [guile_cv_liblz_libdir],
    [if test "$cross_compiling" = yes; then
       # When cross-compiling, we cannot rely on 'ldd'.  Instead, look
       # the output of 'ld --verbose', assuming we're using GNU ld.
       echo 'int main () { return LZ_decompress_open(); }' > conftest.c
       guile_cv_liblz_libdir="\
          `$CC conftest.c -o conftest$EXEEXT -llz -Wl,--verbose 2>/dev/null \
          | grep -E '^/.*/liblz\.(a|so)'`"
       rm -f conftest.c conftest$EXEEXT
     else
       old_LIBS="$LIBS"
       LIBS="-llz"
       AC_LINK_IFELSE([AC_LANG_SOURCE([int main () { return LZ_decompress_open(); }])],
	 [guile_cv_liblz_libdir="`ldd conftest$EXEEXT | grep liblz | sed '-es/.*=> \(.*\) .*$/\1/g'`"])
       LIBS="$old_LIBS"
     fi])
  $1="$guile_cv_liblz_libdir"
])

dnl Library name of lzlib suitable for 'dynamic-link'.
GUILE_LIBLZ_FILE_NAME([LIBLZ_LIBDIR])
if test "x$LIBLZ_LIBDIR" = "x"; then
  LIBLZ_LIBDIR="liblz"
else
  # Strip the .so or .so.1 extension since that's what 'dynamic-link' expects.
  LIBLZ_LIBDIR="`echo $LIBLZ_LIBDIR | sed -es'/\.so\(\.[[0-9.]]\+\)\?//g'`"
fi
AC_SUBST([LIBLZ_LIBDIR])

dnl Installation directories for .scm and .go files.
guilemoduledir="${datarootdir}/guile/site/$GUILE_EFFECTIVE_VERSION"
guileobjectdir="${libdir}/guile/$GUILE_EFFECTIVE_VERSION/site-ccache"
AC_SUBST([guilemoduledir])
AC_SUBST([guileobjectdir])

AC_OUTPUT
