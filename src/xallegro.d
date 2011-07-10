import allegro5.allegro;

extern (C)
{
    void xal_map_rgba (ALLEGRO_COLOR* col, ubyte r, ubyte g, ubyte b, ubyte a);
    void xal_clear_to_color(ALLEGRO_COLOR* col);
}

ALLEGRO_COLOR dal_map_rgb (ubyte r, ubyte g, ubyte b)
{
    ALLEGRO_COLOR col = void;
    xal_map_rgba(&col, r, g, b, 0xff);
    return col;
}

ALLEGRO_COLOR dal_map_rgba (ubyte r, ubyte g, ubyte b, ubyte a)
{
    ALLEGRO_COLOR col = void;
    xal_map_rgba(&col, r, g, b, a);
    return col;
}

void dal_clear_to_color(ALLEGRO_COLOR col)
{
    xal_clear_to_color(&col);
}
