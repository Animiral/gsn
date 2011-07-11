import allegro5.allegro;
import util;
import xallegro;

enum CALC_FPS = 60;
enum FRAMESKIP_MAX = 3;

ALLEGRO_DISPLAY* the_display;
ALLEGRO_TIMER* the_calc_timer;
ALLEGRO_COLOR[string] the_colors;

long the_game_time = 0;

// Call this only after Allegro has been initialized
void initialize_colors()
{
    the_colors["pink"] = dal_map_rgb(0xff, 0, 0xff);
}
