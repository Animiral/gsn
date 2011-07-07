import std.exception;
import std.string;
import allegro5.allegro;
import globals;
import std.stdio;

class Cutbit
{
    ALLEGRO_BITMAP* bitmap = null; 

    int xl = 0; // x-width  of a single frame
    int yl = 0; // y-length of a single frame
    int xf = 1; // number of columns (frames in x direction) of the spritesheet  
    int yf = 1; // number of rows of the spritesheet
    
    int get_xl() const { return xl; }
    int get_yl() const { return yl; }
    int get_xf() const { return xf; }
    int get_yf() const { return yf; }
    
    bool            get_good() const { return bitmap != null; }
    ALLEGRO_BITMAP* get_al_bitmap()  { return bitmap; }
    
    
    
    this() { }
    
    this(string filename)
    {
        load(filename);
    }
    
    
    
    void load(string filename)
    {
        bitmap = al_load_bitmap(toStringz(filename));
        enforce (bitmap);
        
        // al_convert_mask_to_alpha(bitmap, the_colors["pink"]);
        cut();
    }
    
    
    
    private void cut()
    {
        xl = yl = 0;
        xf = yf = 1;
        assert (bitmap != null);
        
        const int bxl = xl = al_get_bitmap_width (bitmap);
        const int byl = yl = al_get_bitmap_height(bitmap);
        al_lock_bitmap(bitmap, al_get_bitmap_format(bitmap),
                               ALLEGRO_LOCK_READONLY);

        if (bxl < 3 || byl < 3) return;
        
        writefln("cut bitmap at %s  bxl=%s byl=%s\n", bitmap, bxl, byl);
        
        // Check whether there is a grid in the first few pixels
        // c is the color of the frame in spe
        ALLEGRO_COLOR c = al_get_pixel(bitmap, 0, 0);
        if (al_get_pixel(bitmap, 0, 1) == c
         && al_get_pixel(bitmap, 1, 0) == c
         && al_get_pixel(bitmap, 1, 1) != c)
        {
            // Determine the size of a single frame box.
            for (xl = 1; xl + 1 < bxl; ++xl)
                if (al_get_pixel(bitmap, xl+1, 1) == c) break;
            for (yl = 1; xl + 1 < bxl; ++yl)
                if (al_get_pixel(bitmap, 1, yl+1) == c) break;

            // If only one frame fits into the bitmap... 
            if (xl*2 > bxl && yl*2 > byl) {
                xl = bxl;
                yl = byl;
                xf = 1;
                yf = 1;
            }
            // ...otherwise count the number of frames
            else {
                for (xf = 0; (xf+1)*(xl+1) < bxl; ++xf) { }
                for (yf = 0; (yf+1)*(yl+1) < byl; ++yf) { }
            }
        }
        // If there is no frame in the first few pixels, then the values
        // are already set correctly. Thus, we're done cutting.
        al_unlock_bitmap(bitmap);        
    }
    // end void cut()
    
    
    
    
    void draw_to(int x, int y, int curxf = 0, int curyf = 0)
    {
        assert (curxf >= 0 && curxf < xf
             && curyf >= 0 && curyf < yf);
        
        // draw everything (even the pixel rows at the border) for 1/1-Cutbits
        if (xf == 1 && yf == 1)
            al_draw_bitmap(bitmap, x, y, 0); // 0 = no mirroring
        else
            al_draw_bitmap_region(bitmap,
                cast(float) 1 + curxf * (curxf + 1),
                cast(float) 1 + curyf * (curyf + 1),
                cast(float) xl, cast(float) yl,
                x, y, 0);
    }

}
