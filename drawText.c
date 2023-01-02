#include "drawText.h"
#include <stdarg.h>

/* built-in functions */
extern struct {} *gpSystemFont;
typedef float Mtx[3][4];
typedef struct {
  void* __vt__;
  char unk[0x1c-4];
  int xInt;
  int yInt;
  float xFloat;
  float yFloat;
  float zFloat;
  char unk1[12];
  uint32_t bgMask;
  uint32_t fgMask;
  uint32_t colorTop;
  uint32_t colorBot;
  int x4c;
  int lineHeight;
  int x54;
  int fontWidth;
  int fontHeight;
  char unk3[8];
} J2DPrint;

void GXLoadPosMtxImm(Mtx, int);
void PSMTXTrans(double dx, double dy, double dz, Mtx mtx);
void PSMTXIdentity(Mtx mtx);
void new_J2DPrint(void *this, void *font, int x4c, int lineHeight, uint32_t *colorTop, uint32_t *colorBot);
// color.alpha = printer->color.alpha * alphaMask/0xff
void J2DPrint_print_alpha_va(void *printer, uint8_t alphaMask, const char *fmt, va_list args);
/**********************/


void drawText(DrawTextOpt *opt, const char *fmt, ...) {
  Mtx mtx;
  J2DPrint printer;

  va_list args;
  va_start(args, fmt);

  // new J2DPrinter
  new_J2DPrint(&printer, gpSystemFont, 0, opt->fontSize, &opt->colorTop, &opt->colorBot);
  printer.fontWidth = printer.fontHeight = opt->fontSize;

  // mtx = translate(x, y, 0)
  PSMTXTrans(opt->x, opt->y, 0, mtx);
  GXLoadPosMtxImm(mtx, 0);

  // print text
  J2DPrint_print_alpha_va(&printer, 0xff, fmt, args);
  va_end(args);

  // no need to delete if not allocating memory from heap
  // delete_J2DPrint(&printer, -1);

  PSMTXIdentity(mtx);
  GXLoadPosMtxImm(mtx, 0);
}
