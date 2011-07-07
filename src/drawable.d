import cutbit;
import util;

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
        cutbit.draw_to(cast(int)pos.x, cast(int)pos.y, current_frame, current_row);
    }
}
