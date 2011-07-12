module map;

import cutbit;
import physical;
import xallegro;

struct Map
{
    XYi        px_size;

    Physical[] physicals;
    Cutbit     tileset;



    auto get_px_size()
    {
        return px_size;
    }
    
    void update()
    {
        foreach (physical; physicals)
        {
            physical.update();
        }
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
