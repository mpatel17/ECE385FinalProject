//io_handler.c
#include "io_handler.h"
#include <stdio.h>

void IO_init(void)
{
//	printf("about to initialize");
	*otg_hpi_reset = 1;
	*otg_hpi_cs = 1;
	*otg_hpi_r = 1;
	*otg_hpi_w = 1;
	*otg_hpi_address = 0;
	*otg_hpi_data = 0;
	// Reset OTG chip
	*otg_hpi_cs = 0;
//	printf("about to reset");
	*otg_hpi_reset = 0;
	*otg_hpi_reset = 1;
//	printf("finished reset");
	*otg_hpi_cs = 1;
//	printf("finished init");
}

void IO_write(alt_u8 Address, alt_u16 Data)
{
//*************************************************************************//
//									TASK								   //
//*************************************************************************//
//							Write this function							   //
//*************************************************************************//
	*otg_hpi_address = Address;
	*otg_hpi_cs = 0;
	*otg_hpi_w = 0;
	*otg_hpi_data = Data;
	*otg_hpi_w = 1;
	*otg_hpi_cs = 1;
//	*otg_hpi_data = 0;
//	*otg_hpi_address = 0;
	return;
}

alt_u16 IO_read(alt_u8 Address)
{
	alt_u16 temp;
//*************************************************************************//
//									TASK								   //
//*************************************************************************//
//							Write this function							   //
//*************************************************************************//
	*otg_hpi_address = Address;
	*otg_hpi_cs = 0;
	*otg_hpi_r = 0;
	temp = *otg_hpi_data;
	*otg_hpi_r = 1;
	*otg_hpi_cs = 1;
//	*otg_hpi_address = 0;
	//printf("%x\n",temp);
	return temp;
}
