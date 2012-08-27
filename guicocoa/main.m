
#import "main.h"

GUI guicocoa =
{
    "cocoa",
    "Cocoa interface for OS X",
    ElvFalse,    /* exonly */
    ElvFalse,    /* newblank */
    ElvTrue,     /* minimizeclr */
    ElvFalse,    /* scrolllast */
    ElvFalse,    /* shiftrows */
    1,           /* movecost */
    0,           /* nopts */
    NULL,        /* optdescs */
    nstest,
    nsinit,
    nsusage,
    nsloop,
    nspoll,
    nsterm,
    nscreategw,
    nsdestroygw,
    nsfocusgw,
    nsretitle,
    nsreset,
    nsflush,
    nsmoveto,
    nsdraw,
    nsshift,
    nsscroll,
    nsclrtoeol,
    nstextline,
    nsbeep,
    nsmsg,
    nsscrollbar,
    nsstatus,
    nskeylabel,
    nsclipopen,
    nsclipwrite,
    nsclipread,
    nsclipclose,
    nscolor,
    nsfreecolor,
    nssetbg,
    nsguicmd,
    nstabcmd,
    nssave,
    nswildcard,
    nsprgopen,
    nsprgclose,
    nsstop,
};

// callback functions

/* Test whether this GUI is available in this environment.
 * Returns 0 if the GUI is unavailable, or 1 if available.
 * This should not have any visible side-effects.  If the
 * GUI can't be tested without side-effects, then this
 * function should return 2 to indicate "maybe available".
 */
static int nstest (void)
{
    NSLog (@"nstest");
    return 1;
}

/* Start the GUI.
 *
 * argc and argv are the command line arguments.  The GUI
 * may scan the arguments for GUI-specific options; if it
 * finds any, then they should be deleted from the argv list.
 * The resulting value of argc should be returned normally.
 * If the GUI couldn't initialize itself, it should emit an
 * error message and return -1.
 *
 * Other than "name" and "test", no other fields of the GUI
 * structure are accessed before this function has been called.
 */
static int nsinit (int argc, char** argv)
{
    NSLog (@"nsinit:");

    // TODO parse the arguments
    for (int i = 0; i < argc; ++i)
    {
        NSLog (@"- %s", argv[i]);
    }

    return argc;
}

/* output gui-dependent options */
static void nsusage (void)
{
    NSLog (@"nsusage");
    // none yet
}

/* In a loop, receive events from the GUI and call elvis
 * functions which will act on the event.  When this function
 * returns, elvis will call the GUI's term() function and then exit.
 * (This function should return only when the number of windows becomes 0.)
 */
static void nsloop (void)
{
    NSLog (@"nsloop");
    NSApplicationMain (0, nil);
}

/* TODO figure out what this function is supposed to do */
static ELVBOOL nspoll (ELVBOOL reset)
{
    NSLog (@"nspoll %i", reset);

    // the x11 and win32 GUIs do this
    if (reset == ElvTrue)
    {
        return ElvFalse;
    }

    // don't know any other reasons to change our mind
    return ElvFalse;
}

/* End the GUI.
 *
 * This function is called after all windows have been deleted
 * by delwin(), when elvis is about to terminate.
 */
static void nsterm (void)
{
    NSLog (@"nsterm");
    // TODO i never get called after nsapplicationmain
}

/* Create a new window for the buffer named name.  If successful,
 * return TRUE and then simulate a "create" event later.  Return
 * FALSE if the GUIWIN can't be created, e.g., because the GUI doesn't
 * support multiple windows.  The msg() function should be called to
 * describe the reason for the failure.
 */
static ELVBOOL nscreategw (char* name, char* attributes)
{
    NSLog (@"nscreategw:");
    NSLog (@"- %s", name);
    NSLog (@"- %s", attributes);
    // TODO make multiple windows work
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    NSString* filePath = [NSString stringWithCString: name encoding: NSUTF8StringEncoding];

    if ([[NSFileManager defaultManager] isReadableFileAtPath: filePath])
    {
        NSLog (@"imma open file %@", filePath);
        [[NSWorkspace sharedWorkspace] openFile: filePath withApplication: @"Elvis"];
    }

    [pool release];
    return ElvTrue;
}

/* TODO figure out what this event does
 * presumably we destroy the window "gw"
 */
static void nsdestroygw (GUIWIN* gw, ELVBOOL force)
{
    NSLog (@"nsdestroygw");
    // TODO make multiple windows work
}

/* TODO figure out what this event does
 * presumably we focus on the window "gw"
 */
static ELVBOOL nsfocusgw (GUIWIN* gw)
{
    NSLog (@"nsfocusgw");
    // TODO make multiple windows work
    return ElvFalse;
}

/* Change the title of the window.  This function is called when a
 * buffer's name changes, or different buffer becomes associated with
 * a window.  The name argument is the new buffer name.
 */
static void nsretitle (GUIWIN* gw, char* name)
{
    NSLog (@"nsretitle");
    // TODO make window titling work
}

/* TODO figure out what this event does
 * the windows and x11 GUIs do nothing, we will probably follow
 */
static void nsreset (void)
{
    NSLog (@"nsreset");
}

/* Flush all changes out to the screen */
static void nsflush (void)
{
    NSLog (@"nsflush");
    // TODO do something here
}

/* Move the cursor to a given character cell.  The upper left
 * character cell is designated column 0, row 0.
 */
static void nsmoveto (GUIWIN* gw, int column, int row)
{
    NSLog (@"nsmoveto");
    // TODO do something here
}

/* Displays text on the screen, starting at the cursor's
 * current position, in the given font.  The text string is
 * guaranteed to contain only printable characters.
 *
 * This function should move the text cursor to the end of
 * the output text.
 */
static void nsdraw (GUIWIN* gw, long fg, long bg, int bits, CHAR* text, int len)
{
    NSLog (@"nsdraw");
    // TODO do something here
}

/* Insert "qty" characters into the current row, starting at
 * the current cursor position.  A negative "qty" value means
 * that characters should be deleted.
 *
 * This function is optional.  If omitted, elvis will rewrite
 * the text that would have been shifted.
 */
static ELVBOOL nsshift (GUIWIN* gw, int qty, int rows)
{
    NSLog (@"nsshift");
    // TODO do something here
    return ElvFalse;
}

/* GUIWIN   *gw;        window to be scrolled
 * int      qty;        amount to scroll by (pos=downward, neg=upward)
 * ELVBOOL  notlast;    if ElvTrue, last row should not be affected
 */
static ELVBOOL nsscroll (GUIWIN* gw, int qty, ELVBOOL notlast)
{
    NSLog (@"nsscroll");
    // TODO do something here
    return ElvFalse;
}

/* GUIWIN   *gw;    window whose row is to be cleared */
static ELVBOOL nsclrtoeol (GUIWIN* gw)
{
    NSLog (@"nsclrtoeol");
    // TODO do something here
    return ElvFalse;
}

/* TODO figure out what this function is supposed to do
 * the x11 and win32 GUIs don't do anything were, we will
 * probably follow suit
 */
static void nstextline (GUIWIN* gw, CHAR* text, int len)
{
    NSLog (@"nstextline");
    // TODO do something here
}

/* Ring the bell */
static void nsbeep (GUIWIN* gw)
{
    NSLog (@"nsbeep");
    // TODO do something here
}

/* TODO figure out what this function is supposed to do
 * the x11 and win32 GUIs don't do anything were, we will
 * probably follow suit
 */
static ELVBOOL nsmsg (GUIWIN* gw, MSGIMP imp, CHAR* text, int len)
{
    NSLog (@"nsmsg");
    // TODO do something here
    return ElvFalse;
}

/* draw the scrollbar
    GUIWIN  *gw;    /* window whose scrollbar should be updated
    long    top;    /* offset of char at top of screen
    long    bottom; /* offset of char at bottom of screen
    long    total;  /* total number of characters in buffer
 */
static void nsscrollbar (GUIWIN* gw, long top, long bottom, long nlines)
{
    NSLog (@"nsscrollbar");
    // TODO do something here
}

/* adjust the statusbar
    GUIWIN  *gw;    /* window whose status bar should be updated
    CHAR    *cmd;   /* partial command keys
    long    line;   /* line number
    long    column; /* column number
    _CHAR_  learn;  /* learn letter, or '*' if modified, or ' ' otherwise
    char    *mode;  /* mode name, e.g. "Command" or "Input"
 */
static ELVBOOL nsstatus (GUIWIN* gw, CHAR* cmd, long line, long column, _CHAR_ learn, char* mode)
{
    NSLog (@"nsstatus");
    // TODO do something here
    return ElvFalse;
}

/* Translate keylabels into raw codes, or vice versa.  Returns length of raw
 * codes if successful, or 0 if unrecognized text.
    CHAR *given;    /* the string typed in by user
    int givenlen;   /* length of the user's string
    CHAR **label;   /* pointer to (CHAR *) to set to key label
    CHAR **rawin;   /* pointer to (CHAR *) to set to raw codes
 */
static int nskeylabel (CHAR* given, int givenlen, CHAR** label, CHAR** raw)
{
    NSLog (@"nskeylabel");
    // TODO do something here
    return 0;
}

/** clipopen  --  open the clipboard.
 * TODO figure out what this function is supposed to do
 */
static ELVBOOL nsclipopen (ELVBOOL forwrite)
{
    NSLog (@"nsclipopen");
    // TODO do something here
    return ElvFalse;
}

/** clipwrite  --  write to the clipboard.
 * TODO figure out what this function is supposed to do
 */
static int nsclipwrite (CHAR* text, int len)
{
    NSLog (@"nsclipwrite");
    // TODO do something here
    return 0;
}

/** clipread  --  read from the clipboard.
 * TODO figure out what this function is supposed to do
 */
static int nsclipread (CHAR* text, int len)
{
    NSLog (@"nsclipread");
    // TODO do something here
    return 0;
}

/** clipclose  --  close the clipboard.
 * TODO figure out what this function is supposed to do
 */
static void nsclipclose (void)
{
    NSLog (@"nsclipclose");
    // TODO do something here
}

/* parse a color name, and convert it to both a color code, and RGB values
    int fontcode;   /* font code
    CHAR    *colornam;  /* name of the color
    ELVBOOL isfg;       /* ElvTrue for foreground, ElvFalse for background
    long    *colorptr;  /* where to store the color number
    unsigned char rgb[3];   /* the color's RGB components
 */
static ELVBOOL nscolor (int fontcode, CHAR* colornam, ELVBOOL isfg, long* colorptr, unsigned char rgb[3])
{
    NSLog (@"nscolor");
    // TODO do something here
    return ElvFalse;
}

/* TODO figure out what this function is supposed to do
    long    color;  /* color code to be freed
    ELVBOOL isfg;   /* Is this color a foreground color?
 */
static void nsfreecolor (long color, ELVBOOL isfg)
{
    NSLog (@"nsfreecolor");
    // TODO do something here
}

/*
    GUIWIN  *gw;    /* GUI window whose background color should change
    long    bg;     /* the new background color
 */
static void nssetbg (GUIWIN* gw, long bg)
{
    NSLog (@"nssetbg");
    // TODO do something here
}

/* TODO figure out what this function is supposed to do
   in x11 its to maintain the list of toolbar buttons
   in win32 it does nothing
 */
static ELVBOOL nsguicmd (GUIWIN* gw, char* extra)
{
    NSLog (@"nsguicmd");
    // TODO do something here
    return ElvFalse;
}

/* TODO figure out what this function is supposed to do
 * the x11 and win32 GUIs don't do anything were, we will
 * probably follow suit
 */
static ELVBOOL nstabcmd (GUIWIN* gw, _CHAR_ key2, long count)
{
    NSLog (@"nstabcmd");
    // TODO do something here
    return ElvFalse;
}

/* TODO figure out what this function is supposed to do
 * the x11 and win32 GUIs don't do anything were, we will
 * probably follow suit
 */
static void nssave (BUFFER buf, GUIWIN* gw)
{
    NSLog (@"nssave");
    // TODO do something here
}

/* TODO figure out what this function is supposed to do
 * the x11 and win32 GUIs don't do anything were, we will
 * probably follow suit
 */
static int nswildcard (char* names, char* buf, int bufsize, ELVBOOL single)
{
    NSLog (@"nswildcard");
    // TODO do something here
    return 0;
}

/* TODO figure out what this function is supposed to do
 * the x11 and win32 GUIs don't do anything were, we will
 * probably follow suit
 */
static ELVBOOL nsprgopen (char* command, ELVBOOL willwrite, ELVBOOL willread)
{
    NSLog (@"nsprgopen");
    // TODO do something here
    return ElvFalse;
}

/* TODO figure out what this function is supposed to do
 * the x11 and win32 GUIs don't do anything here, we will
 * probably follow suit
 */
static int nsprgclose (void)
{
    NSLog (@"nsprgclose");
    // TODO do something here
    return 0;
}

/* This function starts an interactive shell.  It is called with the argument
 * (ElvTrue) for the :sh command, or (ElvFalse) for a :stop or :suspend command.
 * If successful it returns RESULT_COMPLETE after the shell exits; if
 * unsuccessful it issues an error message and returns RESULT_ERROR.  It
 * could also return RESULT_MORE to defer processing to the portable code
 * in ex_suspend().
 */
static RESULT nsstop (ELVBOOL alwaysfork)
{
    NSLog (@"nsstop");
    // TODO do something here
    return RESULT_ERROR;
}
