# generated automatically by aclocal 1.7.9 -*- Autoconf -*-

# Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002
# Free Software Foundation, Inc.
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

dnl This file contains the common configuration code which would
dnl otherwise be duplicated between configure and configure-libafs.
dnl
dnl NB: Because this code is a macro, references to positional shell
dnl parameters must be done like $[]1 instead of $1

AC_DEFUN([OPENAFS_CONFIGURE_COMMON],[

AC_CANONICAL_HOST
SRCDIR_PARENT=`pwd`

#BOZO_SAVE_CORES pam sia
AC_ARG_WITH(afs-sysname,
[  --with-afs-sysname=sys    use sys for the afs sysname]
)
AC_ARG_ENABLE( obsolete,
[  --enable-obsolete 			enable obsolete portions of AFS (mpp, ntp and package)],, enable_obsolete="no")
AC_ARG_ENABLE( insecure,
[  --enable-insecure 			enable insecure portions of AFS (ftpd, inetd, rcp, rlogind and rsh)],, enable_insecure="no")
AC_ARG_ENABLE( afsdb,
[  --disable-afsdb 			disable AFSDB RR support],, enable_afsdb="yes")
AC_ARG_ENABLE( pam,
[  --disable-pam 			disable PAM support],, enable_pam="yes")
AC_ARG_ENABLE( bos-restricted-mode,
[  --enable-bos-restricted-mode 	enable bosserver restricted mode which disables certain bosserver functionality],, enable_bos_restricted_mode="no")
AC_ARG_ENABLE( bos-new-config,
[  --enable-bos-new-config	 	enable bosserver pickup of BosConfig.new on restarts],, enable_bos_new_config="no")
AC_ARG_ENABLE( largefile-fileserver,
[  --enable-largefile-fileserver        enable large file support in fileserver],, enable_largefile_fileserver="no")
AC_ARG_ENABLE( namei-fileserver,
[  --enable-namei-fileserver 		force compilation of namei fileserver in preference to inode fileserver],, enable_namei_fileserver="no")
AC_ARG_ENABLE( supergroups,
[  --enable-supergroups 		enable support for nested pts groups],, enable_supergroups="no")
AC_ARG_ENABLE( fast-restart,
[  --enable-fast-restart 		enable fast startup of file server without salvaging],, enable_fast_restart="no")
AC_ARG_ENABLE( bitmap-later,
[  --enable-bitmap-later 		enable fast startup of file server by not reading bitmap till needed],, enable_bitmap_later="no")
AC_ARG_ENABLE( full-vos-listvol-switch,
[  --disable-full-vos-listvol-switch    disable vos full listvol switch for formatted output],, enable_full_vos_listvol_switch="yes")
AC_ARG_WITH(dux-kernel-headers,
[  --with-dux-kernel-headers=path    	use the kernel headers found at path(optional, defaults to first match in /usr/sys)]
)
AC_ARG_WITH(linux-kernel-headers,
[  --with-linux-kernel-headers=path    	use the kernel headers found at path(optional, defaults to /usr/src/linux-2.4, then /usr/src/linux)]
)
AC_ARG_WITH(bsd-kernel-headers,
[  --with-bsd-kernel-headers=path    	use the kernel headers found at path(optional, defaults to /usr/src/sys)]
)
AC_ARG_WITH(bsd-kernel-build,
[  --with-bsd-kernel-build=path    	use the kernel build found at path(optional, defaults to KSRC/i386/compile/GENERIC)]
)
AC_ARG_ENABLE(kernel-module,
[  --disable-kernel-module             	disable compilation of the kernel module (defaults to enabled)],, enable_kernel_module="yes"
)
AC_ARG_ENABLE(redhat-buildsys,
[  --enable-redhat-buildsys		enable compilation of the redhat build system kernel (defaults to disabled)],, enable_redhat_buildsys="no"
)
AC_ARG_ENABLE(transarc-paths,
[  --enable-transarc-paths              	Use Transarc style paths like /usr/afs and /usr/vice],, enable_transarc_paths="no"
)
AC_ARG_ENABLE(tivoli-tsm,
[  --enable-tivoli-tsm              	Enable use of the Tivoli TSM API libraries for butc support],, enable_tivoli_tsm="no"
)
AC_ARG_ENABLE(debug-kernel,
[  --enable-debug-kernel		enable compilation of the kernel module with debugging information (defaults to disabled)],, enable_debug_kernel="no"
)
AC_ARG_ENABLE(optimize-kernel,
[  --disable-optimize-kernel		disable compilation of the kernel module with optimization (defaults based on platform)],, enable_optimize_kernel="yes"
)
AC_ARG_ENABLE(debug,
[  --enable-debug			enable compilation of the user space code with debugging information (defaults to disabled)],, enable_debug="no"
)
AC_ARG_ENABLE(optimize,
[  --disable-optimize			disable optimization for compilation of the user space code (defaults to enabled)],, enable_optimize="yes"
)
AC_ARG_ENABLE(debug-lwp,
[  --enable-debug-lwp			enable compilation of the LWP code with debugging information (defaults to disabled)],, enable_debug_lwp="no"
)
AC_ARG_ENABLE(optimize-lwp,
[  --disable-optimize-lwp		disable optimization for compilation of the LWP code (defaults to enabled)],, enable_optimize_lwp="yes"
)

enable_login="no"

dnl weird ass systems
AC_AIX
AC_ISC_POSIX
AC_MINIX

dnl Various compiler setup.
AC_TYPE_PID_T
AC_TYPE_SIZE_T
AC_TYPE_SIGNAL
COMPILER_HAS_FUNCTION_MACRO

dnl Checks for programs.
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_RANLIB
AC_PROG_YACC
AM_PROG_LEX

OPENAFS_CHECK_BIGENDIAN

AC_MSG_CHECKING(your OS)
system=$host
case $system in
        *-linux*)

		MKAFS_OSTYPE=LINUX
		if test "x$enable_redhat_buildsys" = "xyes"; then
		 AC_DEFINE(ENABLE_REDHAT_BUILDSYS, 1, [define if you have redhat buildsystem])
		fi
		if test "x$enable_kernel_module" = "xyes"; then
		 if test "x$with_linux_kernel_headers" != "x"; then
		   LINUX_KERNEL_PATH="$with_linux_kernel_headers"
		 else
		   LINUX_KERNEL_PATH="/lib/modules/`uname -r`/build"
		   if test ! -f "$LINUX_KERNEL_PATH/include/linux/version.h"; then
		     LINUX_KERNEL_PATH="/usr/src/linux-2.4"
		   fi
		   if test ! -f "$LINUX_KERNEL_PATH/include/linux/version.h"; then
		     LINUX_KERNEL_PATH="/usr/src/linux"
		   fi
		 fi
		 if test -f "$LINUX_KERNEL_PATH/include/linux/version.h"; then
		  linux_kvers=`fgrep UTS_RELEASE $LINUX_KERNEL_PATH/include/linux/version.h |awk 'BEGIN { FS="\"" } { print $[]2 }'|tail -n 1`
		  if test "x$linux_kvers" = "x"; then
		    if test -f "$LINUX_KERNEL_PATH/include/linux/version-up.h"; then
		      linux_kvers=`fgrep UTS_RELEASE $LINUX_KERNEL_PATH/include/linux/version-up.h |awk 'BEGIN { FS="\"" } { print $[]2 }'|tail -n 1`
		      if test "x$linux_kvers" = "x"; then

		        AC_MSG_ERROR(Linux headers lack version definition [2])
		        exit 1
		      else
		        LINUX_VERSION="$linux_kvers"
                      fi
                    else
                      AC_MSG_ERROR(Linux headers lack version definition)
		      exit 1
		    fi
		  else
		    LINUX_VERSION="$linux_kvers"
		  fi
		 else
                    enable_kernel_module="no"
                 fi
		 if test ! -f "$LINUX_KERNEL_PATH/include/linux/autoconf.h"; then
		     enable_kernel_module="no"
		 fi
		 if test "x$enable_kernel_module" = "xno"; then
		  if test "x$with_linux_kernel_headers" != "x"; then
		   AC_MSG_ERROR(No usable linux headers found at $LINUX_KERNEL_PATH)
		   exit 1
		  else
		   AC_MSG_WARN(No usable linux headers found at $LINUX_KERNEL_PATH so disabling kernel module)
		  fi
		 fi
                 dnl do we need to determine SUBARCH from autoconf.h
                 SUBARCH=default
		fi
		AC_MSG_RESULT(linux)
                if test "x$enable_kernel_module" = "xyes"; then
                 AFS_SYSKVERS=`echo $LINUX_VERSION | awk -F\. '{print $[]1 $[]2}'`
                 if test "x${AFS_SYSKVERS}" = "x"; then
                  AC_MSG_ERROR(Couldn't guess your Linux version [2])
                 fi
                fi
                ;;
        *-solaris*)
		MKAFS_OSTYPE=SOLARIS
                AC_MSG_RESULT(sun4)
		SOLARIS_UFSVFS_HAS_DQRWLOCK
		SOLARIS_PROC_HAS_P_COREFILE
		SOLARIS_FS_HAS_FS_ROLLED
                ;;
        *-sunos*)
		MKAFS_OSTYPE=SUNOS
		enable_kernel_module=no
                AC_MSG_RESULT(sun4)
                ;;
        *-hpux*)
		MKAFS_OSTYPE=HPUX
                AC_MSG_RESULT(hp_ux)
                ;;
        *-irix*)
		if test -d /usr/include/sys/SN/SN1; then
		 IRIX_BUILD_IP35="IP35"
		fi
		MKAFS_OSTYPE=IRIX
                AC_MSG_RESULT(sgi)
                ;;
        *-aix*)
		MKAFS_OSTYPE=AIX
                AC_MSG_RESULT(rs_aix)
                ;;
        *-osf*)
		MKAFS_OSTYPE=DUX
                AC_MSG_RESULT(alpha_dux)
		if test "x$enable_kernel_module" = "xyes"; then
		 if test "x$with_dux_kernel_headers" != "x"; then
		   HEADER_RT=`ls ${with_dux_kernel_headers}/rt_preempt.h | head -1 | sed 's,/rt_preempt.h,,;s,/usr/sys/,,'`
		 else
 		   HEADER_RT=`ls /usr/sys/*/rt_preempt.h | head -1 | sed 's,/rt_preempt.h,,;s,/usr/sys/,,'`
		 fi
		fi
		if test "$HEADER_RT" = "*" ; then
			AC_MSG_ERROR([Need a configured kernel directory])
		fi
		AC_SUBST([HEADER_RT])
                ;;
        *-darwin*)
		MKAFS_OSTYPE=DARWIN
                AC_MSG_RESULT(ppc_darwin)
                ;;
	*-freebsd*)
		MKAFS_OSTYPE=FBSD
		AC_MSG_RESULT(i386_fbsd)
		;;
	*-netbsd*)
		MKAFS_OSTYPE=NBSD
		AC_MSG_RESULT(nbsd)
		;;
	*-openbsd*)
		MKAFS_OSTYPE=OBSD
		AC_MSG_RESULT(i386_obsd)
		;;
        *)
                AC_MSG_RESULT($system)
                ;;
esac

if test "x$with_afs_sysname" != "x"; then
        AFS_SYSNAME="$with_afs_sysname"
else
	AC_MSG_CHECKING(your AFS sysname)
	case $host in
		i?86-*-openbsd3.1)
			AFS_SYSNAME="i386_obsd31"
			;;
		i?86-*-openbsd3.2)
			AFS_SYSNAME="i386_obsd32"
			;;
		i?86-*-openbsd3.3)
			AFS_SYSNAME="i386_obsd33"
			;;
		i?86-*-openbsd3.4)
			AFS_SYSNAME="i386_obsd34"
			;;
		i?86-*-openbsd3.5)
			AFS_SYSNAME="i386_obsd35"
			;;
		i?86-*-openbsd3.6)
			AFS_SYSNAME="i386_obsd36"
			;;
		i?86-*-freebsd4.2*)
			AFS_SYSNAME="i386_fbsd_42"
			;;
		i?86-*-freebsd4.3*)
			AFS_SYSNAME="i386_fbsd_43"
			;;
		i?86-*-freebsd4.4*)
			AFS_SYSNAME="i386_fbsd_44"
			;;
		i?86-*-freebsd4.5*)
			AFS_SYSNAME="i386_fbsd_45"
			;;
		i?86-*-freebsd4.6*)
			AFS_SYSNAME="i386_fbsd_46"
			;;
		i?86-*-freebsd4.7*)
			AFS_SYSNAME="i386_fbsd_47"
			;;
		i?86-*-freebsd5.0*)
			AFS_SYSNAME="i386_fbsd_50"
			;;
		i?86-*-freebsd5.1*)
			AFS_SYSNAME="i386_fbsd_51"
			;;
		i?86-*-freebsd5.2*)
			AFS_SYSNAME="i386_fbsd_52"
			;;
		i?86-*-freebsd5.3*)
			AFS_SYSNAME="i386_fbsd_53"
			;;
		i?86-*-netbsd*1.5*)
			AFS_PARAM_COMMON=param.nbsd15.h
			AFS_SYSNAME="i386_nbsd15"
			;;
		alpha-*-netbsd*1.5*)
			AFS_PARAM_COMMON=param.nbsd15.h
			AFS_SYSNAME="alpha_nbsd15"
			;;
		i?86-*-netbsd*1.6[[M-Z]]*)
			AFS_PARAM_COMMON=param.nbsd20.h
			AFS_SYSNAME="i386_nbsd20"
			;;
		powerpc-*-netbsd*1.6[[M-Z]]*)
			AFS_PARAM_COMMON=param.nbsd20.h
			AFS_SYSNAME="ppc_nbsd20"
			;;
		i?86-*-netbsd*2.0*)
			AFS_PARAM_COMMON=param.nbsd20.h
			AFS_SYSNAME="i386_nbsd20"
			;;
		powerpc-*-netbsd*2.0*)
			AFS_PARAM_COMMON=param.nbsd20.h
			AFS_SYSNAME="ppc_nbsd20"
			;;
		i?86-*-netbsd*1.6*)
			AFS_PARAM_COMMON=param.nbsd16.h
			AFS_SYSNAME="i386_nbsd16"
			;;
		alpha-*-netbsd*1.6*)
			AFS_PARAM_COMMON=param.nbsd16.h
			AFS_SYSNAME="alpha_nbsd16"
			;;
		powerpc-*-netbsd*1.6*)
			AFS_PARAM_COMMON=param.nbsd16.h
			AFS_SYSNAME="ppc_nbsd16"
			;;
		i?86-*-netbsd*2.1*)
			AFS_PARAM_COMMON=param.nbsd21.h
			AFS_SYSNAME="i386_nbsd21"
			;;
		i?86-*-netbsd*2.99*)
			AFS_PARAM_COMMON=param.nbsd30.h
			AFS_SYSNAME="i386_nbsd30"
			;;
		i?86-*-netbsd*3.0*)
			AFS_PARAM_COMMON=param.nbsd30.h
			AFS_SYSNAME="i386_nbsd30"
			;;
		hppa*-hp-hpux11.0*)
			AFS_SYSNAME="hp_ux110"
			;;
		hppa*-hp-hpux11.11)
			AFS_SYSNAME="hp_ux11i"
			;;
		ia64-hp-hpux11.22)
			AFS_SYSNAME="ia64_hpux1122"
			;;
		ia64-hp-hpux*)
			AFS_SYSNAME="ia64_hpux1123"
			;;
		hppa*-hp-hpux10*)
			AFS_SYSNAME="hp_ux102"
			;;
		powerpc-apple-darwin1.2*)
			AFS_SYSNAME="ppc_darwin_12"
			;;
		powerpc-apple-darwin1.3*)
			AFS_SYSNAME="ppc_darwin_13"
			;;
		powerpc-apple-darwin1.4*)
			AFS_SYSNAME="ppc_darwin_14"
			;;
		powerpc-apple-darwin5.1*)
			AFS_SYSNAME="ppc_darwin_14"
			;;
		powerpc-apple-darwin5.2*)
			AFS_SYSNAME="ppc_darwin_14"
			;;
		powerpc-apple-darwin5.3*)
			AFS_SYSNAME="ppc_darwin_14"
			;;
		powerpc-apple-darwin5.4*)
			AFS_SYSNAME="ppc_darwin_14"
			;;
		powerpc-apple-darwin5.5*)
			AFS_SYSNAME="ppc_darwin_14"
			;;
		powerpc-apple-darwin6.0*)
			AFS_SYSNAME="ppc_darwin_60"
			;;
		powerpc-apple-darwin6.1*)
			AFS_SYSNAME="ppc_darwin_60"
			;;
		powerpc-apple-darwin6.2*)
			AFS_SYSNAME="ppc_darwin_60"
			;;
		powerpc-apple-darwin6.3*)
			AFS_SYSNAME="ppc_darwin_60"
			;;
		powerpc-apple-darwin6.4*)
			AFS_SYSNAME="ppc_darwin_60"
			;;
		powerpc-apple-darwin6.5*)
			AFS_SYSNAME="ppc_darwin_60"
			;;
		powerpc-apple-darwin7.0*)
			AFS_SYSNAME="ppc_darwin_70"
			;;
		powerpc-apple-darwin7.1*)
			AFS_SYSNAME="ppc_darwin_70"
			;;
		powerpc-apple-darwin7.2*)
			AFS_SYSNAME="ppc_darwin_70"
			;;
		powerpc-apple-darwin7.3*)
			AFS_SYSNAME="ppc_darwin_70"
			;;
		powerpc-apple-darwin7.4*)
			AFS_SYSNAME="ppc_darwin_70"
			;;
		powerpc-apple-darwin7.5*)
			AFS_SYSNAME="ppc_darwin_70"
			;;
		sparc-sun-solaris2.5*)
			AFS_SYSNAME="sun4x_55"
			enable_login="yes"
			;;
		sparc-sun-solaris2.6)
			AFS_SYSNAME="sun4x_56"
			;;
		sparc-sun-solaris2.7)
			AFS_SYSNAME="sun4x_57"
			;;
		sparc-sun-solaris2.8)
			AFS_SYSNAME="sun4x_58"
			;;
		sparc-sun-solaris2.9)
			AFS_SYSNAME="sun4x_59"
			;;
		sparc-sun-solaris2.10)
			AFS_SYSNAME="sun4x_510"
			;;
		sparc-sun-sunos4*)
			AFS_SYSNAME="sun4_413"
			enable_login="yes"
			;;
		i386-pc-solaris2.7)
			AFS_SYSNAME="sunx86_57"
			;;
		i386-pc-solaris2.8)
			AFS_SYSNAME="sunx86_58"
			;;
		i386-pc-solaris2.9)
			AFS_SYSNAME="sunx86_59"
			;;
		i386-pc-solaris2.10)
			AFS_SYSNAME="sunx86_510"
			;;
		alpha*-dec-osf4.0*)
			AFS_SYSNAME="alpha_dux40"
			;;
		alpha*-dec-osf5.0*)
			AFS_SYSNAME="alpha_dux50"
			;;
		alpha*-dec-osf5.1*)
			AFS_SYSNAME="alpha_dux51"
			;;
		mips-sgi-irix6.5)
			AFS_SYSNAME="sgi_65"
			;;
		ia64-*-linux*)
			AFS_SYSNAME="ia64_linuxXX"
			;;
		powerpc-*-linux*)
			AFS_SYSNAME="ppc_linuxXX"
			;;
		powerpc64-*-linux*)
			AFS_SYSNAME="ppc64_linuxXX"
			;;
		alpha*-linux*)
			AFS_SYSNAME="alpha_linux_XX"
			;;
		s390-*-linux*)
			AFS_SYSNAME="s390_linuxXX"
			;;
		s390x-*-linux*)
			AFS_SYSNAME="s390x_linuxXX"
			;;
		sparc-*-linux*)
			AFS_SYSNAME="sparc_linuxXX"
			;;
		sparc64-*-linux*)
			AFS_SYSNAME="sparc64_linuxXX"
			;;
		i?86-*-linux*)
			AFS_SYSNAME="i386_linuxXX"
			;;
		parisc-*-linux-gnu|hppa-*-linux-gnu)
			AFS_SYSNAME="parisc_linuxXX"
			enable_pam="no"
			;;
		power*-ibm-aix4.2*)
			AFS_SYSNAME="rs_aix42"
			enable_pam="no"
			;;
		power*-ibm-aix4.3*)
			AFS_SYSNAME="rs_aix42"
			enable_pam="no"
			;;
		power*-ibm-aix5.1*)
			AFS_SYSNAME="rs_aix51"
			enable_pam="no"
			;;
		power*-ibm-aix5.2*)
			AFS_SYSNAME="rs_aix52"
			enable_pam="no"
			;;
		x86_64-*-linux-gnu)
			AFS_SYSNAME="amd64_linuxXX"
			enable_pam="no"
			;;
		*)
			AC_MSG_ERROR(An AFS sysname is required)
			exit 1
			;;
	esac
	case $AFS_SYSNAME in
		*_linux* | *_umlinux*)
			if test "x${AFS_SYSKVERS}" = "x"; then
			 AC_MSG_ERROR(Couldn't guess your Linux version. Please use the --with-afs-sysname option to configure an AFS sysname.)
			fi
			_AFS_SYSNAME=`echo $AFS_SYSNAME|sed s/XX\$/$AFS_SYSKVERS/`
			AFS_SYSNAME="$_AFS_SYSNAME"
			save_CPPFLAGS="$CPPFLAGS"
			CPPFLAGS="-I${LINUX_KERNEL_PATH}/include $CPPFLAGS"
			AC_TRY_COMPILE(
			 [#include <linux/autoconf.h>],
			 [#ifndef CONFIG_USERMODE
			  #error not UML
			  #endif],
			 ac_cv_linux_is_uml=yes,)
			if test "${ac_cv_linux_is_uml}" = yes; then
			 _AFS_SYSNAME=`echo $AFS_SYSNAME|sed s/linux/umlinux/`
			fi
			CPPFLAGS="$save_CPPFLAGS"
			AFS_SYSNAME="$_AFS_SYSNAME"
			;;
	esac
        AC_MSG_RESULT($AFS_SYSNAME)
fi

case $AFS_SYSNAME in *_linux* | *_umlinux*)

		# Add (sub-) architecture-specific paths needed by conftests
		case $AFS_SYSNAME  in
			*_umlinux26)
				UMLINUX26_FLAGS="-I$LINUX_KERNEL_PATH/arch/um/include"
				UMLINUX26_FLAGS="$UMLINUX26_FLAGS -I$LINUX_KERNEL_PATH/arch/um/kernel/tt/include"
 				UMLINUX26_FLAGS="$UMLINUX26_FLAGS -I$LINUX_KERNEL_PATH/arch/um/kernel/skas/include"
				CPPFLAGS="$CPPFLAGS $UMLINUX26_FLAGS"
		esac

		if test "x$enable_kernel_module" = "xyes"; then
		 if test "x$enable_debug_kernel" = "xno"; then
			LINUX_GCC_KOPTS="$LINUX_GCC_KOPTS -fomit-frame-pointer"
		 fi
		 OPENAFS_GCC_SUPPORTS_MARCH
		 AC_SUBST(P5PLUS_KOPTS)
		 OPENAFS_GCC_NEEDS_NO_STRENGTH_REDUCE
		 OPENAFS_GCC_NEEDS_NO_STRICT_ALIASING
		 OPENAFS_GCC_SUPPORTS_NO_COMMON
		 OPENAFS_GCC_SUPPORTS_PIPE
		 AC_SUBST(LINUX_GCC_KOPTS)
	         ifdef([OPENAFS_CONFIGURE_LIBAFS],
	           [LINUX_BUILD_VNODE_FROM_INODE(src/config,src/afs)],
	           [LINUX_BUILD_VNODE_FROM_INODE(${srcdir}/src/config,src/afs/LINUX,${srcdir}/src/afs/LINUX)]
	         )
		 LINUX_COMPLETION_H_EXISTS
		 LINUX_DEFINES_FOR_EACH_PROCESS
		 LINUX_DEFINES_PREV_TASK
	         LINUX_FS_STRUCT_ADDRESS_SPACE_HAS_PAGE_LOCK
	         LINUX_FS_STRUCT_ADDRESS_SPACE_HAS_GFP_MASK
		 LINUX_FS_STRUCT_INODE_HAS_I_ALLOC_SEM
		 LINUX_FS_STRUCT_INODE_HAS_I_TRUNCATE_SEM
		 LINUX_FS_STRUCT_INODE_HAS_I_DIRTY_DATA_BUFFERS
		 LINUX_FS_STRUCT_INODE_HAS_I_DEVICES
		 LINUX_FS_STRUCT_INODE_HAS_I_SB_LIST
		 LINUX_FS_STRUCT_INODE_HAS_I_SECURITY
		 LINUX_FS_STRUCT_INODE_HAS_INOTIFY_LOCK
	  	 LINUX_INODE_SETATTR_RETURN_TYPE
	  	 LINUX_WRITE_INODE_RETURN_TYPE
	  	 LINUX_IOP_NAMEIDATA
	  	 LINUX_AOP_WRITEBACK_CONTROL
		 LINUX_KERNEL_LINUX_SYSCALL_H
		 LINUX_KERNEL_SELINUX
		 LINUX_KERNEL_SOCK_CREATE
		 LINUX_KERNEL_PAGE_FOLLOW_LINK
		 LINUX_NEED_RHCONFIG
		 LINUX_RECALC_SIGPENDING_ARG_TYPE
		 LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_PARENT
		 LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_REAL_PARENT
		 LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_SIG
		 LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_SIGHAND
		 LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_SIGMASK_LOCK
		 LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_RLIM
		 LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_SIGNAL_RLIM
		 LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_EXIT_STATE
		 LINUX_WHICH_MODULES
                 if test "x$ac_cv_linux_config_modversions" = "xno" -o $AFS_SYSKVERS -ge 26; then
                   AC_MSG_WARN([Cannot determine sys_call_table status. assuming it isn't exported])
                   ac_cv_linux_exports_sys_call_table=no
		   if test -f "$LINUX_KERNEL_PATH/include/asm/ia32_unistd.h"; then
		     ac_cv_linux_exports_ia32_sys_call_table=yes
		   fi
                 else
                   LINUX_EXPORTS_INIT_MM
                   LINUX_EXPORTS_KALLSYMS_ADDRESS
                   LINUX_EXPORTS_KALLSYMS_SYMBOL
                   LINUX_EXPORTS_SYS_CALL_TABLE
                   LINUX_EXPORTS_IA32_SYS_CALL_TABLE
                   LINUX_EXPORTS_SYS_CHDIR
                   LINUX_EXPORTS_SYS_CLOSE
                   LINUX_EXPORTS_SYS_WAIT4
                   if test "x$ac_cv_linux_exports_sys_call_table" = "xno"; then
                         linux_syscall_method=none
                         if test "x$ac_cv_linux_exports_init_mm" = "xyes"; then
                            linux_syscall_method=scan
                            if test "x$ac_cv_linux_exports_kallsyms_address" = "xyes"; then
                               linux_syscall_method=scan_with_kallsyms_address
                            fi
                         fi
                         if test "x$ac_cv_linux_exports_kallsyms_symbol" = "xyes"; then
                            linux_syscall_method=kallsyms_symbol
                         fi
                         if test "x$linux_syscall_method" = "xnone"; then
                        AC_MSG_ERROR([no available sys_call_table access method])
                         fi
                   fi
                 fi
		 if test -f "$LINUX_KERNEL_PATH/include/linux/in_systm.h"; then
		  AC_DEFINE(HAVE_IN_SYSTM_H, 1, [define if you have in_systm.h header file])
	         fi
		 if test -f "$LINUX_KERNEL_PATH/include/linux/mm_inline.h"; then
		  AC_DEFINE(HAVE_MM_INLINE_H, 1, [define if you have mm_inline.h header file])
	         fi
		 if test -f "$LINUX_KERNEL_PATH/include/linux/in_systm.h"; then
		  AC_DEFINE(HAVE_IN_SYSTM_H, 1, [define if you have in_systm.h header file])
	         fi
		 if test "x$ac_cv_linux_exports_sys_chdir" = "xyes" ; then
		  AC_DEFINE(EXPORTED_SYS_CHDIR, 1, [define if your linux kernel exports sys_chdir])
		 fi
		 if test "x$ac_cv_linux_exports_sys_close" = "xyes" ; then
		  AC_DEFINE(EXPORTED_SYS_CLOSE, 1, [define if your linux kernel exports sys_close])
		 fi
		 if test "x$ac_cv_linux_exports_sys_wait4" = "xyes" ; then
		  AC_DEFINE(EXPORTED_SYS_WAIT4, 1, [define if your linux kernel exports sys_wait4])
		 fi
                 if test "x$ac_cv_linux_exports_sys_call_table" = "xyes"; then
                  AC_DEFINE(EXPORTED_SYS_CALL_TABLE)
                 fi
                 if test "x$ac_cv_linux_exports_ia32_sys_call_table" = "xyes"; then
                  AC_DEFINE(EXPORTED_IA32_SYS_CALL_TABLE)
                 fi
                 if test "x$ac_cv_linux_exports_kallsyms_symbol" = "xyes"; then
                  AC_DEFINE(EXPORTED_KALLSYMS_SYMBOL)
                 fi
                 if test "x$ac_cv_linux_exports_kallsyms_address" = "xyes"; then
                  AC_DEFINE(EXPORTED_KALLSYMS_ADDRESS)
                 fi
		 if test "x$ac_cv_linux_completion_h_exists" = "xyes" ; then
		  AC_DEFINE(COMPLETION_H_EXISTS, 1, [define if completion_h exists])
		 fi
		 if test "x$ac_cv_linux_defines_for_each_process" = "xyes" ; then
		  AC_DEFINE(DEFINED_FOR_EACH_PROCESS, 1, [define if for_each_process defined])
		 fi
		 if test "x$ac_cv_linux_defines_prev_task" = "xyes" ; then
		  AC_DEFINE(DEFINED_PREV_TASK, 1, [define if prev_task defined])
		 fi
		 if test "x$ac_cv_linux_func_inode_setattr_returns_int" = "xyes" ; then
		  AC_DEFINE(INODE_SETATTR_NOT_VOID, 1, [define if your setattr return return non-void])
		 fi
		 if test "x$ac_cv_linux_func_write_inode_returns_int" = "xyes" ; then
		  AC_DEFINE(WRITE_INODE_NOT_VOID, 1, [define if your sops.write_inode returns non-void])
		 fi
		 if test "x$ac_cv_linux_fs_struct_address_space_has_page_lock" = "xyes"; then 
		  AC_DEFINE(STRUCT_ADDRESS_SPACE_HAS_PAGE_LOCK, 1, [define if your struct address_space has page_lock])
		 fi
		 if test "x$ac_cv_linux_fs_struct_address_space_has_gfp_mask" = "xyes"; then 
		  AC_DEFINE(STRUCT_ADDRESS_SPACE_HAS_GFP_MASK, 1, [define if your struct address_space has gfp_mask])
		 fi
		 if test "x$ac_cv_linux_fs_struct_inode_has_i_truncate_sem" = "xyes"; then 
		  AC_DEFINE(STRUCT_INODE_HAS_I_TRUNCATE_SEM, 1, [define if your struct inode has truncate_sem])
		 fi
		 if test "x$ac_cv_linux_fs_struct_inode_has_i_alloc_sem" = "xyes"; then 
		  AC_DEFINE(STRUCT_INODE_HAS_I_ALLOC_SEM, 1, [define if your struct inode has alloc_sem])
		 fi
		 if test "x$ac_cv_linux_fs_struct_inode_has_i_devices" = "xyes"; then 
		  AC_DEFINE(STRUCT_INODE_HAS_I_DEVICES, 1, [define if you struct inode has i_devices])
		 fi
		 if test "x$ac_cv_linux_fs_struct_inode_has_i_security" = "xyes"; then 
		  AC_DEFINE(STRUCT_INODE_HAS_I_SECURITY, 1, [define if you struct inode has i_security])
		 fi
		 if test "x$ac_cv_linux_fs_struct_inode_has_i_sb_list" = "xyes"; then 
		  AC_DEFINE(STRUCT_INODE_HAS_I_SB_LIST, 1, [define if you struct inode has i_sb_list])
		 fi
		 if test "x$ac_cv_linux_fs_struct_inode_has_i_dirty_data_buffers" = "xyes"; then 
		  AC_DEFINE(STRUCT_INODE_HAS_I_DIRTY_DATA_BUFFERS, 1, [define if your struct inode has data_buffers])
		 fi
		 if test "x$ac_cv_linux_fs_struct_inode_has_inotify_lock" = "xyes"; then 
		  AC_DEFINE(STRUCT_INODE_HAS_INOTIFY_LOCK, 1, [define if your struct inode has inotify_lock])
		 fi
		 if test "x$ac_cv_linux_func_recalc_sigpending_takes_void" = "xyes"; then 
		  AC_DEFINE(RECALC_SIGPENDING_TAKES_VOID, 1, [define if your recalc_sigpending takes void])
		 fi
		 if test "x$ac_cv_linux_kernel_is_selinux" = "xyes" ; then
		  AC_DEFINE(LINUX_KERNEL_IS_SELINUX, 1, [define if your linux kernel uses SELinux features])
		 fi
		 if test "x$ac_cv_linux_kernel_sock_create_v" = "xyes" ; then
		  AC_DEFINE(LINUX_KERNEL_SOCK_CREATE_V, 1, [define if your linux kernel uses 5 arguments for sock_create])
		 fi
		 if test "x$ac_cv_linux_kernel_page_follow_link" = "xyes" ; then
		  AC_DEFINE(HAVE_KERNEL_PAGE_FOLLOW_LINK, 1, [define if your linux kernel provides page_follow_link])
		 fi
		 if test "x$ac_linux_syscall" = "xyes" ; then
		  AC_DEFINE(HAVE_KERNEL_LINUX_SYSCALL_H, 1, [define if your linux kernel has linux/syscall.h])
		 fi
		 if test "x$ac_cv_linux_sched_struct_task_struct_has_parent" = "xyes"; then 
		  AC_DEFINE(STRUCT_TASK_STRUCT_HAS_PARENT, 1, [define if your struct task_struct has parent])
		 fi
		 if test "x$ac_cv_linux_sched_struct_task_struct_has_real_parent" = "xyes"; then 
		  AC_DEFINE(STRUCT_TASK_STRUCT_HAS_REAL_PARENT, 1, [define if your struct task_struct has real_parent])
		 fi
		 if test "x$ac_cv_linux_sched_struct_task_struct_has_sigmask_lock" = "xyes"; then 
		  AC_DEFINE(STRUCT_TASK_STRUCT_HAS_SIGMASK_LOCK, 1, [define if your struct task_struct has sigmask_lock])
		 fi
		 if test "x$ac_cv_linux_sched_struct_task_struct_has_sighand" = "xyes"; then 
		  AC_DEFINE(STRUCT_TASK_STRUCT_HAS_SIGHAND, 1, [define if your struct task_struct has sighand])
		 fi
		 if test "x$ac_cv_linux_sched_struct_task_struct_has_sig" = "xyes"; then 
		  AC_DEFINE(STRUCT_TASK_STRUCT_HAS_SIG, 1, [define if your struct task_struct has sig])
		 fi
		 if test "x$ac_cv_linux_sched_struct_task_struct_has_rlim" = "xyes"; then 
		  AC_DEFINE(STRUCT_TASK_STRUCT_HAS_RLIM, 1, [define if your struct task_struct has rlim])
		 fi
		 if test "x$ac_cv_linux_sched_struct_task_struct_has_signal_rlim" = "xyes"; then 
		  AC_DEFINE(STRUCT_TASK_STRUCT_HAS_SIGNAL_RLIM, 1, [define if your struct task_struct has signal->rlim])
		 fi
		 if test "x$ac_cv_linux_sched_struct_task_struct_has_exit_state" = "xyes"; then 
		  AC_DEFINE(STRUCT_TASK_STRUCT_HAS_EXIT_STATE, 1, [define if your struct task_struct has exit_state])
		 fi
                :
		fi
esac

case $AFS_SYSNAME in
	*_darwin*)
		DARWIN_PLIST=src/libafs/afs.${AFS_SYSNAME}.plist
		DARWIN_INFOFILE=afs.${AFS_SYSNAME}.plist
                dnl the test below fails on darwin, even if the CPPFLAGS below
                dnl are added. the headers from Kernel.Framework must be used
                dnl when KERNEL is defined.

                dnl really, such a thing isn't guaranteed to work on any 
                dnl platform until the kernel cflags from MakefileProto are
                dnl known to configure
	        AC_DEFINE(HAVE_STRUCT_BUF, 1, [define if you have a struct buf])
		;;
        *)
AC_MSG_CHECKING(for definition of struct buf)
dnl save_CPPFLAGS="$CPPFLAGS"
dnl CPPFLAGS="$CPPFLAGS -DKERNEL -D_KERNEL -D__KERNEL -D__KERNEL__"
AC_CACHE_VAL(ac_cv_have_struct_buf, [
	ac_cv_have_struct_buf=no
	AC_TRY_COMPILE(
		[#include <sys/buf.h>],
		[struct buf x;
		printf("%d\n", sizeof(x));],
		ac_cv_have_struct_buf=yes,)
	]
)
dnl CPPFLAGS="$save_CPPFLAGS"
AC_MSG_RESULT($ac_cv_have_struct_buf)
if test "$ac_cv_have_struct_buf" = yes; then
	AC_DEFINE(HAVE_STRUCT_BUF, 1, [define if you have a struct buf])
fi
;;
esac


AC_CACHE_VAL(ac_cv_sockaddr_len,
[
AC_MSG_CHECKING([if struct sockaddr has sa_len field])
AC_TRY_COMPILE( [#include <sys/types.h>
#include <sys/socket.h>],
[struct sockaddr *a;
a->sa_len=0;], ac_cv_sockaddr_len=yes, ac_cv_sockaddr_len=no)
AC_MSG_RESULT($ac_cv_sockaddr_len)])
if test "$ac_cv_sockaddr_len" = "yes"; then
   AC_DEFINE(STRUCT_SOCKADDR_HAS_SA_LEN, 1, [define if you struct sockaddr sa_len])
fi
if test "x${MKAFS_OSTYPE}" = "xIRIX"; then
        echo Skipping library tests because they confuse Irix.
else
  AC_CHECK_FUNCS(socket)

  if test "$ac_cv_func_socket" = no; then
    for lib in socket inet; do
        if test "$HAVE_SOCKET" != 1; then
                AC_CHECK_LIB(${lib}, socket,LIBS="$LIBS -l$lib";HAVE_SOCKET=1;AC_DEFINE(HAVE_SOCKET, 1, [define if you have socket]))
        fi
    done
  fi
  
  AC_CHECK_FUNCS(connect)       

  if test "$ac_cv_func_connect" = no; then
    for lib in nsl; do
        if test "$HAVE_CONNECT" != 1; then
                AC_CHECK_LIB(${lib}, connect,LIBS="$LIBS -l$lib";HAVE_CONNECT=1;AC_DEFINE(HAVE_CONNECT, 1, [define if you have connect]))
        fi
    done
  fi

  AC_CHECK_FUNCS(gethostbyname)
  if test "$ac_cv_func_gethostbyname" = no; then
        for lib in dns nsl resolv; do
          if test "$HAVE_GETHOSTBYNAME" != 1; then
            AC_CHECK_LIB(${lib}, gethostbyname, LIBS="$LIBS -l$lib";HAVE_GETHOSTBYNAME=1;AC_DEFINE(HAVE_GETHOSTBYNAME, 1, [define if you have gethostbyname]))
          fi
        done    
  fi    

  dnl darwin wants it, aix hates it
  AC_MSG_CHECKING(for the useability of arpa/nameser_compat.h)
  AC_TRY_COMPILE([
  #include <stdlib.h>
  #include <stdio.h>
  #include <sys/types.h>
  #include <sys/socket.h>
  #include <netinet/in.h>
  #include <arpa/inet.h>
  #include <arpa/nameser.h>
  #include <arpa/nameser_compat.h>
  #include <resolv.h>
  ], [static int i; i = 0;],
  [AC_MSG_RESULT(yes)
   AC_DEFINE(HAVE_ARPA_NAMESER_COMPAT_H)],
  [AC_MSG_RESULT(no)
   ])

  openafs_save_libs="$LIBS"
  AC_MSG_CHECKING([for res_search])
  AC_FUNC_RES_SEARCH

  if test "$ac_cv_func_res_search" = no; then
      for lib in dns nsl resolv; do
        if test "$ac_cv_func_res_search" != yes; then
	  LIBS="-l$lib $LIBS"
          AC_FUNC_RES_SEARCH
          LIBS="$openafs_save_libs"
        fi
      done    
      if test "$ac_cv_func_res_search" = yes; then
        LIB_res_search="-l$lib"       
	AC_DEFINE(HAVE_RES_SEARCH, 1, [])
        AC_MSG_RESULT([yes, in lib$lib])
      else
        AC_MSG_RESULT(no)
      fi
  else
    AC_DEFINE(HAVE_RES_SEARCH, 1, [])
    AC_MSG_RESULT(yes)
  fi
  
fi

PTHREAD_LIBS=error
AC_CHECK_LIB(pthread, pthread_attr_init,
             PTHREAD_LIBS="-lpthread")
if test "x$PTHREAD_LIBS" = xerror; then
        AC_CHECK_LIB(pthreads, pthread_attr_init,
                PTHREAD_LIBS="-lpthreads")
fi
if test "x$PTHREAD_LIBS" = xerror; then
        AC_CHECK_LIB(c_r, pthread_attr_init,
                PTHREAD_LIBS="-lc_r")
fi
if test "x$PTHREAD_LIBS" = xerror; then
        AC_CHECK_FUNC(pthread_attr_init, PTHREAD_LIBS="")
fi
if test "x$PTHREAD_LIBS" = xerror; then
        AC_MSG_WARN(*** Unable to locate working posix thread library ***)
fi
AC_SUBST(PTHREAD_LIBS)

WITH_OBSOLETE=NO
if test "$enable_obsolete" = "yes"; then
	WITH_OBSOLETE=YES
fi

WITH_INSECURE=NO
if test "$enable_insecure" = "yes"; then
	WITH_INSECURE=YES
fi

if test "x$with_bsd_kernel_headers" != "x"; then
	BSD_KERNEL_PATH="$with_bsd_kernel_headers"
else
	BSD_KERNEL_PATH="/usr/src/sys"
fi

if test "x$with_bsd_kernel_build" != "x"; then
	BSD_KERNEL_BUILD="$with_bsd_kernel_build"
else
	case $AFS_SYSNAME in
		i386_fbsd_4?)
			BSD_KERNEL_BUILD="${BSD_KERNEL_PATH}/compile/GENERIC"
			;;
		i386_fbsd_5?)
			BSD_KERNEL_BUILD="${BSD_KERNEL_PATH}/i386/compile/GENERIC"
			;;
	esac
fi

# Fast restart
if test "$enable_supergroups" = "yes"; then
	AC_DEFINE(SUPERGROUPS, 1, [define if you want to have support for nested pts groups])
fi

if test "$enable_fast_restart" = "yes"; then
	AC_DEFINE(FAST_RESTART, 1, [define if you want to have fast restart])
fi

if test "$enable_bitmap_later" = "yes"; then
	AC_DEFINE(BITMAP_LATER, 1, [define if you want to salvager to check bitmasks later])
fi

if test "$enable_full_vos_listvol_switch" = "yes"; then
	AC_DEFINE(FULL_LISTVOL_SWITCH, 1, [define if you want to want listvol switch])
fi

if test "$enable_bos_restricted_mode" = "yes"; then
	AC_DEFINE(BOS_RESTRICTED_MODE, 1, [define if you want to want bos restricted mode])
fi

if test "$enable_bos_new_config" = "yes"; then
	AC_DEFINE(BOS_NEW_CONFIG, 1, [define if you want to enable automatic renaming of BosConfig.new to BosConfig at startup])
fi

if test "$enable_largefile_fileserver" = "yes"; then
	AC_DEFINE(AFS_LARGEFILE_ENV, 1, [define if you want large file fileserver])
fi

if test "$enable_namei_fileserver" = "yes"; then
	AC_DEFINE(AFS_NAMEI_ENV, 1, [define if you want to want namei fileserver])
fi

if test "$enable_afsdb" = "yes"; then
	LIB_AFSDB="$LIB_res_search"
	AC_DEFINE(AFS_AFSDB_ENV, 1, [define if you want to want search afsdb rr])
fi

dnl check for tivoli
AC_MSG_CHECKING(for tivoli tsm butc support)
XBSA_CFLAGS=""
if test "$enable_tivoli_tsm" = "yes"; then
	XBSADIR1=/usr/tivoli/tsm/client/api/bin/xopen
	XBSADIR2=/opt/tivoli/tsm/client/api/bin/xopen

	if test -e "$XBSADIR1/xbsa.h"; then
		XBSA_CFLAGS="-Dxbsa -I$XBSADIR1"
		AC_MSG_RESULT([yes, $XBSA_CFLAGS])
	elif test -e "$XBSADIR2/xbsa.h"; then
		XBSA_CFLAGS="-Dxbsa -I$XBSADIR2"
		AC_MSG_RESULT([yes, $XBSA_CFLAGS])
	else
		AC_MSG_RESULT([no, missing xbsa.h header file])
	fi
else
	AC_MSG_RESULT([no])
fi
AC_SUBST(XBSA_CFLAGS)

dnl checks for header files.
AC_HEADER_STDC
AC_HEADER_SYS_WAIT
AC_HEADER_DIRENT
AC_CHECK_HEADERS(stdlib.h string.h unistd.h fcntl.h sys/time.h sys/file.h)
AC_CHECK_HEADERS(netinet/in.h netdb.h sys/fcntl.h sys/mnttab.h sys/mntent.h)
AC_CHECK_HEADERS(mntent.h sys/vfs.h sys/param.h sys/fs_types.h sys/fstyp.h)
AC_CHECK_HEADERS(sys/mount.h strings.h termios.h signal.h)
AC_CHECK_HEADERS(windows.h malloc.h winsock2.h direct.h io.h sys/user.h)
AC_CHECK_HEADERS(security/pam_modules.h siad.h usersec.h ucontext.h regex.h)

if test "$ac_cv_header_security_pam_modules_h" = yes -a "$enable_pam" = yes; then
	HAVE_PAM="yes"
else
	HAVE_PAM="no"
fi
AC_SUBST(HAVE_PAM)

if test "$enable_login" = yes; then
	BUILD_LOGIN="yes"
else
	BUILD_LOGIN="no"
fi
AC_SUBST(BUILD_LOGIN)

AC_CHECK_FUNCS(utimes random srandom getdtablesize snprintf strlcat strlcpy re_comp re_exec)
AC_CHECK_FUNCS(setprogname getprogname sigaction mkstemp vsnprintf strerror)

AC_CHECK_FUNCS(regcomp regexec regerror)
AC_MSG_CHECKING([for POSIX regex library])
if test "$ac_cv_header_regex_h" = "yes" && \
	test "$ac_cv_func_regcomp" = "yes" && \
	test "$ac_cv_func_regexec" = "yes" && \
	test "$ac_cv_func_regerror" = "yes"; then
    AC_DEFINE(HAVE_POSIX_REGEX, 1, [define if you have POSIX regex library])
    AC_MSG_RESULT(yes)
else
    AC_MSG_RESULT(no)
fi
	
AC_CHECK_TYPE(ssize_t, int)
AC_SIZEOF_TYPE(long)

AC_CHECK_FUNCS(timegm)

dnl Directory PATH handling
if test "x$enable_transarc_paths" = "xyes"  ; then 
    afsconfdir=${afsconfdir=/usr/afs/etc}
    viceetcdir=${viceetcdir=/usr/vice/etc}
    afskerneldir=${afskerneldir=${viceetcdir}}
    afssrvbindir=${afssrvbindir=/usr/afs/bin}
    afssrvsbindir=${afssrvsbindir=/usr/afs/bin}
    afssrvlibexecdir=${afssrvlibexecdir=/usr/afs/bin}
    afsdbdir=${afsdbdir=/usr/afs/db}
    afslogsdir=${afslogsdir=/usr/afs/logs}
    afslocaldir=${afslocaldir=/usr/afs/local}
    afsbackupdir=${afsbackupdir=/usr/afs/backup}
    afsbosconfigdir=${afsbosconfigdir=/usr/afs/local}
else 
    afsconfdir=${afsconfdir='${sysconfdir}/openafs/server'}
    viceetcdir=${viceetcdir='${sysconfdir}/openafs'}
    afskerneldir=${afskerneldir='${libdir}/openafs'}
    afssrvbindir=${afssrvbindir='${bindir}'}
    afssrvsbindir=${afssrvsbindir='${sbindir}'}
    afssrvlibexecdir=${afssrvlibexecdir='${libexecdir}/openafs'}
    afsdbdir=${afsdbdir='${localstatedir}/openafs/db'}
    afslogsdir=${afslogsdir='${localstatedir}/openafs/logs'}
    afslocaldir=${afslocaldir='${localstatedir}/openafs'}
    afsbackupdir=${afsbackupdir='${localstatedir}/openafs/backup'}
    afsbosconfigdir=${afsbosconfigdir='${sysconfdir}/openafs'}
fi
AC_SUBST(afsconfdir)
AC_SUBST(viceetcdir)
AC_SUBST(afskerneldir)
AC_SUBST(afssrvbindir)
AC_SUBST(afssrvsbindir)
AC_SUBST(afssrvlibexecdir)
AC_SUBST(afsdbdir)
AC_SUBST(afslogsdir)
AC_SUBST(afslocaldir)
AC_SUBST(afsbackupdir)
AC_SUBST(afsbosconfigdir)

if test "x$enable_kernel_module" = "xyes"; then
ENABLE_KERNEL_MODULE=libafs
fi

AC_SUBST(AFS_SYSNAME)
AC_SUBST(AFS_PARAM_COMMON)
AC_SUBST(ENABLE_KERNEL_MODULE)
AC_SUBST(LIB_AFSDB)
AC_SUBST(LINUX_KERNEL_PATH)
AC_SUBST(BSD_KERNEL_PATH)
AC_SUBST(BSD_KERNEL_BUILD)
AC_SUBST(LINUX_VERSION)
AC_SUBST(MKAFS_OSTYPE)
AC_SUBST(TOP_OBJDIR)
AC_SUBST(TOP_SRCDIR)
AC_SUBST(TOP_INCDIR)
AC_SUBST(TOP_LIBDIR)
AC_SUBST(DEST)
AC_SUBST(WITH_OBSOLETE)
AC_SUBST(WITH_INSECURE)
AC_SUBST(DARWIN_INFOFILE)
AC_SUBST(IRIX_BUILD_IP35)

OPENAFS_OSCONF

TOP_SRCDIR="${srcdir}/src"
dnl
dnl If we're using ./configure, need a more reasonable TOP_SRCDIR, since relative links don't work everywhere
dnl
case $TOP_SRCDIR in
        /*)
                ;;
        *)
		TOP_SRCDIR=`cd $TOP_SRCDIR; pwd`
		;;
esac

TOP_OBJDIR="${SRCDIR_PARENT}"
TOP_INCDIR="${SRCDIR_PARENT}/include"
TOP_LIBDIR="${SRCDIR_PARENT}/lib"
if test "${DEST}x" = "x"; then
        DEST="${SRCDIR_PARENT}/${AFS_SYSNAME}/dest"
fi

HELPER_SPLINT="${TOP_SRCDIR}/helper-splint.sh"
HELPER_SPLINTCFG="${TOP_SRCDIR}/splint.cfg"
AC_SUBST(HELPER_SPLINT)
AC_SUBST(HELPER_SPLINTCFG)


])

# isc-posix.m4 serial 2 (gettext-0.11.2)
dnl Copyright (C) 1995-2002 Free Software Foundation, Inc.
dnl This file is free software, distributed under the terms of the GNU
dnl General Public License.  As a special exception to the GNU General
dnl Public License, this file may be distributed as part of a program
dnl that contains a configuration script generated by Autoconf, under
dnl the same distribution terms as the rest of that program.

# This file is not needed with autoconf-2.53 and newer.  Remove it in 2005.

# This test replaces the one in autoconf.
# Currently this macro should have the same name as the autoconf macro
# because gettext's gettext.m4 (distributed in the automake package)
# still uses it.  Otherwise, the use in gettext.m4 makes autoheader
# give these diagnostics:
#   configure.in:556: AC_TRY_COMPILE was called before AC_ISC_POSIX
#   configure.in:556: AC_TRY_RUN was called before AC_ISC_POSIX

undefine([AC_ISC_POSIX])

AC_DEFUN([AC_ISC_POSIX],
  [
    dnl This test replaces the obsolescent AC_ISC_POSIX kludge.
    AC_CHECK_LIB(cposix, strerror, [LIBS="$LIBS -lcposix"])
  ]
)

AC_DEFUN([COMPILER_HAS_FUNCTION_MACRO], [
AC_MSG_CHECKING(for __FUNCTION__ and __LINE__ macros)
AC_CACHE_VAL(ac_cv_compiler_has_function_macro,
[
AC_TRY_COMPILE(
[#include <stdio.h>],
[printf("%s:%d", __FUNCTION__, __LINE__);],
ac_cv_compiler_has_function_macro=yes,
ac_cv_compiler_has_function_macro=no)])
AC_MSG_RESULT($ac_cv_compiler_has_function_macro)
if test "$ac_cv_compiler_has_function_macro" = "yes"; then
  AC_DEFINE(HAVE_FUNCTION_MACRO, 1, [define if compiler has __FUNCTION__])
fi
])



# Copyright 1998, 1999, 2000, 2001, 2002 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

# serial 3

AC_PREREQ(2.50)

# AM_PROG_LEX
# -----------
# Autoconf leaves LEX=: if lex or flex can't be found.  Change that to a
# "missing" invocation, for better error output.
AC_DEFUN([AM_PROG_LEX],
[AC_REQUIRE([AM_MISSING_HAS_RUN])dnl
AC_REQUIRE([AC_PROG_LEX])dnl
if test "$LEX" = :; then
  LEX=${am_missing_run}flex
fi])

#  -*- Autoconf -*-


# Copyright 1997, 1999, 2000, 2001 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

# serial 3

# AM_MISSING_PROG(NAME, PROGRAM)
# ------------------------------
AC_DEFUN([AM_MISSING_PROG],
[AC_REQUIRE([AM_MISSING_HAS_RUN])
$1=${$1-"${am_missing_run}$2"}
AC_SUBST($1)])


# AM_MISSING_HAS_RUN
# ------------------
# Define MISSING if not defined so far and test if it supports --run.
# If it does, set am_missing_run to use it, otherwise, to nothing.
AC_DEFUN([AM_MISSING_HAS_RUN],
[AC_REQUIRE([AM_AUX_DIR_EXPAND])dnl
test x"${MISSING+set}" = xset || MISSING="\${SHELL} $am_aux_dir/missing"
# Use eval to expand $SHELL
if eval "$MISSING --run true"; then
  am_missing_run="$MISSING --run "
else
  am_missing_run=
  AC_MSG_WARN([`missing' script is too old or missing])
fi
])

# AM_AUX_DIR_EXPAND

# Copyright 2001 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

# For projects using AC_CONFIG_AUX_DIR([foo]), Autoconf sets
# $ac_aux_dir to `$srcdir/foo'.  In other projects, it is set to
# `$srcdir', `$srcdir/..', or `$srcdir/../..'.
#
# Of course, Automake must honor this variable whenever it calls a
# tool from the auxiliary directory.  The problem is that $srcdir (and
# therefore $ac_aux_dir as well) can be either absolute or relative,
# depending on how configure is run.  This is pretty annoying, since
# it makes $ac_aux_dir quite unusable in subdirectories: in the top
# source directory, any form will work fine, but in subdirectories a
# relative path needs to be adjusted first.
#
# $ac_aux_dir/missing
#    fails when called from a subdirectory if $ac_aux_dir is relative
# $top_srcdir/$ac_aux_dir/missing
#    fails if $ac_aux_dir is absolute,
#    fails when called from a subdirectory in a VPATH build with
#          a relative $ac_aux_dir
#
# The reason of the latter failure is that $top_srcdir and $ac_aux_dir
# are both prefixed by $srcdir.  In an in-source build this is usually
# harmless because $srcdir is `.', but things will broke when you
# start a VPATH build or use an absolute $srcdir.
#
# So we could use something similar to $top_srcdir/$ac_aux_dir/missing,
# iff we strip the leading $srcdir from $ac_aux_dir.  That would be:
#   am_aux_dir='\$(top_srcdir)/'`expr "$ac_aux_dir" : "$srcdir//*\(.*\)"`
# and then we would define $MISSING as
#   MISSING="\${SHELL} $am_aux_dir/missing"
# This will work as long as MISSING is not called from configure, because
# unfortunately $(top_srcdir) has no meaning in configure.
# However there are other variables, like CC, which are often used in
# configure, and could therefore not use this "fixed" $ac_aux_dir.
#
# Another solution, used here, is to always expand $ac_aux_dir to an
# absolute PATH.  The drawback is that using absolute paths prevent a
# configured tree to be moved without reconfiguration.

# Rely on autoconf to set up CDPATH properly.
AC_PREREQ([2.50])

AC_DEFUN([AM_AUX_DIR_EXPAND], [
# expand $ac_aux_dir to an absolute path
am_aux_dir=`cd $ac_aux_dir && pwd`
])

dnl
dnl $Id: bigendian.m4,v 1.3 2004/06/03 05:13:29 shadow Exp $
dnl

dnl check if this computer is little or big-endian
dnl if we can figure it out at compile-time then don't define the cpp symbol
dnl otherwise test for it and define it.  also allow options for overriding
dnl it when cross-compiling

AC_DEFUN([OPENAFS_CHECK_BIGENDIAN], [
AC_ARG_ENABLE(bigendian,
[  --enable-bigendian	the target is big endian],
openafs_cv_c_bigendian=yes)
AC_ARG_ENABLE(littleendian,
[  --enable-littleendian	the target is little endian],
openafs_cv_c_bigendian=no)
AC_CACHE_CHECK(whether byte order is known at compile time,
openafs_cv_c_bigendian_compile,
[AC_TRY_COMPILE([
#include <sys/types.h>
#include <sys/param.h>],[
#if !BYTE_ORDER || !BIG_ENDIAN || !LITTLE_ENDIAN
 bogus endian macros
#endif], openafs_cv_c_bigendian_compile=yes, openafs_cv_c_bigendian_compile=no)])
AC_CACHE_CHECK(whether byte ordering is bigendian, openafs_cv_c_bigendian,[
  if test "$openafs_cv_c_bigendian_compile" = "yes"; then
    AC_TRY_COMPILE([
#include <sys/types.h>
#include <sys/param.h>],[
#if BYTE_ORDER != BIG_ENDIAN
  not big endian
#endif], openafs_cv_c_bigendian=yes, openafs_cv_c_bigendian=no)
  else
    AC_TRY_RUN([main () {
      /* Are we little or big endian?  From Harbison&Steele.  */
      union
      {
	long l;
	char c[sizeof (long)];
    } u;
    u.l = 1;
    exit (u.c[sizeof (long) - 1] == 1);
  }], openafs_cv_c_bigendian=no, openafs_cv_c_bigendian=yes,
  AC_MSG_ERROR([specify either --enable-bigendian or --enable-littleendian]))
  fi
])
if test "$openafs_cv_c_bigendian" = "yes"; then
  AC_DEFINE(WORDS_BIGENDIAN, 1, [define if target is big endian])dnl
fi
if test "$openafs_cv_c_bigendian_compile" = "yes"; then
  AC_DEFINE(ENDIANESS_IN_SYS_PARAM_H, 1, [define if sys/param.h defines the endiness])dnl
fi
])

AC_DEFUN([SOLARIS_UFSVFS_HAS_DQRWLOCK], [
AC_MSG_CHECKING(for vfs_dqrwlock in struct ufsvfs)
AC_CACHE_VAL(ac_cv_solaris_ufsvfs_has_dqrwlock,
[
AC_TRY_COMPILE(
[#define _KERNEL
#include <sys/fs/ufs_inode.h>],
[struct ufsvfs _ufsvfs;
(void) _ufsvfs.vfs_dqrwlock;], 
ac_cv_solaris_ufsvfs_has_dqrwlock=yes,
ac_cv_solaris_ufsvfs_has_dqrwlock=no)])
AC_MSG_RESULT($ac_cv_solaris_ufsvfs_has_dqrwlock)
if test "$ac_cv_solaris_ufsvfs_has_dqrwlock" = "yes"; then
  AC_DEFINE(HAVE_VFS_DQRWLOCK, 1, [define if struct ufsvfs has vfs_dqrwlock])
fi
])


AC_DEFUN([SOLARIS_PROC_HAS_P_COREFILE], [
AC_MSG_CHECKING(for p_corefile in struct proc)
AC_CACHE_VAL(ac_cv_solaris_proc_has_p_corefile,
[
AC_TRY_COMPILE(
[#define _KERNEL
#include <sys/proc.h>],
[struct proc _proc;
(void) _proc.p_corefile;], 
ac_cv_solaris_proc_has_p_corefile=yes,
ac_cv_solaris_proc_has_p_corefile=no)])
AC_MSG_RESULT($ac_cv_solaris_proc_has_p_corefile)
if test "$ac_cv_solaris_proc_has_p_corefile" = "yes"; then
  AC_DEFINE(HAVE_P_COREFILE, 1, [define if struct proc has p_corefile])
fi
])


AC_DEFUN([SOLARIS_FS_HAS_FS_ROLLED], [
AC_MSG_CHECKING(for fs_rolled in struct proc)
AC_CACHE_VAL(ac_cv_solaris_fs_has_fs_rolled,
[
AC_TRY_COMPILE(
[#include <sys/fs/ufs_fs.h>],
[struct fs _fs;
(void) _fs.fs_rolled;], 
ac_cv_solaris_fs_has_fs_rolled=yes,
ac_cv_solaris_fs_has_fs_rolled=no)])
AC_MSG_RESULT($ac_cv_solaris_fs_has_fs_rolled)
if test "$ac_cv_solaris_fs_has_fs_rolled" = "yes"; then
  AC_DEFINE(STRUCT_FS_HAS_FS_ROLLED, 1, [define if struct fs has fs_rolled])
fi
])



AC_DEFUN([OPENAFS_GCC_SUPPORTS_MARCH], [
AC_MSG_CHECKING(if $CC accepts -march=pentium)
save_CFLAGS="$CFLAGS"
CFLAGS="-MARCH=pentium"
AC_CACHE_VAL(openafs_gcc_supports_march,[
AC_TRY_COMPILE(
[],
[int x;],
openafs_gcc_supports_march=yes,
openafs_gcc_supports_march=no)])
AC_MSG_RESULT($openafs_gcc_supports_march)
if test x$openafs_gcc_supports_march = xyes; then
  P5PLUS_KOPTS="-march=pentium"
else
  P5PLUS_KOPTS="-m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2"
fi
CFLAGS="$save_CFLAGS"
])

AC_DEFUN([OPENAFS_GCC_NEEDS_NO_STRICT_ALIASING], [
AC_MSG_CHECKING(if $CC needs -fno-strict-aliasing)
save_CFLAGS="$CFLAGS"
CFLAGS="-fno-strict-aliasing"
AC_CACHE_VAL(openafs_gcc_needs_no_strict_aliasing,[
AC_TRY_COMPILE(
[],
[int x;],
openafs_gcc_needs_no_strict_aliasing=yes,
openafs_gcc_needs_no_strict_aliasing=no)])
AC_MSG_RESULT($openafs_gcc_needs_no_strict_aliasing)
if test x$openafs_gcc_needs_no_strict_aliasing = xyes; then
  LINUX_GCC_KOPTS="$LINUX_GCC_KOPTS -fno-strict-aliasing"
fi
CFLAGS="$save_CFLAGS"
])

AC_DEFUN([OPENAFS_GCC_NEEDS_NO_STRENGTH_REDUCE], [
AC_MSG_CHECKING(if $CC needs -fno-strength-reduce)
save_CFLAGS="$CFLAGS"
CFLAGS="-fno-strength-reduce"
AC_CACHE_VAL(openafs_gcc_needs_no_strength_reduce,[
AC_TRY_COMPILE(
[],
[int x;],
openafs_gcc_needs_no_strength_reduce=yes,
openafs_gcc_needs_no_strength_reduce=no)])
AC_MSG_RESULT($openafs_gcc_needs_no_strength_reduce)
if test x$openafs_gcc_needs_no_strength_reduce = xyes; then
  LINUX_GCC_KOPTS="$LINUX_GCC_KOPTS -fno-strength-reduce"
fi
CFLAGS="$save_CFLAGS"
])

AC_DEFUN([OPENAFS_GCC_SUPPORTS_NO_COMMON], [
AC_MSG_CHECKING(if $CC supports -fno-common)
save_CFLAGS="$CFLAGS"
CFLAGS="-fno-common"
AC_CACHE_VAL(openafs_gcc_supports_no_common,[
AC_TRY_COMPILE(
[],
[int x;],
openafs_gcc_supports_no_common=yes,
openafs_gcc_supports_no_common=no)])
AC_MSG_RESULT($openafs_gcc_supports_no_common)
if test x$openafs_gcc_supports_no_common = xyes; then
  LINUX_GCC_KOPTS="$LINUX_GCC_KOPTS -fno-common"
fi
CFLAGS="$save_CFLAGS"
])

AC_DEFUN([OPENAFS_GCC_SUPPORTS_PIPE], [
AC_MSG_CHECKING(if $CC supports -pipe)
save_CFLAGS="$CFLAGS"
CFLAGS="-pipe"
AC_CACHE_VAL(openafs_gcc_supports_pipe,[
AC_TRY_COMPILE(
[],
[int x;],
openafs_gcc_supports_pipe=yes,
openafs_gcc_supports_pipe=no)])
AC_MSG_RESULT($openafs_gcc_supports_pipe)
if test x$openafs_gcc_supports_pipe = xyes; then
  LINUX_GCC_KOPTS="$LINUX_GCC_KOPTS -pipe"
fi
CFLAGS="$save_CFLAGS"
])

AC_DEFUN([LINUX_FS_STRUCT_ADDRESS_SPACE_HAS_GFP_MASK], [
AC_MSG_CHECKING(for gfp_mask in struct address_space)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_address_space_has_gfp_mask, 
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct address_space _a;
printf("%d\n", _a.gfp_mask);], 
ac_cv_linux_fs_struct_address_space_has_gfp_mask=yes,
ac_cv_linux_fs_struct_address_space_has_gfp_mask=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_address_space_has_gfp_mask)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_FS_STRUCT_INODE_HAS_I_BYTES], [
AC_MSG_CHECKING(for i_bytes in struct inode)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_inode_has_i_bytes, 
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _inode;
printf("%d\n", _inode.i_bytes);], 
ac_cv_linux_fs_struct_inode_has_i_bytes=yes,
ac_cv_linux_fs_struct_inode_has_i_bytes=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_inode_has_i_bytes)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_FS_STRUCT_INODE_HAS_I_ALLOC_SEM], [
AC_MSG_CHECKING(for i_alloc_sem in struct inode)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_inode_has_i_alloc_sem,
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _i;
printf("%x\n", _i.i_alloc_sem);], 
ac_cv_linux_fs_struct_inode_has_i_alloc_sem=yes,
ac_cv_linux_fs_struct_inode_has_i_alloc_sem=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_inode_has_i_alloc_sem)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_FS_STRUCT_INODE_HAS_I_TRUNCATE_SEM], [
AC_MSG_CHECKING(for i_truncate_sem in struct inode)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_inode_has_i_truncate_sem,
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _i;
printf("%x\n", _i.i_truncate_sem);], 
ac_cv_linux_fs_struct_inode_has_i_truncate_sem=yes,
ac_cv_linux_fs_struct_inode_has_i_truncate_sem=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_inode_has_i_truncate_sem)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_FS_STRUCT_ADDRESS_SPACE_HAS_PAGE_LOCK], [
AC_MSG_CHECKING(for page_lock in struct address_space)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_address_space_has_page_lock, 
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct address_space _a_s;
printf("%x\n", _a_s.page_lock);], 
ac_cv_linux_fs_struct_address_space_has_page_lock=yes,
ac_cv_linux_fs_struct_address_space_has_page_lock=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_address_space_has_page_lock)
CPPFLAGS="$save_CPPFLAGS"])


dnl LINUX_BUILD_VNODE_FROM_INODE (configdir, outputdir, tmpldir)
dnl		defaults: (src/config, src/afs/LINUX, src/afs/linux)

AC_DEFUN([LINUX_BUILD_VNODE_FROM_INODE], [
AC_MSG_CHECKING(whether to build osi_vfs.h)
configdir=ifelse([$1], ,[src/config],$1)
outputdir=ifelse([$2], ,[src/afs/LINUX],$2)
tmpldir=ifelse([$3], ,[src/afs/LINUX],$3)
chmod +x $configdir/make_vnode.pl
$configdir/make_vnode.pl -i $LINUX_KERNEL_PATH -t ${tmpldir} -o $outputdir
])

AC_DEFUN([LINUX_COMPLETION_H_EXISTS], [
AC_MSG_CHECKING(for linux/completion.h existance)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_completion_h_exists,
[
AC_TRY_COMPILE(
[#include <linux/completion.h>
#include <linux/version.h>],
[struct completion _c;
#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,8)
lose
#endif
],
ac_cv_linux_completion_h_exists=yes,
ac_cv_linux_completion_h_exists=no)])
AC_MSG_RESULT($ac_cv_linux_completion_h_exists)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_DEFINES_FOR_EACH_PROCESS], [
AC_MSG_CHECKING(for defined for_each_process)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_defines_for_each_process,
[
AC_TRY_COMPILE(
[#include <linux/sched.h>],
[#ifndef for_each_process(p)
#error for_each_process not defined
#endif],
ac_cv_linux_defines_for_each_process=yes,
ac_cv_linux_defines_for_each_process=no)])
AC_MSG_RESULT($ac_cv_linux_defines_for_each_process)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_DEFINES_PREV_TASK], [
AC_MSG_CHECKING(for defined prev_task)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_defines_prev_task,
[
AC_TRY_COMPILE(
[#include <linux/sched.h>],
[#ifndef prev_task(p)
#error prev_task not defined
#endif],
ac_cv_linux_defines_prev_task=yes,
ac_cv_linux_defines_prev_task=no)])
AC_MSG_RESULT($ac_cv_linux_defines_prev_task)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_EXPORTS_INIT_MM], [
AC_MSG_CHECKING(for exported init_mm)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_exports_init_mm,
[
AC_TRY_COMPILE(
[#include <linux/modversions.h>],
[#ifndef __ver_init_mm
#error init_mm not exported
#endif],
ac_cv_linux_exports_init_mm=yes,
ac_cv_linux_exports_init_mm=no)])
AC_MSG_RESULT($ac_cv_linux_exports_init_mm)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_EXPORTS_KALLSYMS_ADDRESS], [
AC_MSG_CHECKING(for exported kallsyms_address_to_symbol)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_exports_kallsyms_address,
[
AC_TRY_COMPILE(
[#include <linux/modversions.h>],
[#ifndef __ver_kallsyms_address_to_symbol
#error kallsyms_address_to_symbol not exported
#endif],
ac_cv_linux_exports_kallsyms_address=yes,
ac_cv_linux_exports_kallsyms_address=no)])
AC_MSG_RESULT($ac_cv_linux_exports_kallsyms_address)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_EXPORTS_KALLSYMS_SYMBOL], [
AC_MSG_CHECKING(for exported kallsyms_symbol_to_address)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_exports_kallsyms_symbol,
[
AC_TRY_COMPILE(
[#include <linux/modversions.h>],
[#ifndef __ver_kallsyms_symbol_to_address
#error kallsyms_symbol_to_address not exported
#endif],
ac_cv_linux_exports_kallsyms_symbol=yes,
ac_cv_linux_exports_kallsyms_symbol=no)])
AC_MSG_RESULT($ac_cv_linux_exports_kallsyms_symbol)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_EXPORTS_SYS_CALL_TABLE], [
AC_MSG_CHECKING(for exported sys_call_table)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_exports_sys_call_table,
[
AC_TRY_COMPILE(
[#include <linux/modversions.h>],
[#ifndef __ver_sys_call_table
#error sys_call_table not exported
#endif],
ac_cv_linux_exports_sys_call_table=yes,
ac_cv_linux_exports_sys_call_table=no)])
AC_MSG_RESULT($ac_cv_linux_exports_sys_call_table)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_EXPORTS_IA32_SYS_CALL_TABLE], [
AC_MSG_CHECKING(for exported ia32_sys_call_table)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_exports_ia32_sys_call_table,
[
AC_TRY_COMPILE(
[#include <linux/modversions.h>],
[#ifndef __ver_ia32_sys_call_table
#error ia32_sys_call_table not exported
#endif],
ac_cv_linux_exports_ia32_sys_call_table=yes,
ac_cv_linux_exports_ia32_sys_call_table=no)])
AC_MSG_RESULT($ac_cv_linux_exports_ia32_sys_call_table)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_EXPORTS_SYS_CHDIR], [
AC_MSG_CHECKING(for exported sys_chdir)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_exports_sys_chdir,
[
AC_TRY_COMPILE(
[#include <linux/modversions.h>],
[#ifndef __ver_sys_chdir
#error sys_chdir not exported
#endif],
ac_cv_linux_exports_sys_chdir=yes,
ac_cv_linux_exports_sys_chdir=no)])
AC_MSG_RESULT($ac_cv_linux_exports_sys_chdir)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_EXPORTS_SYS_CLOSE], [
AC_MSG_CHECKING(for exported sys_close)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_exports_sys_close,
[
AC_TRY_COMPILE(
[#include <linux/modversions.h>],
[#ifndef __ver_sys_close
#error sys_close not exported
#endif],
ac_cv_linux_exports_sys_close=yes,
ac_cv_linux_exports_sys_close=no)])
AC_MSG_RESULT($ac_cv_linux_exports_sys_close)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_EXPORTS_SYS_WAIT4], [
AC_MSG_CHECKING(for exported sys_wait4)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_exports_sys_wait4,
[
AC_TRY_COMPILE(
[#include <linux/modversions.h>],
[#ifndef __ver_sys_wait4
#error sys_wait4 not exported
#endif],
ac_cv_linux_exports_sys_wait4=yes,
ac_cv_linux_exports_sys_wait4=no)])
AC_MSG_RESULT($ac_cv_linux_exports_sys_wait4)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_FS_STRUCT_INODE_HAS_I_CDEV], [
AC_MSG_CHECKING(for i_cdev in struct inode)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_inode_has_i_cdev, 
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _inode;
printf("%d\n", _inode.i_cdev);], 
ac_cv_linux_fs_struct_inode_has_i_cdev=yes,
ac_cv_linux_fs_struct_inode_has_i_cdev=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_inode_has_i_cdev)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_FS_STRUCT_INODE_HAS_I_DEVICES], [
AC_MSG_CHECKING(for i_devices in struct inode)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_inode_has_i_cdev, 
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _inode;
printf("%d\n", _inode.i_devices);], 
ac_cv_linux_fs_struct_inode_has_i_devices=yes,
ac_cv_linux_fs_struct_inode_has_i_devices=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_inode_has_i_devices)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_FS_STRUCT_INODE_HAS_I_DIRTY_DATA_BUFFERS], [
AC_MSG_CHECKING(for i_dirty_data_buffers in struct inode)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_inode_has_i_dirty_data_buffers, 
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _inode;
printf("%d\n", _inode.i_dirty_data_buffers);], 
ac_cv_linux_fs_struct_inode_has_i_dirty_data_buffers=yes,
ac_cv_linux_fs_struct_inode_has_i_dirty_data_buffers=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_inode_has_i_dirty_data_buffers)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_FS_STRUCT_INODE_HAS_INOTIFY_LOCK], [
AC_MSG_CHECKING(for inotify_lock in struct inode)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_inode_has_inotify_lock, 
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _inode;
printf("%d\n", _inode.inotify_lock);], 
ac_cv_linux_fs_struct_inode_has_inotify_lock=yes,
ac_cv_linux_fs_struct_inode_has_inotify_lock=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_inode_has_inotify_lock)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_FS_STRUCT_INODE_HAS_I_MAPPING_OVERLOAD], [
AC_MSG_CHECKING(for i_mapping_overload in struct inode)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_inode_has_i_mapping_overload, 
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _inode;
printf("%d\n", _inode.i_mapping_overload);], 
ac_cv_linux_fs_struct_inode_has_i_mapping_overload=yes,
ac_cv_linux_fs_struct_inode_has_i_mapping_overload=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_inode_has_i_mapping_overload)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_FS_STRUCT_INODE_HAS_I_MMAP_SHARED], [
AC_MSG_CHECKING(for i_mmap_shared in struct inode)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_inode_has_i_mmap_shared,
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _inode;
printf("%d\n", _inode.i_mmap_shared);],
ac_cv_linux_fs_struct_inode_has_i_mmap_shared=yes,
ac_cv_linux_fs_struct_inode_has_i_mmap_shared=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_inode_has_i_mmap_shared)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_FS_STRUCT_INODE_HAS_I_SECURITY], [
AC_MSG_CHECKING(for i_security in struct inode)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_inode_has_i_security, 
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _inode;
printf("%d\n", _inode.i_security);], 
ac_cv_linux_fs_struct_inode_has_i_security=yes,
ac_cv_linux_fs_struct_inode_has_i_security=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_inode_has_i_security)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_FS_STRUCT_INODE_HAS_I_SB_LIST], [
AC_MSG_CHECKING(for i_sb_list in struct inode)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_fs_struct_inode_has_i_sb_list, 
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _inode;
printf("%d\n", _inode.i_sb_list);], 
ac_cv_linux_fs_struct_inode_has_i_sb_list=yes,
ac_cv_linux_fs_struct_inode_has_i_sb_list=no)])
AC_MSG_RESULT($ac_cv_linux_fs_struct_inode_has_i_sb_list)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_RECALC_SIGPENDING_ARG_TYPE],[
AC_MSG_CHECKING(for recalc_sigpending arg type)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_func_recalc_sigpending_takes_void,
[
AC_TRY_COMPILE(
[#include <linux/sched.h>],
[recalc_sigpending();],
ac_cv_linux_func_recalc_sigpending_takes_void=yes,
ac_cv_linux_func_recalc_sigpending_takes_void=no)])
AC_MSG_RESULT($ac_cv_linux_func_recalc_sigpending_takes_void)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_PARENT], [
AC_MSG_CHECKING(for parent in struct task_struct)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_sched_struct_task_struct_has_parent,
[
AC_TRY_COMPILE(
[#include <linux/sched.h>],
[struct task_struct _tsk;
printf("%d\n", _tsk.parent);],
ac_cv_linux_sched_struct_task_struct_has_parent=yes,
ac_cv_linux_sched_struct_task_struct_has_parent=no)])
AC_MSG_RESULT($ac_cv_linux_sched_struct_task_struct_has_parent)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_REAL_PARENT], [
AC_MSG_CHECKING(for real_parent in struct task_struct)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_sched_struct_task_struct_has_real_parent,
[
AC_TRY_COMPILE(
[#include <linux/sched.h>],
[struct task_struct _tsk;
printf("%d\n", _tsk.real_parent);],
ac_cv_linux_sched_struct_task_struct_has_real_parent=yes,
ac_cv_linux_sched_struct_task_struct_has_real_parent=no)])
AC_MSG_RESULT($ac_cv_linux_sched_struct_task_struct_has_real_parent)
CPPFLAGS="$save_CPPFLAGS"])


AC_DEFUN([LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_SIG], [
AC_MSG_CHECKING(for sig in struct task_struct)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_sched_struct_task_struct_has_sig,
[
AC_TRY_COMPILE(
[#include <linux/sched.h>],
[struct task_struct _tsk;
printf("%d\n", _tsk.sig);],
ac_cv_linux_sched_struct_task_struct_has_sig=yes,
ac_cv_linux_sched_struct_task_struct_has_sig=no)])
AC_MSG_RESULT($ac_cv_linux_sched_struct_task_struct_has_sig)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_SIGMASK_LOCK], [
AC_MSG_CHECKING(for sigmask_lock in struct task_struct)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_sched_struct_task_struct_has_sigmask_lock,
[
AC_TRY_COMPILE(
[#include <linux/sched.h>],
[struct task_struct _tsk;
printf("%d\n", _tsk.sigmask_lock);],
ac_cv_linux_sched_struct_task_struct_has_sigmask_lock=yes,
ac_cv_linux_sched_struct_task_struct_has_sigmask_lock=no)])
AC_MSG_RESULT($ac_cv_linux_sched_struct_task_struct_has_sigmask_lock)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_SIGHAND], [
AC_MSG_CHECKING(for sighand in struct task_struct)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_sched_struct_task_struct_has_sighand,
[
AC_TRY_COMPILE(
[#include <linux/sched.h>],
[struct task_struct _tsk;
printf("%d\n", _tsk.sighand);],
ac_cv_linux_sched_struct_task_struct_has_sighand=yes,
ac_cv_linux_sched_struct_task_struct_has_sighand=no)])
AC_MSG_RESULT($ac_cv_linux_sched_struct_task_struct_has_sighand)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_RLIM], [
AC_MSG_CHECKING(for rlim in struct task_struct)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_sched_struct_task_struct_has_rlim,
[
AC_TRY_COMPILE(
[#include <linux/sched.h>],
[struct task_struct _tsk;
printf("%d\n", _tsk.rlim);],
ac_cv_linux_sched_struct_task_struct_has_rlim=yes,
ac_cv_linux_sched_struct_task_struct_has_rlim=no)])
AC_MSG_RESULT($ac_cv_linux_sched_struct_task_struct_has_rlim)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_SIGNAL_RLIM], [
AC_MSG_CHECKING(for signal->rlim in struct task_struct)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_sched_struct_task_struct_has_signal_rlim,
[
AC_TRY_COMPILE(
[#include <linux/sched.h>],
[struct task_struct _tsk;
printf("%d\n", _tsk.signal->rlim);],
ac_cv_linux_sched_struct_task_struct_has_signal_rlim=yes,
ac_cv_linux_sched_struct_task_struct_has_signal_rlim=no)])
AC_MSG_RESULT($ac_cv_linux_sched_struct_task_struct_has_signal_rlim)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_SCHED_STRUCT_TASK_STRUCT_HAS_EXIT_STATE], [
AC_MSG_CHECKING(for exit_state in struct task_struct)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_sched_struct_task_struct_has_exit_state,
[
AC_TRY_COMPILE(
[#include <linux/sched.h>],
[struct task_struct _tsk;
printf("%d\n", _tsk.exit_state);],
ac_cv_linux_sched_struct_task_struct_has_exit_state=yes,
ac_cv_linux_sched_struct_task_struct_has_exit_state=no)])
AC_MSG_RESULT($ac_cv_linux_sched_struct_task_struct_has_exit_state)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_INODE_SETATTR_RETURN_TYPE],[
AC_MSG_CHECKING(for inode_setattr return type)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_func_inode_setattr_returns_int,
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _inode; 
struct iattr _iattr;
int i; 
i = inode_setattr(&_inode, &_iattr);], 
ac_cv_linux_func_inode_setattr_returns_int=yes,
ac_cv_linux_func_inode_setattr_returns_int=no)])
AC_MSG_RESULT($ac_cv_linux_func_inode_setattr_returns_int)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_WRITE_INODE_RETURN_TYPE],[
AC_MSG_CHECKING(for write_inode return type)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_func_write_inode_returns_int,
[
AC_TRY_COMPILE(
[#include <linux/fs.h>],
[struct inode _inode; 
struct super_operations _sops;
int i; 
i = _sops.write_inode(&_inode, 0);], 
ac_cv_linux_func_write_inode_returns_int=yes,
ac_cv_linux_func_write_inode_returns_int=no)])
AC_MSG_RESULT($ac_cv_linux_func_write_inode_returns_int)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_IOP_NAMEIDATA],[
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_MSG_CHECKING(whether inode_operations.create takes a nameidata)
AC_CACHE_VAL(ac_cv_linux_func_i_create_takes_nameidata,
[
AC_TRY_COMPILE(
[#include <linux/fs.h>
#include <linux/namei.h>],
[struct inode _inode; 
struct dentry _dentry;
struct nameidata _nameidata;
(void)_inode.i_op->create(&_inode, &_dentry, 0, &_nameidata);],
ac_cv_linux_func_i_create_takes_nameidata=yes,
ac_cv_linux_func_i_create_takes_nameidata=no)])
AC_MSG_RESULT($ac_cv_linux_func_i_create_takes_nameidata)
if test "x$ac_cv_linux_func_i_create_takes_nameidata" = "xyes" ; then
AC_DEFINE(IOP_CREATE_TAKES_NAMEIDATA, 1, [define if your iops.create takes a nameidata argument])
fi
AC_MSG_CHECKING(whether inode_operations.lookup takes a nameidata)
AC_CACHE_VAL(ac_cv_linux_func_i_lookup_takes_nameidata,
[
AC_TRY_COMPILE(
[#include <linux/fs.h>
#include <linux/namei.h>],
[struct inode _inode; 
struct dentry _dentry;
struct nameidata _nameidata;
(void)_inode.i_op->lookup(&_inode, &_dentry, &_nameidata);],
ac_cv_linux_func_i_lookup_takes_nameidata=yes,
ac_cv_linux_func_i_lookup_takes_nameidata=no)])
AC_MSG_RESULT($ac_cv_linux_func_i_lookup_takes_nameidata)
if test "x$ac_cv_linux_func_i_lookup_takes_nameidata" = "xyes" ; then
AC_DEFINE(IOP_LOOKUP_TAKES_NAMEIDATA, 1, [define if your iops.lookup takes a nameidata argument])
fi
AC_MSG_CHECKING(whether inode_operations.permission takes a nameidata)
AC_CACHE_VAL(ac_cv_linux_func_i_permission_takes_nameidata,
[
AC_TRY_COMPILE(
[#include <linux/fs.h>
#include <linux/namei.h>],
[struct inode _inode; 
struct nameidata _nameidata;
(void)_inode.i_op->permission(&_inode, 0, &_nameidata);],
ac_cv_linux_func_i_permission_takes_nameidata=yes,
ac_cv_linux_func_i_permission_takes_nameidata=no)])
AC_MSG_RESULT($ac_cv_linux_func_i_permission_takes_nameidata)
if test "x$ac_cv_linux_func_i_permission_takes_nameidata" = "xyes" ; then
AC_DEFINE(IOP_PERMISSION_TAKES_NAMEIDATA, 1, [define if your iops.permission takes a nameidata argument])
fi
AC_MSG_CHECKING(whether dentry_operations.d_revalidate takes a nameidata)
CPPFLAGS="$CPPFLAGS -Werror"
AC_CACHE_VAL(ac_cv_linux_func_d_revalidate_takes_nameidata,
[
AC_TRY_COMPILE(
[#include <linux/fs.h>
#include <linux/namei.h>],
[struct dentry _dentry; 
struct nameidata _nameidata;
(void)_dentry.d_op->d_revalidate(&_dentry, &_nameidata);],
ac_cv_linux_func_d_revalidate_takes_nameidata=yes,
ac_cv_linux_func_d_revalidate_takes_nameidata=no)])
AC_MSG_RESULT($ac_cv_linux_func_d_revalidate_takes_nameidata)
if test "x$ac_cv_linux_func_d_revalidate_takes_nameidata" = "xyes" ; then
  AC_DEFINE(DOP_REVALIDATE_TAKES_NAMEIDATA, 1, [define if your dops.d_revalidate takes a nameidata argument])
fi
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_AOP_WRITEBACK_CONTROL],[
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -I${LINUX_KERNEL_PATH}/include/asm/mach-${SUBARCH} -D__KERNEL__ $CPPFLAGS"
AC_MSG_CHECKING(whether address_space_operations.writepage takes a writeback_control)
AC_CACHE_VAL(ac_cv_linux_func_a_writepage_takes_writeback_control,
[
AC_TRY_COMPILE(
[#include <linux/fs.h>
#include <linux/mm.h>
#include <linux/writeback.h>],
[struct address_space_operations _aops; 
struct page _page;
struct writeback_control _writeback_control;
(void)_aops.writepage(&_page, &_writeback_control);],
ac_cv_linux_func_a_writepage_takes_writeback_control=yes,
ac_cv_linux_func_a_writepage_takes_writeback_control=no)])
AC_MSG_RESULT($ac_cv_linux_func_a_writepage_takes_writeback_control)
if test "x$ac_cv_linux_func_a_writepage_takes_writeback_control" = "xyes" ; then
AC_DEFINE(AOP_WRITEPAGE_TAKES_WRITEBACK_CONTROL, 1, [define if your aops.writepage takes a struct writeback_control argument])
fi
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_KERNEL_LINUX_SYSCALL_H],[
  AC_MSG_CHECKING(for linux/syscall.h in kernel)
  if test -f "${LINUX_KERNEL_PATH}/include/linux/syscall.h"; then
    ac_linux_syscall=yes
    AC_MSG_RESULT($ac_linux_syscall)
  else
    ac_linux_syscall=no
    AC_MSG_RESULT($ac_linux_syscall)
  fi
])

AC_DEFUN([LINUX_NEED_RHCONFIG],[
RHCONFIG_SP=""
RHCONFIG_MP=""
if test "x$enable_redhat_buildsys" = "xyes"; then
  AC_MSG_WARN(Configured to build from a Red Hat SPEC file)
else
  AC_MSG_CHECKING(for redhat kernel configuration)
  if test -f "${LINUX_KERNEL_PATH}/include/linux/rhconfig.h"; then
    ac_linux_rhconfig=yes
    RHCONFIG_SP="-D__BOOT_KERNEL_UP=1 -D__BOOT_KERNEL_SMP=0"
    RHCONFIG_MP="-D__BOOT_KERNEL_UP=0 -D__BOOT_KERNEL_SMP=1"
    AC_MSG_RESULT($ac_linux_rhconfig)
    if test ! -f "/boot/kernel.h"; then
        AC_MSG_WARN([/boot/kernel.h does not exist. build may fail])
    fi
  else
    ac_linux_rhconfig=no
    AC_MSG_RESULT($ac_linux_rhconfig)
  fi
fi
AC_SUBST(RHCONFIG_SP)
AC_SUBST(RHCONFIG_MP)
])

AC_DEFUN([LINUX_WHICH_MODULES],[
if test "x$enable_redhat_buildsys" = "xyes"; then
  MPS=Default
else
  save_CPPFLAGS="$CPPFLAGS"
  CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -D__KERNEL__ $RHCONFIG_SP $CPPFLAGS"
  AC_MSG_CHECKING(if kernel uses MODVERSIONS)
  AC_CACHE_VAL(ac_cv_linux_config_modversions,[
  AC_TRY_COMPILE(
[#include <linux/version.h>
#include <linux/config.h>
],
[#if !defined(CONFIG_MODVERSIONS)
lose;
#endif
],
  ac_cv_linux_config_modversions=yes,
  ac_cv_linux_config_modversions=no)])
  AC_MSG_RESULT($ac_cv_linux_config_modversions)
  AC_MSG_CHECKING(which kernel modules to build)
  if false; then
      MPS="MP SP"
  elif test "x$ac_cv_linux_config_modversions" = "xno" -a "$AFS_SYSKVERS" -lt 26; then
      MPS="MP SP"
  else
  AC_CACHE_VAL(ac_cv_linux_config_smp, [
  AC_TRY_COMPILE(
[#include <linux/config.h>
],
[#ifndef CONFIG_SMP
lose;
#endif
],
  ac_cv_linux_config_smp=yes,
  ac_cv_linux_config_smp=no)])
  dnl AC_MSG_RESULT($ac_cv_linux_config_smp)
      if test "x$ac_cv_linux_config_smp" = "xyes"; then
          MPS=MP
      else
          MPS=SP
      fi
  fi
  CPPFLAGS=$save_CPPFLAGS
  AC_MSG_RESULT($MPS)
fi
AC_SUBST(MPS)
])

AC_DEFUN([LINUX_KERNEL_SELINUX],[
AC_MSG_CHECKING(for SELinux kernel)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_kernel_is_selinux,
[
AC_TRY_COMPILE(
  [#include <linux/autoconf.h>],
  [#ifndef CONFIG_SECURITY_SELINUX
   #error not SELINUX
   #endif],
  ac_cv_linux_kernel_is_selinux=yes,
  ac_cv_linux_kernel_is_selinux=no)])
AC_MSG_RESULT($ac_cv_linux_kernel_is_selinux)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_KERNEL_SOCK_CREATE],[
AC_MSG_CHECKING(for 5th argument in sock_create found in some SELinux kernels)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_kernel_sock_create_v,
[
AC_TRY_COMPILE(
  [#include <linux/net.h>],
  [
  sock_create(0,0,0,0,0)
  ],
  ac_cv_linux_kernel_sock_create_v=yes,
  ac_cv_linux_kernel_sock_create_v=no)])
AC_MSG_RESULT($ac_cv_linux_kernel_sock_create_v)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([LINUX_KERNEL_PAGE_FOLLOW_LINK],[
AC_MSG_CHECKING(for page_follow_link_light vs page_follow_link)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="-I${LINUX_KERNEL_PATH}/include -Werror-implicit-function-declaration -D__KERNEL__ $CPPFLAGS"
AC_CACHE_VAL(ac_cv_linux_kernel_page_follow_link,
[
AC_TRY_COMPILE(
  [#include <linux/fs.h>],
  [
  page_follow_link(0,0)
  ],
  ac_cv_linux_kernel_page_follow_link=yes,
  ac_cv_linux_kernel_page_follow_link=no)])
AC_MSG_RESULT($ac_cv_linux_kernel_page_follow_link)
CPPFLAGS="$save_CPPFLAGS"])

AC_DEFUN([AC_FUNC_RES_SEARCH], [
  ac_cv_func_res_search=no
  AC_TRY_LINK([
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/nameser.h>
#ifdef HAVE_ARPA_NAMESER_COMPAT_H
#include <arpa/nameser_compat.h>
#endif
#include <resolv.h>],
  [
const char host[11]="openafs.org";
u_char ans[1024];
int r;
res_init();
/* Capture result in r but return 0, since a working nameserver is
 * not a requirement for compilation.
 */
r =  res_search( host, C_IN, T_MX, (u_char *)&ans, sizeof(ans));
return 0;
  ],
  ac_cv_func_res_search=yes)
])


AC_DEFUN([OPENAFS_OSCONF], [

dnl defaults, override in case below as needed
XCFLAGS='${DBG} ${OPTMZ}'
SHLIB_SUFFIX="so"
CC="cc"
CCOBJ="cc"
MT_CC="cc"
XLIBS="${LIB_AFSDB}"

dnl debugging and optimization flag defaults
dnl Note, these are all the defaults for if debug/optimize turned on, and
dnl the arch cases below do not override
KERN_DBG=-g
KERN_OPTMZ=-O
DBG=-g
OPTMZ=-O
LWP_DBG=-g
LWP_OPTMZ=-O

dnl standard programs
AC_PROG_RANLIB
AC_CHECK_PROGS(AS, as, [${am_missing_run}as])
AC_CHECK_PROGS(AR, ar, [${am_missing_run}ar])
AC_CHECK_PROGS(MV, mv, [${am_missing_run}mv])
AC_CHECK_PROGS(RM, rm, [${am_missing_run}rm])
AC_CHECK_PROGS(LD, ld, [${am_missing_run}ld])
AC_CHECK_PROGS(CP, cp, [${am_missing_run}cp])
AC_CHECK_PROGS(STRIP, strip, [${am_missing_run}strip])
AC_CHECK_PROGS(LORDER, lorder, [${am_missing_run}lorder])

dnl TODO - need to disable STRIP if we are doing debugging in any user space code

case $AFS_SYSNAME in
	alpha_dux40)
		LEX="lex"
		CSTATIC="-non_shared"
		DBG="-g3"
		MT_CFLAGS='-D_REENTRANT=1 -pthread -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-pthread -lpthread -lmach -lexc -lc"
		TXLIBS="-lcurses"
		XCFLAGS="-D_NO_PROTO -DOSF"
		SHLIB_LINKER="${CC} -all -shared -expect_unresolved \"*\""
		;;

	alpha_dux50)
		LEX="flex -l"
		DBG="-g3"
		CSTATIC="-non_shared"
		MT_CFLAGS='-D_REENTRANT=1 -pthread -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-pthread -lpthread -lmach -lexc -lc"
		TXLIBS="-lcurses"
		XCFLAGS="-D_NO_PROTO -DOSF"
		SHLIB_LINKER="${CC} -all -shared -expect_unresolved \"*\""
		;;

	alpha_dux51)
		LEX="flex -l"
		DBG="-g3"
		CSTATIC="-non_shared"
		LWP_OPTMZ="-O2"
		MT_CFLAGS='-D_REENTRANT=1 -pthread -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-pthread -lpthread -lmach -lexc -lc"
		TXLIBS="-lcurses"
		XCFLAGS="-D_NO_PROTO -DOSF"
		SHLIB_LINKER="${CC} -all -shared -expect_unresolved \"*\""
		;;

	alpha_linux_22)
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O2 -D_LARGEFILE64_SOURCE"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	alpha_linux_24)
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O2 -D_LARGEFILE64_SOURCE"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	hp_ux102)
		AS="/usr/ccs/bin/as"
		CC="/opt/ansic/bin/cc -Ae"
		DBM="/lib/libndbm.a"
		LD="/bin/ld"
		LEX="/opt/langtools/bin/lex"
		LWP_OPTMZ="-O"
		MT_CC="/opt/ansic/bin/cc -Ae"
		MT_CFLAGS='-D_POSIX_C_SOURCE=199506L -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-L/opt/dce/lib -ldce"
		MV="/bin/mv"
		OPTMZ="-O"
		PAM_CFLAGS="+DA1.0 +z -Wl,+k"
		PAM_LIBS="/usr/lib/libpam.1"
		RANLIB="/usr/bin/ranlib"
		RM="/bin/rm"
		SHLIB_LDFLAGS="-b -Bsymbolic"
		SHLIB_SUFFIX="sl"
		TXLIBS="/usr/lib/libHcurses.a"
		VFSCK_CFLAGS="-D_FILE64"
		XCFLAGS0="-ldld -lc -Wp,-H200000 -Wl,-a,archive -DAUTH_DBM_LOG +z -Wl,+k -D_LARGEFILE64_SOURCE"
		XCFLAGS64="${XCFLAGS0} +DA2.0W"
		XCFLAGS="${XCFLAGS0} +DA1.0"
		YACC="/opt/langtools/bin/yacc"
		SHLIB_LINKER="ld -b"
		;;

	hp_ux11*)
		AR="/usr/bin/ar"
		AS="/usr/ccs/bin/as"
		CC="/opt/ansic/bin/cc"
		CCOBJ="/opt/ansic/bin/cc"
		DBM="/lib/libndbm.a"
		LD="/bin/ld   "
		LEX="/opt/langtools/bin/lex"
		LWP_OPTMZ="-O"
		MT_CC="$CC"
		MT_CFLAGS='-D_POSIX_C_SOURCE=199506L -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread"
		MV="/bin/mv"
		OPTMZ="-O"
		PAM_CFLAGS="+DA1.0 +z -Wl,+k"
		PAM_LIBS="/usr/lib/libpam.1"
		RANLIB="/usr/bin/ranlib"
		RM="/bin/rm"
		SHLIB_LDFLAGS="-b -Bsymbolic"
		SHLIB_SUFFIX="sl"
		TXLIBS="/usr/lib/libHcurses.a"
		VFSCK_CFLAGS="-I/usr/old/usr/include -D_FILE64"
		XCFLAGS0="-ldld -lc -Wp,-H200000 -Wl,-a,archive -DAUTH_DBM_LOG +z -Wl,+k -D_LARGEFILE64_SOURCE"
		XCFLAGS64="${XCFLAGS0} +DA2.0W"
		XCFLAGS="${XCFLAGS0} +DA1.0"
		XLIBELFA="-lelf"
		#XLIBS="${LIB_AFSDB} -lnsl"
		XLIBS="${LIB_AFSDB}"
		YACC="/opt/langtools/bin/yacc"
		SHLIB_LINKER="ld -b"
		;;

	ia64_hpux*)
		AR="/usr/bin/ar"
		AS="/usr/ccs/bin/as"
		CC="/opt/ansic/bin/cc"
		CCOBJ="/opt/ansic/bin/cc"
		DBM="/lib/hpux32/libndbm.so"
		LD="/bin/ld   "
		LEX="/opt/langtools/bin/lex"
		LWP_OPTMZ=""
		MT_CC="$CC"
		MT_CFLAGS='-D_POSIX_C_SOURCE=199506L -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread"
		MV="/bin/mv"
		OPTMZ="-O"
		PAM_CFLAGS="-b +z -Wl,+k"
		PAM_LIBS="/usr/lib/hpux32/libpam.so"
		RANLIB="/usr/bin/ranlib"
		RM="/bin/rm"
		SHLIB_LDFLAGS="-b -Bsymbolic"
		SHLIB_SUFFIX="sl"
		TXLIBS="/usr/lib/hpux32/libcurses.so"
		VFSCK_CFLAGS="-I/usr/old/usr/include -D_FILE64"
		XCFLAGS0="-ldld -lc -Wp,-H200000 -Wl,-a,archive_shared -DAUTH_DBM_LOG +z -Wl,+k -D_LARGEFILE64_SOURCE"
		XCFLAGS64="${XCFLAGS0} +DD64"
		XCFLAGS="${XCFLAGS0}"
		XLIBELFA="-lelf"
		#XLIBS="${LIB_AFSDB} -lnsl"
		XLIBS="${LIB_AFSDB}"
		YACC="/opt/langtools/bin/yacc"
		SHLIB_LINKER="ld -b"
		;;

	*fbsd_*)
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-pthread"
		PAM_CFLAGS="-O2 -pipe -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O2 -pipe"
		YACC="byacc"
		;;

	*nbsd2*|*nbsd3*)
		LEX="flex -l"
		MT_CFLAGS='${XCFLAGS} -DAFS_PTHREAD_ENV -D_REENTRANT '
		MT_LIBS="-lpthread" # XXX -pthread soon
		PAM_CFLAGS="-O2 -pipe -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="/usr/lib/libcurses.so"
		XCFLAGS="-O2 -pipe"
		YACC="yacc"
		;;

	*nbsd15|*nbsd16)
		LEX="flex -l"
		MT_CFLAGS='${XCFLAGS}'
		MT_LIBS=""
		PAM_CFLAGS="-O2 -pipe -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="/usr/lib/libcurses.so"
		XCFLAGS="-O2 -pipe"
		YACC="bison -y"
		;;

	ia64_linux24|ia64_linux26)
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-g -O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-g -O2 -D_LARGEFILE64_SOURCE -G0"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	amd64_linux*)
		CCOBJ="${CC} -fPIC"
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-g -O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_CFLAGS="-fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-g -O2 -D_LARGEFILE64_SOURCE"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	ppc64_linux24)
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-g -O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="/usr/lib64/libncurses.so"
		XCFLAGS="-g -O2 -D_LARGEFILE64_SOURCE"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	ppc64_linux26)
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-g -O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-g -O2 -D_LARGEFILE64_SOURCE"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	i386_umlinux22)
		CC="gcc -pipe"
		CCOBJ="gcc -pipe"
		MT_CC="gcc -pipe"
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O2 -D_LARGEFILE64_SOURCE"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	i386_linux*)
		CC="gcc -pipe"
		CCOBJ="gcc -pipe"
		MT_CC="gcc -pipe"
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		DBG=-g
		KERN_DBG=-g
		LWP_DBG=-g
		LWP_OPTMZ=-O2
		OPTMZ=-O2
		PAM_CFLAGS="-g -O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-g -O2 -D_LARGEFILE64_SOURCE"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	i386_umlinux24)
		CC="gcc -pipe"
		CCOBJ="gcc -pipe"
		MT_CC="gcc -pipe"
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		DBG=-g
		KERN_DBG=-g
		LWP_DBG=-g
		LWP_OPTMZ=-O2
		OPTMZ=-O2
		PAM_CFLAGS="-g -O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-g -O2 -D_LARGEFILE64_SOURCE"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	i386_umlinux26)
		CC="gcc -pipe"
		CCOBJ="gcc -pipe"
		MT_CC="gcc -pipe"
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		DBG=-g
		KERN_DBG=-g
		LWP_DBG=-g
		LWP_OPTMZ=-O2
		OPTMZ=-O2
		PAM_CFLAGS="-g -O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-g -O2 -D_LARGEFILE64_SOURCE"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	*_obsd*)
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-pthread"
		PAM_CFLAGS="-O2 -pipe -fpic"
		SHLIB_CFLAGS="-fpic"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="/usr/lib/libcurses.a"
		XCFLAGS="-O2"
		YACC="yacc"
		;;

	parisc_linux24)
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O2 -D_LARGEFILE64_SOURCE"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	ppc_darwin_12)
		AFSD_LDFLAGS="-F/System/Library/PrivateFrameworks -framework DiskArbitration"
		LEX="lex -l"
		REGEX_OBJ="regex.o"
		XCFLAGS="-traditional-cpp"
		;;

	ppc_darwin_13)
		AFSD_LDFLAGS="-F/System/Library/PrivateFrameworks -framework DiskArbitration"
		LEX="lex -l"
		LWP_OPTMZ="-O2"
		REGEX_OBJ="regex.o"
		XCFLAGS="-no-cpp-precomp"
		;;

	ppc_darwin_14)
		AFSD_LDFLAGS="-F/System/Library/PrivateFrameworks -framework DiskArbitration"
		LEX="lex -l"
		LWP_OPTMZ="-O2"
		REGEX_OBJ="regex.o"
		XCFLAGS="-no-cpp-precomp"
		;;

	ppc_darwin_60)
		AFSD_LDFLAGS="-F/System/Library/PrivateFrameworks -framework DiskArbitration"
		LEX="lex -l"
		LWP_OPTMZ="-O2"
		REGEX_OBJ="regex.o"
		XCFLAGS="-no-cpp-precomp"
		TXLIBS="-lncurses"
		;;

	ppc_darwin_70)
		AFSD_LDFLAGS="-F/System/Library/PrivateFrameworks -framework DiskArbitration"
		LEX="lex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -D_REENTRANT ${XCFLAGS}'
		KROOT=
		KINCLUDES='-I$(KROOT)/System/Library/Frameworks/Kernel.framework/Headers'
		LWP_OPTMZ="-O2"
		REGEX_OBJ="regex.o"
		XCFLAGS="-no-cpp-precomp"
		TXLIBS="-lncurses"
		EXTRA_VLIBOBJS="fstab.o"
		;;

	ppc_linux*)
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O2 -D_LARGEFILE64_SOURCE"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	rs_aix42)
		DBG=""
		LEX="lex"
		LIBSYS_AIX_EXP="afsl.exp"
		MT_CC="xlc_r"
		MT_CFLAGS='-DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthreads"
		SHLIB_SUFFIX="o"
		TXLIBS="-lcurses"
		XCFLAGS="-K -D_NO_PROTO -D_NONSTD_TYPES -D_MBI=void"
		XLIBS="${LIB_AFSDB} -ldl"
		SHLIB_LINKER="${MT_CC} -bM:SRE -berok"
		AIX64="#"
		;;


	rs_aix51)
		DBG=""
		LEX="lex"
		LIBSYS_AIX_EXP="afsl.exp"
		MT_CC="xlc_r"
		MT_CFLAGS='-DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthreads"
		SHLIB_SUFFIX="o"
		TXLIBS="-lcurses"
		XCFLAGS="-K -D_NO_PROTO -D_NONSTD_TYPES -D_MBI=void"
		XLIBS="${LIB_AFSDB} -ldl"
		SHLIB_LINKER="${MT_CC} -bM:SRE -berok"
		AIX64=""
		;;

	rs_aix52)	
		DBG=""
		LEX="lex"
		LIBSYS_AIX_EXP="afsl.exp"
		MT_CC="xlc_r"
		MT_CFLAGS='-DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthreads"
		SHLIB_SUFFIX="o"
		TXLIBS="-lcurses"
		XCFLAGS="-K -D_NO_PROTO -D_NONSTD_TYPES -D_MBI=void"
		XLIBS="${LIB_AFSDB} -ldl"
		SHLIB_LINKER="${MT_CC} -bM:SRE -berok"
		AIX64=""
		;;
	s390_linux22)
		CC="gcc"
		CCOBJ="gcc"
		LD="ld"
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CC="$CC"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-O -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O -g -D_LARGEFILE64_SOURCE"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	s390_linux24|s390_linux26)
		CC="gcc"
		CCOBJ="gcc"
		LD="ld"
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CC="$CC"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-O -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O -g -D_LARGEFILE64_SOURCE"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	s390x_linux24|s390x_linux26)
		CC="gcc"
		CCOBJ="gcc"
		LD="ld"
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CC="$CC"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-O -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O -g -D_LARGEFILE64_SOURCE -D__s390x__"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	sgi_62)
		PINSTALL_LIBS=-lmld
		AFSD_LIBS="/usr/lib/libdwarf.a /usr/lib/libelf.a"
		FSINCLUDES="-I/usr/include/sys/fs"
		LEX="lex"
		MT_CFLAGS='-D_SGI_MP_SOURCE -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread"
		TXLIBS="-lcurses"
		XCFLAGS64="-64 -mips3"
		XCFLAGS="-o32"
		XLDFLAGS64="-64"
		XLDFLAGS="-o32"
		SHLIB_LINKER="${CC} -shared"
		;;

	sgi_63)
		PINSTALL_LIBS=-lmld
		AFSD_LIBS="/usr/lib/libdwarf.a /usr/lib/libelf.a"
		FSINCLUDES="-I/usr/include/sys/fs"
		LEX="lex"
		MT_CFLAGS='-D_SGI_MP_SOURCE -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread"
		TXLIBS="-lcurses"
		XCFLAGS64="-D_BSD_COMPAT -64 -mips3"
		XCFLAGS="-D_OLD_TERMIOS -D_BSD_COMPAT -o32"
		XLDFLAGS64="-64"
		XLDFLAGS="-o32"
		SHLIB_LINKER="${CC} -shared"
		;;

	sgi_64)
		AFSD_LIBS="/usr/lib32/libdwarf.a /usr/lib32/libelf.a"
		FSINCLUDES="-I/usr/include/sys/fs"
		LEX="lex"
		MT_CFLAGS='-D_SGI_MP_SOURCE -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread"
		TXLIBS="-lcurses"
		XCFLAGS64="-D_BSD_COMPAT -64 -mips3"
		XCFLAGS="-D_OLD_TERMIOS -D_BSD_COMPAT -n32 -woff 1009,1110,1116,1164,1171,1177,1183,1185,1204,1233,1515,1516,1548,1169,1174,1177,1196,1498,1506,1552"
		XLDFLAGS64="-64"
		XLDFLAGS="-n32"
		SHLIB_LINKER="${CC} -shared"
		;;

	sgi_65)
		AFSD_LIBS="/usr/lib32/libdwarf.a /usr/lib32/libelf.a"
		CC="/usr/bin/cc"
		CCOBJ="/usr/bin/cc"
		FSINCLUDES="-I/usr/include/sys/fs"
		LD="/usr/bin/ld"
		LEX="lex"
		MT_CC="/usr/bin/cc"
		MT_CFLAGS='-D_SGI_MP_SOURCE -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread"
		TXLIBS="-lcurses"
		XCFLAGS64="-64 -mips3"
		XCFLAGS="-n32 -mips3 -woff 1009,1110,1116,1164,1171,1177,1183,1185,1204,1233,1515,1516,1548,1169,1174,1177,1196,1498,1506,1552"
		XLDFLAGS64="-64 -mips3"
		XLDFLAGS="-n32 -mips3"
		SHLIB_LINKER="${CC} -shared"
		;;

	sparc64_linux22)
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O2 -D_LARGEFILE64_SOURCE"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	sparc64_linux24)
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O2 -D_LARGEFILE64_SOURCE"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	sparc_linux22)
		KERN_OPTMZ=-O2
		LEX="flex -l"
		MT_CFLAGS='-DAFS_PTHREAD_ENV -pthread -D_REENTRANT ${XCFLAGS}'
		MT_LIBS="-lpthread"
		PAM_CFLAGS="-O2 -Dlinux -DLINUX_PAM -fPIC"
		SHLIB_LDFLAGS="-shared -Xlinker -x"
		TXLIBS="-lncurses"
		XCFLAGS="-O2 -D_LARGEFILE64_SOURCE"
		YACC="bison -y"
		SHLIB_LINKER="${MT_CC} -shared"
		;;

	sun4_413)
		CCXPG2="/usr/xpg2bin/cc"
		CC="gcc"
		CCOBJ="gcc"
		LEX="lex"
		SHLIB_CFLAGS="-PIC"
		TXLIBS="-lcurses -ltermcap"
		XCFLAGS=""
		XLIBELFA="-lelf"
		XLIBKVM="-lkvm"
		XLIBS="${LIB_AFSDB}"
		LD="ld"
		;;

	sun4x_55)
		CC="/opt/SUNWspro/bin/cc"
		CCOBJ="/opt/SUNWspro/bin/cc"
		LEX="lex"
		MT_CC="/opt/SUNWspro/bin/cc"
		MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread -lsocket"
		SHLIB_CFLAGS="-KPIC"
		TXLIBS="-lcurses"
		XCFLAGS="-dy -Bdynamic"
		XLIBELFA="-lelf"
		XLIBKVM="-lkvm"
		XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
		LD="/usr/ccs/bin/ld"
		SHLIB_LINKER="${CC} -G -dy -Wl,-M\$(srcdir)/mapfile -Bsymbolic -z text"
		;;

	sun4x_56)
		CC="/opt/SUNWspro/bin/cc"
		CCOBJ="/opt/SUNWspro/bin/cc"
		LEX="lex"
		MT_CC="/opt/SUNWspro/bin/cc"
		MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread -lsocket"
		PAM_CFLAGS="-KPIC"
		PAM_LIBS="-lc -lpam -lsocket -lnsl -lm"
		SHLIB_CFLAGS="-KPIC"
		SHLIB_LDFLAGS="-G -Bsymbolic"
		TXLIBS="-L/usr/ccs/lib -lcurses"
		XCFLAGS="-dy -Bdynamic"
		XLIBELFA="-lelf"
		LD="/usr/ccs/bin/ld"
		XLIBKVM="-lkvm"
		XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
		SHLIB_LINKER="${CC} -G -dy -Wl,-M\$(srcdir)/mapfile -Bsymbolic -z text"
		;;

	sun4x_57)
		CC="/opt/SUNWspro/bin/cc"
		CCOBJ="/opt/SUNWspro/bin/cc"
		LEX="lex"
		LD="/usr/ccs/bin/ld"
		MT_CC="/opt/SUNWspro/bin/cc"
		MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread -lsocket"
		PAM_CFLAGS="-KPIC"
		PAM_LIBS="-lc -lpam -lsocket -lnsl -lm"
		SHLIB_CFLAGS="-KPIC"
		SHLIB_LDFLAGS="-G -Bsymbolic"
		TXLIBS="-lcurses"
		XCFLAGS64='${XCFLAGS} -xarch=v9'
		XCFLAGS="-dy -Bdynamic"
		XLIBELFA="-lelf"
		XLIBKVM="-lkvm"
		XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
		SHLIB_LINKER="${CC} -G -dy -Wl,-M\$(srcdir)/mapfile -Bsymbolic -z text"
		;;

	sun4x_58)
		CC="/opt/SUNWspro/bin/cc"
		CCOBJ="/opt/SUNWspro/bin/cc"
		LEX="lex"
		LD="/usr/ccs/bin/ld"
		MT_CC="/opt/SUNWspro/bin/cc"
		MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread -lsocket"
		PAM_CFLAGS="-KPIC"
		PAM_LIBS="-lc -lpam -lsocket -lnsl -lm"
		SHLIB_CFLAGS="-KPIC"
		SHLIB_LDFLAGS="-G -Bsymbolic"
		TXLIBS="-lcurses"
		XCFLAGS64='${XCFLAGS} -xarch=v9'
		XCFLAGS="-dy -Bdynamic"
		XLIBELFA="-lelf"
		XLIBKVM="-lkvm"
		XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
		SHLIB_LINKER="${CC} -G -dy -Wl,-M\$(srcdir)/mapfile -Bsymbolic -z text"
		;;

	sun4x_59)
		CC="/opt/SUNWspro/bin/cc"
		CCOBJ="/opt/SUNWspro/bin/cc"
		LEX="lex"
		LD="/usr/ccs/bin/ld"
		MT_CC="/opt/SUNWspro/bin/cc"
		MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread -lsocket"
		PAM_CFLAGS="-KPIC"
		PAM_LIBS="-lc -lpam -lsocket -lnsl -lm"
		SHLIB_CFLAGS="-KPIC"
		SHLIB_LDFLAGS="-G -Bsymbolic"
		TXLIBS="-lcurses"
		XCFLAGS64='${XCFLAGS} -xarch=v9'
		XCFLAGS="-dy -Bdynamic"
		XLIBELFA="-lelf"
		XLIBKVM="-lkvm"
		XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
		SHLIB_LINKER="${CC} -G -dy -Wl,-M\$(srcdir)/mapfile -Bsymbolic -z text"
		;;

	sun4x_510)
		CC="/opt/SUNWspro/bin/cc"
		CCOBJ="/opt/SUNWspro/bin/cc"
		LEX="lex"
		LD="/usr/ccs/bin/ld"
		MT_CC="/opt/SUNWspro/bin/cc"
		MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread -lsocket"
		PAM_CFLAGS="-KPIC"
		PAM_LIBS="-lc -lpam -lsocket -lnsl -lm"
		SHLIB_CFLAGS="-KPIC"
		SHLIB_LDFLAGS="-G -Bsymbolic"
		TXLIBS="-lcurses"
		XCFLAGS64='${XCFLAGS} -xarch=v9'
		XCFLAGS="-dy -Bdynamic"
		XLIBELFA="-lelf"
		XLIBKVM="-lkvm"
		XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
		SHLIB_LINKER="${CC} -G -dy -Wl,-M\$(srcdir)/mapfile -Bsymbolic -z text"
		;;

	sunx86_57)
		CC="/opt/SUNWspro/bin/cc"
		CCOBJ="/opt/SUNWspro/bin/cc"
		LEX="lex"
		LD="/usr/ccs/bin/ld"
		MT_CC="/opt/SUNWspro/bin/cc"
		MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread -lsocket"
		PAM_CFLAGS="-KPIC"
		PAM_LIBS="-lc -lpam -lsocket -lnsl -lm"
		SHLIB_CFLAGS="-KPIC"
		SHLIB_LDFLAGS="-G -Bsymbolic"
		TXLIBS="-lcurses"
		XCFLAGS64='${XCFLAGS} -xarch=amd64'
		XCFLAGS="-dy -Bdynamic"
		XLIBELFA="-lelf"
		XLIBKVM="-lkvm"
		XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
		SHLIB_LINKER="${CC} -G -dy -Wl,-M\$(srcdir)/mapfile -Bsymbolic -z text"
		;;

	sunx86_58)
		CC="/opt/SUNWspro/bin/cc"
		CCOBJ="/opt/SUNWspro/bin/cc"
		LEX="lex"
		LD="/usr/ccs/bin/ld"
		MT_CC="/opt/SUNWspro/bin/cc"
		MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread -lsocket"
		PAM_CFLAGS="-KPIC"
		PAM_LIBS="-lc -lpam -lsocket -lnsl -lm"
		SHLIB_CFLAGS="-KPIC"
		SHLIB_LDFLAGS="-G -Bsymbolic"
		TXLIBS="-lcurses"
		XCFLAGS64='${XCFLAGS} -xarch=amd64'
		XCFLAGS="-dy -Bdynamic"
		XLIBELFA="-lelf"
		XLIBKVM="-lkvm"
		XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
		SHLIB_LINKER="${CC} -G -dy -Wl,-M\$(srcdir)/mapfile -Bsymbolic -z text"
		;;

	sunx86_59)
		CC="/opt/SUNWspro/bin/cc"
		CCOBJ="/opt/SUNWspro/bin/cc"
		LEX="lex"
		LD="/usr/ccs/bin/ld"
		MT_CC="/opt/SUNWspro/bin/cc"
		MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread -lsocket"
		PAM_CFLAGS="-KPIC"
		PAM_LIBS="-lc -lpam -lsocket -lnsl -lm"
		SHLIB_CFLAGS="-KPIC"
		SHLIB_LDFLAGS="-G -Bsymbolic"
		TXLIBS="-lcurses"
		XCFLAGS64='${XCFLAGS} -xarch=amd64'
		XCFLAGS="-dy -Bdynamic"
		XLIBELFA="-lelf"
		XLIBKVM="-lkvm"
		XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
		SHLIB_LINKER="${CC} -G -dy -Wl,-M\$(srcdir)/mapfile -Bsymbolic -z text"
		;;

	sunx86_510)
		CC="/opt/SUNWspro/bin/cc"
		CCOBJ="/opt/SUNWspro/bin/cc"
		LEX="lex"
		LD="/usr/ccs/bin/ld"
		MT_CC="/opt/SUNWspro/bin/cc"
		MT_CFLAGS='-mt -DAFS_PTHREAD_ENV ${XCFLAGS}'
		MT_LIBS="-lpthread -lsocket"
		PAM_CFLAGS="-KPIC"
		PAM_LIBS="-lc -lpam -lsocket -lnsl -lm"
		SHLIB_CFLAGS="-KPIC"
		SHLIB_LDFLAGS="-G -Bsymbolic"
		TXLIBS="-lcurses"
		XCFLAGS64='${XCFLAGS} -xarch=amd64'
		XCFLAGS="-dy -Bdynamic"
		XLIBELFA="-lelf"
		XLIBKVM="-lkvm"
		XLIBS="${LIB_AFSDB} -lsocket -lnsl -lintl -ldl"
		SHLIB_LINKER="${CC} -G -dy -Wl,-M\$(srcdir)/mapfile -Bsymbolic -z text"
		;;
esac

#
# Special build targets
#
case $AFS_SYSNAME in
	sgi_6*)
		IRIX_SYS_SYSTM_H_HAS_MEM_FUNCS
		XFS_SIZE_CHECK="xfs_size_check"
		install_XFS_SIZE_CHECK='$(DESTDIR)${afssrvsbindir}/xfs_size_check'
		dest_XFS_SIZE_CHECK='$(DEST)/root.server/usr/afs/bin/xfs_size_check'
	
		AC_SUBST(XFS_SIZE_CHECK)
		AC_SUBST(install_XFS_SIZE_CHECK)
		AC_SUBST(dest_XFS_SIZE_CHECK)
	;;
	
	sun4x_*|sunx86_*)
		FS_CONV_SOL26="fs_conv_sol26"
		install_FS_CONV_SOL26='$(DESTDIR)${afssrvsbindir}/fs_conv_sol26'
		dest_FS_CONV_SOL26='$(DEST)/root.server/usr/afs/bin/fs_conv_sol26'

		AC_SUBST(FS_CONV_SOL26)
		AC_SUBST(install_FS_CONV_SOL26)
		AC_SUBST(dest_FS_CONV_SOL26)
	;;

	alpha_dux*)
		FS_CONV_OSF40D="fs_conv_dux40D"
		install_FS_CONV_OSF40D='$(DESTDIR)${afssrvsbindir}/fs_conv_dux40D'
		dest_FS_CONV_OSF40D='$(DEST)/root.server/usr/afs/bin/fs_conv_dux40D'

		AC_SUBST(FS_CONV_OSF40D)
		AC_SUBST(install_FS_CONV_OSF40D)
		AC_SUBST(dest_FS_CONV_OSF40D)
	;;
esac

dnl Disable the default for debugging/optimization if not enabled
if test "x$enable_debug_kernel" = "xno"; then
  KERN_DBG=
fi

if test "x$enable_optimize_kernel" = "xno"; then
  KERN_OPTMZ=
fi

if test "x$enable_debug" = "xno"; then
  DBG=
fi

if test "x$enable_optimize" = "xno"; then
  OPTMZ=
fi

if test "x$enable_debug_lwp" = "xno"; then
  LWP_DBG=
fi

if test "x$enable_optimize_lwp" = "xno"; then
  LWP_OPTMZ=
fi

AC_SUBST(CCXPG2)
AC_SUBST(CCOBJ)
AC_SUBST(AFSD_LIBS)
AC_SUBST(AFSD_LDFLAGS)
AC_SUBST(AIX64)
AC_SUBST(AR)
AC_SUBST(AS)
AC_SUBST(CP)
AC_SUBST(DBG)
AC_SUBST(FSINCLUDES)
AC_SUBST(KERN_DBG)
AC_SUBST(KERN_OPTMZ)
AC_SUBST(LD)
AC_SUBST(LEX)
AC_SUBST(LWP_DBG)
AC_SUBST(LWP_OPTMZ)
AC_SUBST(MT_CC)
AC_SUBST(MT_CFLAGS)
AC_SUBST(MT_LIBS)
AC_SUBST(MV)
AC_SUBST(OPTMZ)
AC_SUBST(PAM_CFLAGS)
AC_SUBST(PAM_LIBS)
AC_SUBST(PINSTALL_LIBS)
AC_SUBST(RANLIB)
AC_SUBST(REGEX_OBJ)
AC_SUBST(RM)
AC_SUBST(SHLIB_CFLAGS)
AC_SUBST(SHLIB_LDFLAGS)
AC_SUBST(SHLIB_LINKER)
AC_SUBST(SHLIB_SUFFIX)
AC_SUBST(TXLIBS)
AC_SUBST(VFSCK_CFLAGS)
AC_SUBST(XCFLAGS)
AC_SUBST(XCFLAGS64)
AC_SUBST(XLDFLAGS)
AC_SUBST(XLDFLAGS64)
AC_SUBST(XLIBELFA)
AC_SUBST(XLIBKVM)
AC_SUBST(XLIBS)
AC_SUBST(YACC)


])

AC_DEFUN([IRIX_SYS_SYSTM_H_HAS_MEM_FUNCS], [
AC_MSG_CHECKING(for mem* in sys/systm.h)
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="$CPPFLAGS -D_KERNEL -D__STRING_H__"
AC_CACHE_VAL(ac_cv_irix_sys_systm_h_has_mem_funcs,
[
AC_TRY_COMPILE(
[#include <sys/types.h>
#include <sys/systm.h>],
[
extern void     *memcpy(char *, const void *, size_t);
],
ac_cv_irix_sys_systm_h_has_mem_funcs=no,
ac_cv_irix_sys_systm_h_has_mem_funcs=yes)])
CPPFLAGS="$save_CPPFLAGS"
if test "$ac_cv_irix_sys_systm_h_has_mem_funcs" = "yes"; then
  AC_DEFINE(IRIX_HAS_MEM_FUNCS, 1, [define if irix has memcpy and friends])
fi
AC_MSG_RESULT($ac_cv_irix_sys_systm_h_has_mem_funcs)
])

# Do all the work for Automake.                            -*- Autoconf -*-

# This macro actually does too much some checks are only needed if
# your package does certain things.  But this isn't really a big deal.

# Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003
# Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

# serial 10

AC_PREREQ([2.54])

# Autoconf 2.50 wants to disallow AM_ names.  We explicitly allow
# the ones we care about.
m4_pattern_allow([^AM_[A-Z]+FLAGS$])dnl

# AM_INIT_AUTOMAKE(PACKAGE, VERSION, [NO-DEFINE])
# AM_INIT_AUTOMAKE([OPTIONS])
# -----------------------------------------------
# The call with PACKAGE and VERSION arguments is the old style
# call (pre autoconf-2.50), which is being phased out.  PACKAGE
# and VERSION should now be passed to AC_INIT and removed from
# the call to AM_INIT_AUTOMAKE.
# We support both call styles for the transition.  After
# the next Automake release, Autoconf can make the AC_INIT
# arguments mandatory, and then we can depend on a new Autoconf
# release and drop the old call support.
AC_DEFUN([AM_INIT_AUTOMAKE],
[AC_REQUIRE([AM_SET_CURRENT_AUTOMAKE_VERSION])dnl
 AC_REQUIRE([AC_PROG_INSTALL])dnl
# test to see if srcdir already configured
if test "`cd $srcdir && pwd`" != "`pwd`" &&
   test -f $srcdir/config.status; then
  AC_MSG_ERROR([source directory already configured; run "make distclean" there first])
fi

# test whether we have cygpath
if test -z "$CYGPATH_W"; then
  if (cygpath --version) >/dev/null 2>/dev/null; then
    CYGPATH_W='cygpath -w'
  else
    CYGPATH_W=echo
  fi
fi
AC_SUBST([CYGPATH_W])

# Define the identity of the package.
dnl Distinguish between old-style and new-style calls.
m4_ifval([$2],
[m4_ifval([$3], [_AM_SET_OPTION([no-define])])dnl
 AC_SUBST([PACKAGE], [$1])dnl
 AC_SUBST([VERSION], [$2])],
[_AM_SET_OPTIONS([$1])dnl
 AC_SUBST([PACKAGE], ['AC_PACKAGE_TARNAME'])dnl
 AC_SUBST([VERSION], ['AC_PACKAGE_VERSION'])])dnl

_AM_IF_OPTION([no-define],,
[AC_DEFINE_UNQUOTED(PACKAGE, "$PACKAGE", [Name of package])
 AC_DEFINE_UNQUOTED(VERSION, "$VERSION", [Version number of package])])dnl

# Some tools Automake needs.
AC_REQUIRE([AM_SANITY_CHECK])dnl
AC_REQUIRE([AC_ARG_PROGRAM])dnl
AM_MISSING_PROG(ACLOCAL, aclocal-${am__api_version})
AM_MISSING_PROG(AUTOCONF, autoconf)
AM_MISSING_PROG(AUTOMAKE, automake-${am__api_version})
AM_MISSING_PROG(AUTOHEADER, autoheader)
AM_MISSING_PROG(MAKEINFO, makeinfo)
AM_MISSING_PROG(AMTAR, tar)
AM_PROG_INSTALL_SH
AM_PROG_INSTALL_STRIP
# We need awk for the "check" target.  The system "awk" is bad on
# some platforms.
AC_REQUIRE([AC_PROG_AWK])dnl
AC_REQUIRE([AC_PROG_MAKE_SET])dnl
AC_REQUIRE([AM_SET_LEADING_DOT])dnl

_AM_IF_OPTION([no-dependencies],,
[AC_PROVIDE_IFELSE([AC_PROG_CC],
                  [_AM_DEPENDENCIES(CC)],
                  [define([AC_PROG_CC],
                          defn([AC_PROG_CC])[_AM_DEPENDENCIES(CC)])])dnl
AC_PROVIDE_IFELSE([AC_PROG_CXX],
                  [_AM_DEPENDENCIES(CXX)],
                  [define([AC_PROG_CXX],
                          defn([AC_PROG_CXX])[_AM_DEPENDENCIES(CXX)])])dnl
])
])


# When config.status generates a header, we must update the stamp-h file.
# This file resides in the same directory as the config header
# that is generated.  The stamp files are numbered to have different names.

# Autoconf calls _AC_AM_CONFIG_HEADER_HOOK (when defined) in the
# loop where config.status creates the headers, so we can generate
# our stamp files there.
AC_DEFUN([_AC_AM_CONFIG_HEADER_HOOK],
[# Compute $1's index in $config_headers.
_am_stamp_count=1
for _am_header in $config_headers :; do
  case $_am_header in
    $1 | $1:* )
      break ;;
    * )
      _am_stamp_count=`expr $_am_stamp_count + 1` ;;
  esac
done
echo "timestamp for $1" >`AS_DIRNAME([$1])`/stamp-h[]$_am_stamp_count])

# Copyright 2002  Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA

# AM_AUTOMAKE_VERSION(VERSION)
# ----------------------------
# Automake X.Y traces this macro to ensure aclocal.m4 has been
# generated from the m4 files accompanying Automake X.Y.
AC_DEFUN([AM_AUTOMAKE_VERSION],[am__api_version="1.7"])

# AM_SET_CURRENT_AUTOMAKE_VERSION
# -------------------------------
# Call AM_AUTOMAKE_VERSION so it can be traced.
# This function is AC_REQUIREd by AC_INIT_AUTOMAKE.
AC_DEFUN([AM_SET_CURRENT_AUTOMAKE_VERSION],
	 [AM_AUTOMAKE_VERSION([1.7.9])])

# Helper functions for option handling.                    -*- Autoconf -*-

# Copyright 2001, 2002  Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

# serial 2

# _AM_MANGLE_OPTION(NAME)
# -----------------------
AC_DEFUN([_AM_MANGLE_OPTION],
[[_AM_OPTION_]m4_bpatsubst($1, [[^a-zA-Z0-9_]], [_])])

# _AM_SET_OPTION(NAME)
# ------------------------------
# Set option NAME.  Presently that only means defining a flag for this option.
AC_DEFUN([_AM_SET_OPTION],
[m4_define(_AM_MANGLE_OPTION([$1]), 1)])

# _AM_SET_OPTIONS(OPTIONS)
# ----------------------------------
# OPTIONS is a space-separated list of Automake options.
AC_DEFUN([_AM_SET_OPTIONS],
[AC_FOREACH([_AM_Option], [$1], [_AM_SET_OPTION(_AM_Option)])])

# _AM_IF_OPTION(OPTION, IF-SET, [IF-NOT-SET])
# -------------------------------------------
# Execute IF-SET if OPTION is set, IF-NOT-SET otherwise.
AC_DEFUN([_AM_IF_OPTION],
[m4_ifset(_AM_MANGLE_OPTION([$1]), [$2], [$3])])

#
# Check to make sure that the build environment is sane.
#

# Copyright 1996, 1997, 2000, 2001 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

# serial 3

# AM_SANITY_CHECK
# ---------------
AC_DEFUN([AM_SANITY_CHECK],
[AC_MSG_CHECKING([whether build environment is sane])
# Just in case
sleep 1
echo timestamp > conftest.file
# Do `set' in a subshell so we don't clobber the current shell's
# arguments.  Must try -L first in case configure is actually a
# symlink; some systems play weird games with the mod time of symlinks
# (eg FreeBSD returns the mod time of the symlink's containing
# directory).
if (
   set X `ls -Lt $srcdir/configure conftest.file 2> /dev/null`
   if test "$[*]" = "X"; then
      # -L didn't work.
      set X `ls -t $srcdir/configure conftest.file`
   fi
   rm -f conftest.file
   if test "$[*]" != "X $srcdir/configure conftest.file" \
      && test "$[*]" != "X conftest.file $srcdir/configure"; then

      # If neither matched, then we have a broken ls.  This can happen
      # if, for instance, CONFIG_SHELL is bash and it inherits a
      # broken ls alias from the environment.  This has actually
      # happened.  Such a system could not be considered "sane".
      AC_MSG_ERROR([ls -t appears to fail.  Make sure there is not a broken
alias in your environment])
   fi

   test "$[2]" = conftest.file
   )
then
   # Ok.
   :
else
   AC_MSG_ERROR([newly created file is older than distributed files!
Check your system clock])
fi
AC_MSG_RESULT(yes)])

# AM_PROG_INSTALL_SH
# ------------------
# Define $install_sh.

# Copyright 2001 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

AC_DEFUN([AM_PROG_INSTALL_SH],
[AC_REQUIRE([AM_AUX_DIR_EXPAND])dnl
install_sh=${install_sh-"$am_aux_dir/install-sh"}
AC_SUBST(install_sh)])

# AM_PROG_INSTALL_STRIP

# Copyright 2001 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

# One issue with vendor `install' (even GNU) is that you can't
# specify the program used to strip binaries.  This is especially
# annoying in cross-compiling environments, where the build's strip
# is unlikely to handle the host's binaries.
# Fortunately install-sh will honor a STRIPPROG variable, so we
# always use install-sh in `make install-strip', and initialize
# STRIPPROG with the value of the STRIP variable (set by the user).
AC_DEFUN([AM_PROG_INSTALL_STRIP],
[AC_REQUIRE([AM_PROG_INSTALL_SH])dnl
# Installed binaries are usually stripped using `strip' when the user
# run `make install-strip'.  However `strip' might not be the right
# tool to use in cross-compilation environments, therefore Automake
# will honor the `STRIP' environment variable to overrule this program.
dnl Don't test for $cross_compiling = yes, because it might be `maybe'.
if test "$cross_compiling" != no; then
  AC_CHECK_TOOL([STRIP], [strip], :)
fi
INSTALL_STRIP_PROGRAM="\${SHELL} \$(install_sh) -c -s"
AC_SUBST([INSTALL_STRIP_PROGRAM])])

#                                                          -*- Autoconf -*-
# Copyright (C) 2003  Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

# serial 1

# Check whether the underlying file-system supports filenames
# with a leading dot.  For instance MS-DOS doesn't.
AC_DEFUN([AM_SET_LEADING_DOT],
[rm -rf .tst 2>/dev/null
mkdir .tst 2>/dev/null
if test -d .tst; then
  am__leading_dot=.
else
  am__leading_dot=_
fi
rmdir .tst 2>/dev/null
AC_SUBST([am__leading_dot])])

# serial 5						-*- Autoconf -*-

# Copyright (C) 1999, 2000, 2001, 2002, 2003  Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.


# There are a few dirty hacks below to avoid letting `AC_PROG_CC' be
# written in clear, in which case automake, when reading aclocal.m4,
# will think it sees a *use*, and therefore will trigger all it's
# C support machinery.  Also note that it means that autoscan, seeing
# CC etc. in the Makefile, will ask for an AC_PROG_CC use...



# _AM_DEPENDENCIES(NAME)
# ----------------------
# See how the compiler implements dependency checking.
# NAME is "CC", "CXX", "GCJ", or "OBJC".
# We try a few techniques and use that to set a single cache variable.
#
# We don't AC_REQUIRE the corresponding AC_PROG_CC since the latter was
# modified to invoke _AM_DEPENDENCIES(CC); we would have a circular
# dependency, and given that the user is not expected to run this macro,
# just rely on AC_PROG_CC.
AC_DEFUN([_AM_DEPENDENCIES],
[AC_REQUIRE([AM_SET_DEPDIR])dnl
AC_REQUIRE([AM_OUTPUT_DEPENDENCY_COMMANDS])dnl
AC_REQUIRE([AM_MAKE_INCLUDE])dnl
AC_REQUIRE([AM_DEP_TRACK])dnl

ifelse([$1], CC,   [depcc="$CC"   am_compiler_list=],
       [$1], CXX,  [depcc="$CXX"  am_compiler_list=],
       [$1], OBJC, [depcc="$OBJC" am_compiler_list='gcc3 gcc'],
       [$1], GCJ,  [depcc="$GCJ"  am_compiler_list='gcc3 gcc'],
                   [depcc="$$1"   am_compiler_list=])

AC_CACHE_CHECK([dependency style of $depcc],
               [am_cv_$1_dependencies_compiler_type],
[if test -z "$AMDEP_TRUE" && test -f "$am_depcomp"; then
  # We make a subdir and do the tests there.  Otherwise we can end up
  # making bogus files that we don't know about and never remove.  For
  # instance it was reported that on HP-UX the gcc test will end up
  # making a dummy file named `D' -- because `-MD' means `put the output
  # in D'.
  mkdir conftest.dir
  # Copy depcomp to subdir because otherwise we won't find it if we're
  # using a relative directory.
  cp "$am_depcomp" conftest.dir
  cd conftest.dir
  # We will build objects and dependencies in a subdirectory because
  # it helps to detect inapplicable dependency modes.  For instance
  # both Tru64's cc and ICC support -MD to output dependencies as a
  # side effect of compilation, but ICC will put the dependencies in
  # the current directory while Tru64 will put them in the object
  # directory.
  mkdir sub

  am_cv_$1_dependencies_compiler_type=none
  if test "$am_compiler_list" = ""; then
     am_compiler_list=`sed -n ['s/^#*\([a-zA-Z0-9]*\))$/\1/p'] < ./depcomp`
  fi
  for depmode in $am_compiler_list; do
    # Setup a source with many dependencies, because some compilers
    # like to wrap large dependency lists on column 80 (with \), and
    # we should not choose a depcomp mode which is confused by this.
    #
    # We need to recreate these files for each test, as the compiler may
    # overwrite some of them when testing with obscure command lines.
    # This happens at least with the AIX C compiler.
    : > sub/conftest.c
    for i in 1 2 3 4 5 6; do
      echo '#include "conftst'$i'.h"' >> sub/conftest.c
      : > sub/conftst$i.h
    done
    echo "${am__include} ${am__quote}sub/conftest.Po${am__quote}" > confmf

    case $depmode in
    nosideeffect)
      # after this tag, mechanisms are not by side-effect, so they'll
      # only be used when explicitly requested
      if test "x$enable_dependency_tracking" = xyes; then
	continue
      else
	break
      fi
      ;;
    none) break ;;
    esac
    # We check with `-c' and `-o' for the sake of the "dashmstdout"
    # mode.  It turns out that the SunPro C++ compiler does not properly
    # handle `-M -o', and we need to detect this.
    if depmode=$depmode \
       source=sub/conftest.c object=sub/conftest.${OBJEXT-o} \
       depfile=sub/conftest.Po tmpdepfile=sub/conftest.TPo \
       $SHELL ./depcomp $depcc -c -o sub/conftest.${OBJEXT-o} sub/conftest.c \
         >/dev/null 2>conftest.err &&
       grep sub/conftst6.h sub/conftest.Po > /dev/null 2>&1 &&
       grep sub/conftest.${OBJEXT-o} sub/conftest.Po > /dev/null 2>&1 &&
       ${MAKE-make} -s -f confmf > /dev/null 2>&1; then
      # icc doesn't choke on unknown options, it will just issue warnings
      # (even with -Werror).  So we grep stderr for any message
      # that says an option was ignored.
      if grep 'ignoring option' conftest.err >/dev/null 2>&1; then :; else
        am_cv_$1_dependencies_compiler_type=$depmode
        break
      fi
    fi
  done

  cd ..
  rm -rf conftest.dir
else
  am_cv_$1_dependencies_compiler_type=none
fi
])
AC_SUBST([$1DEPMODE], [depmode=$am_cv_$1_dependencies_compiler_type])
AM_CONDITIONAL([am__fastdep$1], [
  test "x$enable_dependency_tracking" != xno \
  && test "$am_cv_$1_dependencies_compiler_type" = gcc3])
])


# AM_SET_DEPDIR
# -------------
# Choose a directory name for dependency files.
# This macro is AC_REQUIREd in _AM_DEPENDENCIES
AC_DEFUN([AM_SET_DEPDIR],
[AC_REQUIRE([AM_SET_LEADING_DOT])dnl
AC_SUBST([DEPDIR], ["${am__leading_dot}deps"])dnl
])


# AM_DEP_TRACK
# ------------
AC_DEFUN([AM_DEP_TRACK],
[AC_ARG_ENABLE(dependency-tracking,
[  --disable-dependency-tracking Speeds up one-time builds
  --enable-dependency-tracking  Do not reject slow dependency extractors])
if test "x$enable_dependency_tracking" != xno; then
  am_depcomp="$ac_aux_dir/depcomp"
  AMDEPBACKSLASH='\'
fi
AM_CONDITIONAL([AMDEP], [test "x$enable_dependency_tracking" != xno])
AC_SUBST([AMDEPBACKSLASH])
])

# Generate code to set up dependency tracking.   -*- Autoconf -*-

# Copyright 1999, 2000, 2001, 2002 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

#serial 2

# _AM_OUTPUT_DEPENDENCY_COMMANDS
# ------------------------------
AC_DEFUN([_AM_OUTPUT_DEPENDENCY_COMMANDS],
[for mf in $CONFIG_FILES; do
  # Strip MF so we end up with the name of the file.
  mf=`echo "$mf" | sed -e 's/:.*$//'`
  # Check whether this is an Automake generated Makefile or not.
  # We used to match only the files named `Makefile.in', but
  # some people rename them; so instead we look at the file content.
  # Grep'ing the first line is not enough: some people post-process
  # each Makefile.in and add a new line on top of each file to say so.
  # So let's grep whole file.
  if grep '^#.*generated by automake' $mf > /dev/null 2>&1; then
    dirpart=`AS_DIRNAME("$mf")`
  else
    continue
  fi
  grep '^DEP_FILES *= *[[^ @%:@]]' < "$mf" > /dev/null || continue
  # Extract the definition of DEP_FILES from the Makefile without
  # running `make'.
  DEPDIR=`sed -n -e '/^DEPDIR = / s///p' < "$mf"`
  test -z "$DEPDIR" && continue
  # When using ansi2knr, U may be empty or an underscore; expand it
  U=`sed -n -e '/^U = / s///p' < "$mf"`
  test -d "$dirpart/$DEPDIR" || mkdir "$dirpart/$DEPDIR"
  # We invoke sed twice because it is the simplest approach to
  # changing $(DEPDIR) to its actual value in the expansion.
  for file in `sed -n -e '
    /^DEP_FILES = .*\\\\$/ {
      s/^DEP_FILES = //
      :loop
	s/\\\\$//
	p
	n
	/\\\\$/ b loop
      p
    }
    /^DEP_FILES = / s/^DEP_FILES = //p' < "$mf" | \
       sed -e 's/\$(DEPDIR)/'"$DEPDIR"'/g' -e 's/\$U/'"$U"'/g'`; do
    # Make sure the directory exists.
    test -f "$dirpart/$file" && continue
    fdir=`AS_DIRNAME(["$file"])`
    AS_MKDIR_P([$dirpart/$fdir])
    # echo "creating $dirpart/$file"
    echo '# dummy' > "$dirpart/$file"
  done
done
])# _AM_OUTPUT_DEPENDENCY_COMMANDS


# AM_OUTPUT_DEPENDENCY_COMMANDS
# -----------------------------
# This macro should only be invoked once -- use via AC_REQUIRE.
#
# This code is only required when automatic dependency tracking
# is enabled.  FIXME.  This creates each `.P' file that we will
# need in order to bootstrap the dependency handling code.
AC_DEFUN([AM_OUTPUT_DEPENDENCY_COMMANDS],
[AC_CONFIG_COMMANDS([depfiles],
     [test x"$AMDEP_TRUE" != x"" || _AM_OUTPUT_DEPENDENCY_COMMANDS],
     [AMDEP_TRUE="$AMDEP_TRUE" ac_aux_dir="$ac_aux_dir"])
])

# Check to see how 'make' treats includes.	-*- Autoconf -*-

# Copyright (C) 2001, 2002, 2003 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

# serial 2

# AM_MAKE_INCLUDE()
# -----------------
# Check to see how make treats includes.
AC_DEFUN([AM_MAKE_INCLUDE],
[am_make=${MAKE-make}
cat > confinc << 'END'
am__doit:
	@echo done
.PHONY: am__doit
END
# If we don't find an include directive, just comment out the code.
AC_MSG_CHECKING([for style of include used by $am_make])
am__include="#"
am__quote=
_am_result=none
# First try GNU make style include.
echo "include confinc" > confmf
# We grep out `Entering directory' and `Leaving directory'
# messages which can occur if `w' ends up in MAKEFLAGS.
# In particular we don't look at `^make:' because GNU make might
# be invoked under some other name (usually "gmake"), in which
# case it prints its new name instead of `make'.
if test "`$am_make -s -f confmf 2> /dev/null | grep -v 'ing directory'`" = "done"; then
   am__include=include
   am__quote=
   _am_result=GNU
fi
# Now try BSD make style include.
if test "$am__include" = "#"; then
   echo '.include "confinc"' > confmf
   if test "`$am_make -s -f confmf 2> /dev/null`" = "done"; then
      am__include=.include
      am__quote="\""
      _am_result=BSD
   fi
fi
AC_SUBST([am__include])
AC_SUBST([am__quote])
AC_MSG_RESULT([$_am_result])
rm -f confinc confmf
])

# AM_CONDITIONAL                                              -*- Autoconf -*-

# Copyright 1997, 2000, 2001 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

# serial 5

AC_PREREQ(2.52)

# AM_CONDITIONAL(NAME, SHELL-CONDITION)
# -------------------------------------
# Define a conditional.
AC_DEFUN([AM_CONDITIONAL],
[ifelse([$1], [TRUE],  [AC_FATAL([$0: invalid condition: $1])],
        [$1], [FALSE], [AC_FATAL([$0: invalid condition: $1])])dnl
AC_SUBST([$1_TRUE])
AC_SUBST([$1_FALSE])
if $2; then
  $1_TRUE=
  $1_FALSE='#'
else
  $1_TRUE='#'
  $1_FALSE=
fi
AC_CONFIG_COMMANDS_PRE(
[if test -z "${$1_TRUE}" && test -z "${$1_FALSE}"; then
  AC_MSG_ERROR([conditional "$1" was never defined.
Usually this means the macro was only invoked conditionally.])
fi])])

