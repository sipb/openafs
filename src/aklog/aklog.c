/* 
 * $Id: aklog.c,v 1.1.2.6 2008/04/01 17:44:52 shadow Exp $
 *
 * Copyright 1990,1991 by the Massachusetts Institute of Technology
 * For distribution and copying rights, see the file "mit-copyright.h"
 */

#if !defined(lint) && !defined(SABER)
static char *rcsid = "$Id: aklog.c,v 1.1.2.6 2008/04/01 17:44:52 shadow Exp $";
#endif /* lint || SABER */

#include <afs/stds.h>
#include "aklog.h"

int
main(int argc, char *argv[])
{
    aklog(argc, argv);
    exit(0);
}

