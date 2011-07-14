import std.math;
import xallegro;

import cutbit;
import camera;
import globals;
import xy;

debug import std.stdio;

abstract class Drawable
{

static
{
    private Camera[] cameras;
    
    void add_camera   (Camera c) { cameras ~= c;   }
    void clear_cameras()         { cameras = null; }
    const (Camera)[] get_cameras() { return cameras; }
}

    abstract protected void draw_onto_camera(Camera camera, XYd pos);
    
    final void draw(XYd pos) // is called by gsn_screen
    {
        foreach (cam; cameras) draw_onto_camera(cam, pos);
    }
}



class Animation : Drawable
{

private
{
    Cutbit cutbit;
    bool   loop          = true;
    int    current_row   = 0;
    int    current_frame = 0;
}

    bool get_loop()         { return loop; }
    int get_current_row()   { return current_row; }
    int get_current_frame() { return current_frame; }

    void set_loop(bool loop) { this.loop = loop; }
    
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
    
    void draw_onto_camera(Camera camera, XYd pos)
    {
        cutbit.draw_to(cast(int)pos.x, cast(int)pos.y,
                       current_frame, current_row);
    }
}

/* temporary measure */
class PrimitiveShipDrawable : Drawable
{
    double orientation = 0;

    void set_orientation(double ori)
    {
        orientation = ori;
    }

    void draw_onto_camera(Camera camera, XYd pos)
    {
        auto p1x = XYd(-10, 5);
        auto p2x = XYd( 10, 5);
        auto p3x = XYd(0, -20);
        auto p1 = p1x.rotate(orientation) + pos;
        auto p2 = p2x.rotate(orientation) + pos;
        auto p3 = p3x.rotate(orientation) + pos;
        
        dal_draw_filled_triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y,
                                 the_colors["white"]);
    }
}
