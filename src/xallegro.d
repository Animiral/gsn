import allegro5.allegro;

extern (C)
{
    void xal_clear_to_color(ALLEGRO_COLOR* color);
    void xal_convert_mask_to_alpha(ALLEGRO_BITMAP* bitmap, ALLEGRO_COLOR* color);
    void xal_get_pixel(ALLEGRO_COLOR* color, ALLEGRO_BITMAP* bitmap, int x, int y);
    void xal_map_rgba (ALLEGRO_COLOR* color, ubyte r, ubyte g, ubyte b, ubyte a);
}

void dal_clear_to_color(ALLEGRO_COLOR col)
{
    xal_clear_to_color(&col);
}

void dal_convert_mask_to_alpha(ALLEGRO_BITMAP* bitmap, ALLEGRO_COLOR color)
{
    xal_convert_mask_to_alpha(bitmap, &color);
}

ALLEGRO_COLOR dal_get_pixel(ALLEGRO_BITMAP* bitmap, int x, int y)
{
    ALLEGRO_COLOR col = void;
    xal_get_pixel(&col, bitmap, x, y);
    return col;
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
