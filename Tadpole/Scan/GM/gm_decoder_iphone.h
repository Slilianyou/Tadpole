#ifndef	__GM_DECODER_IPHONE_H__
#define	__GM_DECODER_IPHONE_H__

#ifdef __cplusplus
extern "C" {
#endif

    int gm_decoder_init();
    
    NSString * gm_decoder_decode(unsigned char *img, int w, int h);
    
#ifdef __cplusplus
}
#endif

#endif

