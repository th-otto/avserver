struct setter {
	char magic[16];
	struct setter *self;
	char display[46];
	short type;
	short av_startprog_upper;
	char eos[2];
};

extern struct setter setter;
