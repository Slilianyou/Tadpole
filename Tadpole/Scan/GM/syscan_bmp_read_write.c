
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "syscan_bmp_read_write.h"

//Not Enough Memory
#define OUT_OF_MEMORY (-100)

//DISK IO ERRORS
#define OPEN_READ_FILE_FAIL		(-120)
#define OPEN_WRITE_FILE_FAIL	(-121)
#define DISK_IO_ERROR			(-122)

//Bmp Read Write ERRORS
#define NOT_BMP_FILE			(-130)
#define BMP_TYPE_UNSURPPORTED	(-131)


#if defined(WIN32) || defined(WINCE)
#include <windows.h>
#else
#pragma	pack(push,1)

#define _T(x) (x)
#define _tfopen(p1, p2) fopen((p1), (p2))

typedef	struct tagBITMAPINFOHEADER{
	uint32	biSize; 
	sint32	biWidth;	
	sint32	biHeight; 
	uint16	biPlanes; 
	uint16	biBitCount; 
	uint32	biCompression; 
	uint32	biSizeImage;	
	sint32	biXPelsPerMeter;	
	sint32	biYPelsPerMeter;	
	uint32	biClrUsed; 
	uint32	biClrImportant; 
} BITMAPINFOHEADER;

typedef	struct tagBITMAPFILEHEADER { 
	sint16	bfType;	
	sint32	bfSize;	
	sint16	bfReserved1; 
	sint16	bfReserved2; 
	sint32	bfOffBits; 
} BITMAPFILEHEADER;	

typedef	struct tagRGBQUAD {
	uint8	rgbBlue;	
	uint8	rgbGreen; 
	uint8	rgbRed; 
	uint8	rgbReserved;	
} RGBQUAD;

#define	BI_RGB 0

#pragma	pack(pop)

#endif


static sint32 flip_bmp_horiz(uint8 *pPixel, sint32 nBytesPerline, sint32 nImgHeight)
{
	uint8 *pTemp=NULL;
	sint32 i;

	pTemp =	(uint8 *)malloc(nBytesPerline);
	if (pTemp == NULL)
		return OUT_OF_MEMORY;

	for	(i=0; i<(nImgHeight>>1); i++)
	{
		memcpy(pTemp,pPixel+i*nBytesPerline,nBytesPerline);
		memcpy(pPixel+i*nBytesPerline,pPixel+(nImgHeight-i-1)*nBytesPerline,nBytesPerline);
		memcpy(pPixel+(nImgHeight-i-1)*nBytesPerline,pTemp,nBytesPerline);
	}

	free(pTemp);
	return 0;
}

sint32 syscan_write_bmp_file(
const _TCHAR* szfilename,
const uint8* pPixel,
sint32 bitcount,
sint32 img_w,
sint32 img_h,
double resX,
double resY,
uint32 fore_color,
uint32 back_color)
{
	uint8			 buf[GRAY_BMP_HEAD_SIZE];
	FILE			 *fp=NULL;
	uint8			 *pTemp=NULL;
	sint32			 nRet=0,bytes_per_line;
	uint32			 size;
	
	/* write file */
	fp = _tfopen(szfilename,_T("wb"));
	if (fp==NULL)
	{
		nRet=OPEN_WRITE_FILE_FAIL;
		goto ERROR_EXIT;
	}
	nRet = syscan_init_bmp_header(buf,bitcount,img_w,img_h,resX,resY,fore_color,back_color);
	if (nRet<0) goto ERROR_EXIT;

	size = nRet;
	if (size !=	fwrite(buf,1,size,fp))//write file header
	{
		nRet=DISK_IO_ERROR;
		goto ERROR_EXIT;
	}

	bytes_per_line = (img_w*bitcount + 31)/32 *	4;
	size = bytes_per_line*img_h;
	pTemp = (uint8*)malloc(size);
	if (pTemp==NULL)
	{
		nRet=OUT_OF_MEMORY;
		goto ERROR_EXIT;
	}
	memcpy(pTemp,pPixel,size);
	nRet = flip_bmp_horiz(pTemp,bytes_per_line,img_h);
	if (nRet !=	0)
	{
		goto ERROR_EXIT;
	}
	if (size !=	fwrite(pTemp,1,size,fp))//write	image bits
	{
		nRet=DISK_IO_ERROR;
		goto ERROR_EXIT;
	}

ERROR_EXIT:
	if (pTemp)	free(pTemp);
	if (fp)		fclose(fp);

	return nRet;
}

//≥ı ºªØbmpŒƒº˛Õ∑
sint32 syscan_init_bmp_header(
uint8 *buf,
sint32 bitcount,
sint32 img_w,
sint32 img_h,
double resX,
double resY,
uint32 fore_color,
uint32 back_color)
{
	BITMAPFILEHEADER bmpfh;
	BITMAPINFOHEADER bmpih;
	RGBQUAD			 rq[256];
	sint32 bytes_per_line, size, size1, size2;
	sint32 c;

	size1 = sizeof(BITMAPFILEHEADER);
	size2 = sizeof(BITMAPINFOHEADER);
	size = size1+size2;
	bytes_per_line = (img_w*bitcount + 31)/32 *	4;

	memset(&bmpfh,0,size1);
	bmpfh.bfType	= ('M' << 8) | 'B';
	bmpfh.bfSize	= size + bytes_per_line*img_h;
	bmpfh.bfOffBits= size;
	if (bitcount==1 || bitcount==8)
	{
		bmpfh.bfSize	+= sizeof(RGBQUAD)*(1<<bitcount);
		bmpfh.bfOffBits+= sizeof(RGBQUAD)*(1<<bitcount);
	}
	memcpy(buf,&bmpfh,size1);

	memset(&bmpih,0,size2);
	bmpih.biSize		  =	sizeof(BITMAPINFOHEADER);
	bmpih.biWidth		  =	img_w;
	bmpih.biHeight		  =	img_h;
	bmpih.biPlanes		  =	1;
	bmpih.biBitCount	  =	(uint16)bitcount;
	bmpih.biCompression  =	BI_RGB;
	bmpih.biSizeImage	  =	0;
	bmpih.biXPelsPerMeter =	(long)(resX	/ 2.54 * 100);
	bmpih.biYPelsPerMeter =	(long)(resY	/ 2.54 * 100);
	bmpih.biClrUsed	   =	0; 
	bmpih.biClrImportant =	0;
	memcpy(buf+size1,&bmpih,size2);

	switch (bitcount)
	{
	case 24:
		break;
	case 8:
		for	(c=0; c<=255; c++)
		{
			rq[c].rgbRed   = (uint8)c;
			rq[c].rgbGreen = (uint8)c;
			rq[c].rgbBlue  = (uint8)c;
			rq[c].rgbReserved = 0;
		}
		memcpy(buf+size,rq,256*sizeof(RGBQUAD));
		size += 256*sizeof(RGBQUAD);
		break;

	case 1:
		rq[0].rgbRed   = (uint8)( back_color		& 0xff);
		rq[0].rgbGreen = (uint8)((back_color >>	8)	& 0xff);
		rq[0].rgbBlue  = (uint8)((back_color >>	16)	& 0xff);
		rq[0].rgbReserved = 0;

		rq[1].rgbRed   = (uint8)( fore_color		& 0xff);
		rq[1].rgbGreen = (uint8)((fore_color >>	8)	& 0xff);
		rq[1].rgbBlue  = (uint8)((fore_color >>	16)	& 0xff);
		rq[1].rgbReserved = 0;
		memcpy(buf+size,rq,2*sizeof(RGBQUAD));
		size += 2*sizeof(RGBQUAD);
		break;
	default:
		return BMP_TYPE_UNSURPPORTED;
	}

	return size;
}

