module map;

import std.algorithm; // find
import cutbit;
import physical;
import xallegro;
import xy;

class Map
{

private
{

    XYi        px_size;

    Physical[] physicals;
    Cutbit     tileset;

}

    this(XYi px_size, Cutbit tileset = null)
    {
        this.px_size = px_size;
        this.tileset = tileset;
    }

    XYi get_px_size() { return px_size; }
    
    
    
    void add_physical(Physical ph) {
        // we should use a std::set for this instead of an array.
        // as long as we aren't doing it, I check myself
        if (! find!"a is b"(physicals, ph))
            physicals ~= ph;
    }
    
    void update()
    {
        foreach (physical; physicals)
            physical.update();
    }

    void draw(double dt)
    {
        dal_clear_to_color(dal_map_rgb(0, 0, 0));
        
        foreach (physical; physicals)
        {
            physical.draw(dt);
        }
    }

}
