import allegro5.allegro;
import util;
import xallegro;

ALLEGRO_DISPLAY* the_display;

ALLEGRO_COLOR[string] the_colors;

// Call this only after Allegro has been initialized
void initialize_colors()
{
    the_colors["pink"] = dal_map_rgb(0xff, 0, 0xff);
}
