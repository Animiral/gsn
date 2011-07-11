import std.conv;
import std.traits;
import allegro5.allegro;

extern (C)
{
    void xal_clear_to_color(ALLEGRO_COLOR* color);
    void xal_convert_mask_to_alpha(ALLEGRO_BITMAP* bitmap,ALLEGRO_COLOR* color);
    void xal_draw_filled_triangle(float x1, float y1, float x2, float y2,
                                  float x3, float y3, ALLEGRO_COLOR* color);
    void xal_get_pixel(ALLEGRO_COLOR* color,ALLEGRO_BITMAP* bitmap,int x,int y);
    void xal_map_rgba (ALLEGRO_COLOR* color,ubyte r, ubyte g, ubyte b, ubyte a);
}

void dal_clear_to_color(ALLEGRO_COLOR col)
{
    xal_clear_to_color(&col);
}

void dal_convert_mask_to_alpha(ALLEGRO_BITMAP* bitmap, ALLEGRO_COLOR color)
{
    xal_convert_mask_to_alpha(bitmap, &color);
}

void dal_draw_filled_triangle(T)(T x1, T y1, T x2, T y2, T x3, T y3,
                                 ALLEGRO_COLOR color)
    if (isFloatingPoint!T)
{
    xal_draw_filled_triangle(cast(float)x1, cast(float)y1, cast(float)x2,
                             cast(float)y2, cast(float)x3, cast(float)y3,
                             &color);
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
