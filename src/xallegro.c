#include <allegro5/allegro.h>
#include <allegro5/allegro_primitives.h>
#include <string.h>

#define ubyte unsigned char

void xal_clear_to_color(ALLEGRO_COLOR* color)
{
    al_clear_to_color(*color);
}

void xal_convert_mask_to_alpha(ALLEGRO_BITMAP* bitmap, ALLEGRO_COLOR* color)
{
    al_convert_mask_to_alpha(bitmap, *color);
}

void xal_draw_filled_triangle(float x1, float y1, float x2, float y2,
                              float x3, float y3, ALLEGRO_COLOR* color)
{
    al_draw_filled_triangle(x1, y1, x2, y2, x3, y3, *color);
}

void xal_get_pixel(ALLEGRO_COLOR* color, ALLEGRO_BITMAP* bitmap, int x, int y)
{
    ALLEGRO_COLOR ret = al_get_pixel(bitmap, x, y);
    memcpy(color, &ret, sizeof(ALLEGRO_COLOR));
}

void xal_map_rgba (ALLEGRO_COLOR* color, ubyte r, ubyte g, ubyte b, ubyte a)
{
    ALLEGRO_COLOR ret = al_map_rgba(r, g, b, a);
    memcpy(color, &ret, sizeof(ALLEGRO_COLOR));
}
                          