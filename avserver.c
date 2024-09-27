#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <aes.h>
#include <tos.h>
#include "vaproto.h"
#include "avserver.h"

#define DATE     "Jan 29 1999"
#define VERSION  "1.3"

#ifndef _WORD
#ifdef __PUREC__
#define _WORD int
#define _UWORD int
#else
#define _WORD short
#define _UWORD short
#endif
#endif
#ifndef SH_WDRAW
#define SH_WDRAW        72          /* AES 4.0 */
#endif

#ifndef FALSE
#define FALSE 0
#define TRUE  1
#endif
#ifndef SuperToUser
#define SuperToUser(sp) Super(sp)
#endif

#define C_AmAN 0x416D414EL     /* 'AmAN' */
#define C_AVSV 0x41565356L     /* 'AVSV' */
#define _longframe *((short *)0x59e)

#define DATE     "Jan 29 1999"
#define VERSION  "1.3"

char const sccs_id[] = "@(#)AV-Server " VERSION " (" DATE "), Copyright (c)1996-98 by A. Barton";
char const progname[] = "AVSERVER";
/* WTF. Use Keytbl() instead */
char const keyboard_table[] = "\0\x17!\"\xdd$%&/()=?`^\x08\x09QWERTZUIOP\x94-\x0d\0ASDFGHJKL\x99\x8e\0\0|YXCVBNM;:_\0\0\0 ";


#define MAX_CLIENTS   32
#define MAX_WINDS     32
#define MAX_PROGS     4

extern short sp_offset;
extern long install_aes_trap(void);

#define MAX_APPNAME 8

struct client {
	short apid;
	short capabilities;
	char name[MAX_APPNAME + 1];
};

struct window {
	short winid;
	short apid;
};

struct program {
	short apid;
	short msg_extra;
	char name[MAX_APPNAME + 1];
};

struct avserver_info {
	short maxclients;
	short maxwindows;
	short maxprograms;
	struct client *clients;
	struct window *windows;
	struct program *programs;
};

_WORD gl_apid;
_WORD magxdesk;
_WORD x15068;
_WORD av_protokoll3;
_WORD av_protokoll4;
char space1[114];
char startprog_path[1024];
char startprog_name[1024];
void *x158e0;
struct client clients[MAX_CLIENTS];
struct window windows[MAX_WINDS];
struct program programs[MAX_PROGS];
struct avserver_info avserver_info;

static void etv_term(void);
static void x11486(void);
void x11f4e(char *names);
int x11a12(_WORD mox, _WORD moy, _WORD *owner);


int dd_reply(int fd, _WORD msg4, _WORD msg5, _WORD msg3, _WORD id);

void error_dragdrop(void);
void error_internal(void);
void error_overflow(void);
void error_copy(void);

int xbra_unlink(int vec);

void cycle_windows(void);


static void av_protokoll(_WORD *message);
static void av_exit(_WORD *message);
static void av_path_update(_WORD *message);
static void av_drag_on_window(_WORD *message);
void av_what_izit(_WORD *message);
static void av_accwindopen(_WORD *message);
static void av_accwindclosed(_WORD *message);
static void av_startprog(_WORD *message);
static void va_progstart(_WORD *message);
static void av_sendkey(_WORD *message);
void av_xwind(_WORD *message);
void av_openwind(_WORD *message);
void av_view(_WORD *message);
void av_status(_WORD *message);
void av_getstatus(_WORD *message);
void av_copyfile(_WORD *message);
void av_delfile(_WORD *message);
static void va_start_(void);

#define AV_SERVER_INFO 0x4798
#define VA_SERVER_INFO 0x4799
static void av_server_info(_WORD *message);

#define FONT_SELECT   0x7a19
void font_select(_WORD *message);


#define MGCOPY_NAME "MGCOPY.APP"
#define MGCOPY_PATH "C:\\GEMSYS\\GEMDESK\\MGCOPY.APP"


int main(void)
{
	char *server_name;
	int i;
	int done;
	long old_sp;
	_WORD message[8];
	char filename[32];

	server_name = getenv("AVSERVER");
	if (server_name == NULL)
		return 0;
	if (strcmp(server_name, "AVSERVER") != 0)
	{
		if (_app)
			return 0;
		/* not quite right: no appl_init() done yet */
		for (;;)
			evnt_timer(0xff00, 0xff00); /* XXX 101f0 */
	}
	
	gl_apid = appl_init();
	if (gl_apid < 0)
		return -1;
	
	for (i = 0; i < MAX_CLIENTS; i++)
		clients[i].apid = -1;
	for (i = 0; i < MAX_WINDS; i++)
		windows[i].winid = -1;
	for (i = 0; i < MAX_PROGS; i++)
		programs[i].apid = -1;
	
	avserver_info.maxclients = MAX_CLIENTS;
	avserver_info.maxwindows = MAX_WINDS;
	avserver_info.maxprograms = MAX_PROGS;
	avserver_info.clients = clients;
	avserver_info.windows = windows;
	avserver_info.programs = programs;
	av_protokoll3 = VA_PROT_SENDKEY |
		VA_PROT_OPENWIND |
		VA_PROT_STARTPROG |
		VA_PROT_ACCWINDOPEN |
		VA_PROT_ACCWINDCLOSED |
		VA_PROT_PATH_UPDATE |
		VA_PROT_WHAT_IZIT |
		VA_PROT_EXIT |
		VA_PROT_XWIND;
	av_protokoll4 = VA_PROT_COPYFILE | VA_PROT_DELFILE | VA_PROT_VIEW;
	done = FALSE;
	x158e0 = NULL;
	old_sp = Super(0);
	sp_offset = _longframe ? 8 : 6;
	SuperToUser((void *)old_sp);
	Supexec(install_aes_trap);
	Setexc(0x102, etv_term);
	
	while (!done)
	{
		evnt_mesag(message);
		magxdesk = appl_find("MAGXDESK");

		if (message[0] == AP_TERM)
		{
			int any_active;
			
			any_active = -1;
			for (i = 0; i < MAX_CLIENTS; i++)
			{
				if (clients[i].apid != -1)
					any_active = 1;
			}
			for (i = 0; i < MAX_WINDS; i++)
			{
				if (windows[i].winid != -1)
					any_active = 1;
			}
			if (any_active == -1 ||
				message[5] == AP_TERM ||
				message[5] == AP_RESCHG ||
				form_alert(1, "[3][AV-Server: AV-Clients are|still active. Do you really|want to quit the AV-Server?][Cancel|Quit]") == 2)
				done = TRUE;
		}
		
		if (!done)
			x11486();
		
		if (message[0] == SH_WDRAW)
			appl_write(magxdesk, (int)sizeof(message), message);
		
		/*
		 * FIXME: AP_DRAGDROP should always go the window owner,
		 * not to the AV-Server
		 */
		if (message[0] == AP_DRAGDROP)
		{
			long fd;
			
			strcpy(filename, "U:\\PIPE\\DRAGDROP.AA");
			filename[18] = message[7] & 0xff; /* XXX */
			filename[17] = ((unsigned short)message[7] & 0xff00) >> 8;
			fd = Fopen(filename, FO_RW);
			if (fd >= 0)
			{
				if (dd_reply((int)fd, message[4], message[5], message[3], x15068) == 0)
					appl_write(x15068, (int)sizeof(message), message);
			} else
			{
				error_dragdrop();
			}
		}
		
		if (message[0] == AV_PROTOKOLL)
			av_protokoll(message);
		
		if (message[0] == AV_EXIT)
			av_exit(message);
		
		if (message[0] == AV_DRAG_ON_WINDOW)
			av_drag_on_window(message);
		
		if (message[0] == AV_PATH_UPDATE)
			av_path_update(message);
		
		if (message[0] == AV_WHAT_IZIT)
			av_what_izit(message);
		
		if (message[0] == AV_ACCWINDOPEN)
			av_accwindopen(message);
		
		if (message[0] == AV_ACCWINDCLOSED)
			av_accwindclosed(message);
		
		if (message[0] == AV_STARTPROG)
			av_startprog(message);
		
		if (message[0] == VA_PROGSTART)
			va_progstart(message);
		
		if (message[0] == AV_SENDKEY)
			av_sendkey(message);
		
		if (message[0] == AV_XWIND)
			av_xwind(message);
		
		if (message[0] == AV_OPENWIND)
			av_openwind(message);
		
		if (message[0] == AV_VIEW)
			av_view(message);
		
		if (message[0] == AV_STATUS)
			av_status(message);
		
		if (message[0] == AV_GETSTATUS)
			av_getstatus(message);

		if (message[0] == AV_COPYFILE)
			av_copyfile(message);
		
		if (message[0] == AV_DELFILE)
			av_delfile(message);
		
		if (message[0] == AV_SERVER_INFO)
			av_server_info(message);
		
		if (message[0] == FONT_SELECT)
			font_select(message);
		
		if (message[0] == VA_START)
			va_start_();
	}
	appl_exit();
	
	return 0;
}


static void va_start_(void)
{
	form_alert(1, "[3][AV-Server " VERSION " (" DATE ")|Copyright (c)1996-98 by Alex Barton,|all rights reserved. This program is|freeware. E-mail: <alex@barton.de>][ OK ]");
	/* FIXME: should reply with AV_STARTED */
}


static void etv_term(void)
{
	/* uninstall from AES trap */
	if (xbra_unlink(34) == FALSE)
		error_internal();
}


static void av_protokoll(_WORD *message)
{
	char name[MAX_APPNAME * 2];
	int slot;
	int i;
	_WORD apid;
	const char *clientname;
	const char **pp;
	
	pp = ((const char **)&message[6]);
	clientname = *pp;
	strncpy(name, clientname, MAX_APPNAME);
	name[MAX_APPNAME] = '\0';
	slot = -1;
	for (i = 0; i < MAX_CLIENTS; i++)
	{
		if (strcmp(name, clients[i].name) == 0)
			slot = i;
		if (slot != -1)
			break;
	}
	if (slot == -1)
	{
		for (i = 0; i < MAX_CLIENTS; i++)
			if (clients[i].apid == -1)
				slot = i;
	}
	if (slot != -1)
	{
		const char *p;
		
		clients[slot].apid = message[1];
		clients[slot].capabilities = message[3];
		strcpy(clients[slot].name, name);
		apid = message[1];
		message[0] = VA_PROTOSTATUS;
		message[1] = gl_apid;
		message[2] = 0;
		message[3] = av_protokoll3;
		message[4] = av_protokoll4;
		message[5] = 0;
		/* BUG: will crash with MP */
		p = progname;
		message[6] = (_WORD)((long)p >> 16);
		message[7] = (_WORD)((unsigned int)(unsigned long)p) & 0xffffu; /* XXX */
		appl_write(apid, 16, message);
	} else
	{
		error_overflow();
	}
	/* mark message as handled */
	message[0] = 0; /* FIXME: unnecessary */
}


static void av_exit(_WORD *message)
{
	int i;
	int slot;
	
	slot = -1;
	/*
	 * search for apid from protocol
	 */
	for (i = 0; i < MAX_CLIENTS; i++)
	{
		if (clients[i].apid == message[3])
			slot = i;
	}
	if (slot == -1)
	{
		/*
		 * search for apid of sender
		 */
		slot = -1;
		for (i = 0; i < MAX_CLIENTS; i++)
		{
			if (clients[i].apid == message[1])
				slot = i;
		}
	}
	if (slot != -1)
	{
		for (i = 0; i < MAX_WINDS; i++)
		{
			if (windows[i].apid == clients[slot].apid)
			{
				windows[i].winid = -1;
				windows[i].apid = -1;
			}
		}
		clients[slot].apid = -1;
		clients[slot].capabilities = 0;
	}
	/* mark message as handled */
	message[0] = 0; /* FIXME: unnecessary */
}


static void av_server_info(_WORD *message)
{
	const char *p;
	_WORD apid;
	
	p = (const char *)&avserver_info;
	apid = message[1];
	message[0] = VA_SERVER_INFO;
	message[1] = gl_apid;
	message[2] = 0;
	message[3] = 0;
	message[6] = 0;
	message[7] = 0;
	message[4] = (_WORD)((long)p >> 16);
	message[5] = (_WORD)((unsigned int)(unsigned long)p) & 0xffffu;
	appl_write(apid, 16, message);
	/* mark message as handled */
	message[0] = 0; /* FIXME: unnecessary */
}


static void av_accwindopen(_WORD *message)
{
	int slot;
	int i;
	
	slot = -1;
	for (i = 0; i < MAX_WINDS; i++)
		if (windows[i].winid == message[3])
			slot = 1;
	if (slot == -1)
	{
		slot = -1;
		for (i = 0; i < MAX_WINDS; i++)
		{
			if (windows[i].winid == -1)
				slot = i;
		}
		if (slot != -1)
		{
			windows[slot].apid = message[1];
			windows[slot].winid = message[3];
		} else
		{
			error_overflow();
		}
	}
	/* mark message as handled */
	message[0] = 0; /* FIXME: unnecessary */
}


static void av_accwindclosed(_WORD *message)
{
	int i;
	
	for (i = 0; i < MAX_WINDS; i++)
	{
		if (windows[i].winid == message[3])
		{
			windows[i].winid = -1;
			windows[i].apid = -1;
		}
	}
	/* mark message as handled */
	message[0] = 0; /* FIXME: unnecessary */
}


static void av_startprog(_WORD *message)
{
	int slot;
	int i;
	char *name;
	char **pp;
	
	slot = -1;
	for (i = 0; i < MAX_PROGS; i++)
	{
		if (programs[i].apid == -1)
			slot = i;
	}
	if (slot != -1)
	{
		programs[slot].msg_extra = message[7];
		programs[slot].apid = message[1];
		pp = ((char **)&message[3]);
		name = *pp;;
		/*
		 * BUG: will crash with MP if memory is read-only
		 */
		if (setter.av_startprog_upper)
			strupr(name);
		strcpy(startprog_path, name);
		name = strrchr(startprog_path, '\\'); /* FIXME: handle also '/' */
		if (name != NULL)
		{
			name++;
			strcpy(startprog_name, name);
		} else
		{
			strncpy(startprog_name, startprog_path, MAX_APPNAME);
		}
		name = strchr(startprog_name, '.');
		if (name != NULL)
			*name = '\0';
		strcat(startprog_name, "        ");
		startprog_name[MAX_APPNAME] = '\0';
		strcpy(programs[slot].name, startprog_name);
		message[1] = gl_apid;
		message[7] = 0x7d00 + slot;
		appl_write(magxdesk, 16, message);
	} else
	{
		error_overflow();
	}
	/* mark message as handled */
	message[0] = 0; /* FIXME: unnecessary */
}


static void va_progstart(_WORD *message)
{
	int slot;
	
	if (message[7] != 0x3e81) /* ??? what is this? */
	{
		slot = message[7] - 0x7d00;
		if (slot >= 0 && slot < MAX_PROGS)
		{
			message[1] = gl_apid;
			message[7] = programs[slot].msg_extra;
			if (appl_find(programs[slot].name) < 0)
				message[3] = 0;
			else
				message[3] = 1;
			appl_write(programs[slot].apid, 16, message);
			programs[slot].apid = -1;
		} else if (message[7] != 0x3e80) /* if message was not sent from av_drag_on_window() */
		{
			error_internal();
		}
	}
	/* mark message as handled */
	message[0] = 0; /* FIXME: unnecessary */
}


static void av_sendkey(_WORD *message)
{
	_WORD scancode;
	
	scancode = message[4] >> 8;
	if (message[3] == K_CTRL && scancode == 0x11) /* BUG: 0x11 is not always scancode for 'W', should look at ascii code */
	{
		cycle_windows();
	} else
	{
		if (magxdesk >= 0 && scancode > 0 && scancode <= 0x39)
		{
			if (message[3] == (K_ALT | K_LSHIFT) ||
				message[3] == (K_ALT | K_RSHIFT) ||
				message[3] == (K_CTRL | K_LSHIFT) ||
				message[3] == (K_CTRL | K_RSHIFT))
			{
				message[0] = AV_XWIND;
				message[2] = 0;
				/* WTF. Use keyboard table instead */
				sprintf(startprog_path, "%c:\\", keyboard_table[scancode]);
				message[3] = (_WORD)((long)startprog_path >> 16);
				message[4] = (_WORD)((unsigned int)(unsigned long)startprog_path) & 0xffffu;
				strcpy(startprog_name, "*");
				message[5] = (_WORD)((long)startprog_name >> 16);
				message[6] = (_WORD)((unsigned int)(unsigned long)startprog_name) & 0xffffu;
				message[7] = 0;
				appl_write(magxdesk, 16, message);
			}
		}
	}
	/* mark message as handled */
	message[0] = 0; /* FIXME: unnecessary */
}


static void av_path_update(_WORD *message)
{
	/* mark message as handled */
	message[0] = 0; /* FIXME: unnecessary */
}


static void av_drag_on_window(_WORD *message)
{
	_WORD apid;
	_WORD mox, moy;
	char *names;
	char **pp;
	_WORD success;
	_WORD owner;
	_WORD wh;
	
	apid = message[1];
	mox = message[3];
	moy = message[4];
	names = NULL;
	pp = (char **)&message[6];
	if (pp != NULL) /* FIXME: cannot be NULL */
		names = *pp;
	else
		names = NULL;
	if (names != NULL && strlen(names) >= sizeof(startprog_path))
	{
		form_alert(1, "[3][AV-Server: Too many objects!][Cancel]");
		message[0] = VA_DRAG_COMPLETE;
		message[1] = gl_apid;
		message[2] = 0;
		message[3] = 0;
	} else
	{
		x11f4e(names);
		success = FALSE;
		switch (x11a12(mox, moy, &owner))
		{
		case VA_OB_FILE:
			if (names != NULL)
			{
				strcpy(startprog_name, names);
				message[0] = AV_STARTPROG;
				message[1] = gl_apid;
				message[2] = 0;
				message[3] = (_WORD)((long)startprog_path >> 16);
				message[4] = (_WORD)((unsigned int)(unsigned long)startprog_path) & 0xffffu;
				message[5] = (_WORD)((long)startprog_name >> 16);
				message[6] = (_WORD)((unsigned int)(unsigned long)startprog_name) & 0xffffu;
				message[7] = 0x3e80;
				appl_write(magxdesk, 16, message);
				success = TRUE;
			}
			break;
		
		case VA_OB_SHREDDER:
			if (names != NULL)
			{
				startprog_name[2] = 'D';
				success = TRUE;
				strcpy(startprog_path, MGCOPY_NAME);
				if (shel_find(startprog_path) == 0)
					strcpy(startprog_path, MGCOPY_PATH);
				if (shel_write(100, 1, 100, startprog_path, startprog_name) == 0)
					error_copy();
			}
			break;
		
		case VA_OB_WINDOW:
			wh = wind_find(mox, moy);
			if (wh > 0)
			{
				wind_get(wh, WF_OWNER, &owner);
				if (owner >= 0)
				{
					strcpy(startprog_name, names);
					message[0] = VA_DRAGACCWIND;
					message[1] = gl_apid;
					message[2] = 0;
					message[3] = wh;
					message[4] = mox;
					message[5] = moy;
					message[6] = (_WORD)((long)startprog_path >> 16);
					message[7] = (_WORD)((unsigned int)(unsigned long)startprog_path) & 0xffffu;
					appl_write(owner, 16, message);
					success = TRUE;
				}
			}
			break;
		
		case VA_OB_FOLDER:
			wh = wind_find(mox, moy); /* FIXME: no check for valid window handle */
			wind_get(wh, WF_OWNER, &owner);
			if (owner >= 0)
			{
				startprog_name[2] = 'C';
				strcat(startprog_name, " ");
				/* BUG: no check names != NULL */
				strcat(startprog_name, names);
				success = TRUE;
				strcpy(startprog_path, MGCOPY_NAME);
				if (shel_find(startprog_path) == 0)
					strcpy(startprog_path, MGCOPY_PATH);
				if (shel_write(100, 1, 100, startprog_path, startprog_name) == 0)
					error_copy();
			}
			break;
		
		case VA_OB_DRIVE:
			if (names != NULL)
			{
				startprog_name[2] = 'C';
				strcat(startprog_name, " ");
				strcat(startprog_name, names);
				success = TRUE;
				strcpy(startprog_path, MGCOPY_NAME);
				if (shel_find(startprog_path) == 0)
					strcpy(startprog_path, MGCOPY_PATH);
				if (shel_write(100, 1, 100, startprog_path, startprog_name) == 0)
					error_copy();
			}
			break;
		}
		message[0] = VA_DRAG_COMPLETE;
		message[1] = gl_apid;
		message[2] = 0;
		message[3] = success;
	}
	message[4] = 0;
	message[5] = 0;
	message[6] = 0;
	message[7] = 0;
	appl_write(apid, 16, message);
	/* mark message as handled */
	message[0] = 0; /* FIXME: unnecessary */
}


int dd_reply(int fd, _WORD msg4, _WORD msg5, _WORD msg3, _WORD id)
{
	(void)fd;
	(void)msg4;
	(void)msg5;
	(void)msg3;
	(void)id;
	return 0;
}


void av_xwind(_WORD *message)
{
	/* mark message as handled */
	message[0] = 0; /* FIXME: unnecessary */
}


void av_openwind(_WORD *message)
{
	(void)message;
}


void av_view(_WORD *message)
{
	(void)message;
}


void av_what_izit(_WORD *message)
{
	(void)message;
}


void av_status(_WORD *message)
{
	(void)message;
}


void av_getstatus(_WORD *message)
{
	(void)message;
}


void av_copyfile(_WORD *message)
{
	(void)message;
}


void av_delfile(_WORD *message)
{
	(void)message;
}


void font_select(_WORD *message)
{
	(void)message;
}


void error_dragdrop(void)
{
}


void error_internal(void)
{
}


void error_overflow(void)
{
}


void error_copy(void)
{
}


int xbra_unlink(int vec)
{
	(void)vec;
	return FALSE;
}

short sp_offset;
long install_aes_trap(void)
{
	return 0;
}


void cycle_windows(void)
{
}


static void x11486(void)
{
}


void x11f4e(char *names)
{
	(void)names;
}


int x11a12(_WORD mox, _WORD moy, _WORD *owner)
{
	(void)mox;
	(void)moy;
	(void)owner;
	return 0;
}
