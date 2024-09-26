#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <aes.h>
#include <tos.h>
#include "vaproto.h"

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

struct avserver_info {
	short maxclients;
	short maxwindows;
	short o4;
	struct client *clients;
	struct window *windows;
	struct client *programs;
};

_WORD gl_apid;
_WORD magxdesk;
_WORD x15068;
_WORD av_protokoll3;
_WORD av_protokoll4;
char space1[2162];
void *x158e0;
struct client clients[MAX_CLIENTS];
struct window windows[MAX_WINDS];
struct client programs[MAX_PROGS];
struct avserver_info avserver_info;

static void etv_term(void);
static void x11486(void);

int dd_reply(int fd, _WORD msg4, _WORD msg5, _WORD msg3, _WORD id);

void error_dragdrop(void);
void error_internal(void);
void error_overflow(void);

int xbra_unlink(int vec);


static void av_protokoll(_WORD *message);
void av_exit(_WORD *message);
void av_path_update(_WORD *message);
void av_drag_on_window(_WORD *message);
void av_what_izit(_WORD *message);
static void av_accwindopen(_WORD *message);
static void av_accwindclosed(_WORD *message);
static void av_startprog(_WORD *message);
void va_progstart(_WORD *message);
void av_sendkey(_WORD *message);
void av_xwind(_WORD *message);
void av_openwind(_WORD *message);
void av_view(_WORD *message);
void av_status(_WORD *message);
void av_getstatus(_WORD *message);
void av_copyfile(_WORD *message);
void av_delfile(_WORD *message);
static void va_start_(void);

#define AV_4798 0x4798
#define VA_4799 0x4799
static void av_4798(_WORD *message);

#define FONT_SELECT   0x7a19
void font_select(_WORD *message);

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
	avserver_info.o4 = MAX_PROGS;
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
		
		if (message[0] == AV_4798)
			av_4798(message);
		
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


void av_exit(_WORD *message)
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


static void av_4798(_WORD *message)
{
	const char *p;
	_WORD apid;
	
	p = (char *)&avserver_info;
	apid = message[1];
	message[0] = VA_4799;
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
	(void)message;
}


static void x11486(void)
{
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


void va_progstart(_WORD *message)
{
	(void)message;
}


void av_sendkey(_WORD *message)
{
	(void)message;
}


void av_xwind(_WORD *message)
{
	(void)message;
}


void av_openwind(_WORD *message)
{
	(void)message;
}


void av_view(_WORD *message)
{
	(void)message;
}


void av_path_update(_WORD *message)
{
	(void)message;
}


void av_drag_on_window(_WORD *message)
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
