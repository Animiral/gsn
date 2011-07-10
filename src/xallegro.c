#include <allegro5/allegro.h>
#include <string.h>

#define ubyte unsigned char

void xal_map_rgba (ALLEGRO_COLOR* col, ubyte r, ubyte g, ubyte b, ubyte a)
{
    ALLEGRO_COLOR ret = al_map_rgba(r, g, b, a);
    memcpy(col, &ret, sizeof(ALLEGRO_COLOR));
}

void xal_clear_to_color(ALLEGRO_COLOR* col)
{
    al_clear_to_color(*col);
}
