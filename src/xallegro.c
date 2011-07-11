#include <allegro5/allegro.h>
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
