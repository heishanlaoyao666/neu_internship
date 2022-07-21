MsgDef = {}

MsgDef.REQTYPE  = {
	STARTGAME   =    1,
	HANDEL   	=    2,
	UPLOADSCORE =    3,
	HEARTBEAT   =    4,
	LOGIN       =    5,
	REGISTER	=	 6,
	GETDATA     =	 7,
	SENDDATA    =    8,
	MATCHING    =    9,
	CREATEGAME  =    500,
}

MsgDef.ACKTYPE = {
	STARTGAME   =    0x80000 + 1,
	GAMEOVER    =    0x80000 + 2,
	RANKLIST    =    0x80000 + 3,
	HEARTBEAT   =    0x80000 + 4,
	LOGIN       =    0x80000 + 5,
}

return MsgDef