import std.math;
import xallegro;
import cutbit;
import globals;
import util;

debug import std.stdio;

interface Drawable
{
    void draw(XY pos);
}

class Animation : Drawable
{
    Cutbit cutbit;
    bool   loop          = true;
    int    current_row   = 0;
    int    current_frame = 0;

    this(Cutbit cutbit)
    {
        this.cutbit = cutbit;
        assert(cutbit && cutbit.get_good());
    }

    void next_frame()
    {
        current_frame++;
        int max_frame = cutbit.get_xf();
        if (current_frame >= max_frame)
        {
            current_frame = loop ? 0 : max_frame-1;
        }
    }
    
    void choose_anim(int row, bool loop = true)
    {
        assert ((row >= 0) && (row < cutbit.get_yf()));
        
        current_row = row;
        current_frame = 0;
        this.loop = loop;
    }
    
    void draw(XY pos)
    {
        cutbit.draw_to(cast(int)pos.x, cast(int)pos.y,
                       current_frame, current_row);
    }
}

class PrimitiveShipDrawable : Drawable
{
    double orientation = 0;

    void set_orientation(double ori)
    {
        orientation = ori;
    }

    void draw(XY pos)
    {
        double sin_ori = sin(orientation);
        double cos_ori = cos(orientation);
    
        double x1 = pos.x - 10 * cos_ori +  5 * sin_ori;
        double y1 = pos.y +  5 * cos_ori + 10 * sin_ori;
        double x2 = pos.x + 10 * cos_ori +  5 * sin_ori;
        double y2 = pos.y +  5 * cos_ori - 10 * sin_ori;
        double x3 = pos.x -  0 * cos_ori - 20 * sin_ori;
        double y3 = pos.y - 20 * cos_ori -  0 * sin_ori;
        
        dal_draw_filled_triangle(x1, y1, x2, y2, x3, y3, the_colors["white"]);
    }
}
