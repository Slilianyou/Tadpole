#ifndef __SYSCAN_BMP_READ_WRITE_H__
#define __SYSCAN_BMP_READ_WRITE_H__

#ifdef __cplusplus
extern "C" {
#endif

//////////////////////////////////////////////////////////////////////////
typedef	signed	 char	sint8  ;
typedef unsigned char	uint8  ;
typedef			 short	sint16 ;
typedef unsigned short	uint16 ;
typedef			 int	sint32 ;
typedef unsigned int	uint32 ;

#if defined(WIN32) || defined(WINCE)
#include <tchar.h>
#else
typedef char _TCHAR;
#endif

//≤ …´bmpÕºœÒŒƒº˛Õ∑µƒ≥§∂»°£≤ …´ÕºœÒ «÷∏RGB888ÕºœÒ°£
#define COLOR_BMP_HEAD_SIZE (sizeof(BITMAPFILEHEADER)+sizeof(BITMAPINFOHEADER))
//ª“∂»bmpÕºœÒŒƒº˛Õ∑µƒ≥§∂»
#define GRAY_BMP_HEAD_SIZE (COLOR_BMP_HEAD_SIZE+sizeof(RGBQUAD)*256)
//∂˛÷µbmpÕºœÒŒƒº˛Õ∑µƒ≥§∂»
#define BW_BMP_HEAD_SIZE (COLOR_BMP_HEAD_SIZE+sizeof(RGBQUAD)*2)


//–¥bmpŒƒº˛°£
//∑µªÿ÷µ£∫∑µªÿ0±Ì æ≥…π¶£¨∏∫÷µ±Ì æ ß∞‹
sint32 syscan_write_bmp_file(
const _TCHAR* szfilename,	//[IN] Œƒº˛√˚
const uint8* pPixel,		//[IN] œÛÀÿ ˝æ›æÿ’Û
sint32 bitcount,	//[IN] √øœÛÀÿÀ˘’ºŒª ˝°£µ±«∞÷ª÷ß≥÷1,8,24£¨∂‘”¶”⁄∂˛÷µÕº°¢ª“∂»Õº”Î24Œª…´Õº
sint32 img_w,		//[IN] ÕºœÒøÌ∂»
sint32 img_h,		//[IN] ÕºœÒ∏ﬂ∂»
double resX,		//[IN] øÌ∂»∑ΩœÚ∑÷±Ê¬ £¨µ•Œª «DPI
double resY,		//[IN] ∏ﬂ∂»∑ΩœÚ∑÷±Ê¬ £¨µ•Œª «DPI
uint32 fore_color,	//[IN] Ωˆ∂‘bitcount=1”––ß£¨œÛÀÿ ˝æ›æÿ’Û÷–Œª÷µ"1"∂‘”¶µƒœÛÀÿµ„µƒ—’…´£¨∏Ò ΩŒ™0xbbggrr
uint32 back_color);	//[IN] Ωˆ∂‘bitcount=1”––ß£¨œÛÀÿ ˝æ›æÿ’Û÷–Œª÷µ"0"∂‘”¶µƒœÛÀÿµ„µƒ—’…´£¨∏Ò ΩŒ™0xbbggrr


//≥ı ºªØbmpŒƒº˛Õ∑
sint32 syscan_init_bmp_header(
uint8 *buf,
sint32 bitcount,
sint32 img_w,
sint32 img_h,
double resX,
double resY,
uint32 fore_color,
uint32 back_color);

#ifdef __cplusplus
}
#endif


#endif
