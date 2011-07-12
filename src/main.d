import std.exception;
import std.algorithm;
import allegro5.allegro;
import allegro5.allegro_image;
import allegro5.allegro_primitives;
import globals;
import iscreen;
import gsnscreen;

void setup_allegro()
{
    al_init();
    al_init_image_addon();
    al_init_primitives_addon();
    
    al_install_keyboard();
    the_calc_timer = al_create_timer(ALLEGRO_BPS_TO_SECS(CALC_FPS));
    enforce (the_calc_timer);
    
    // make display
    al_set_new_bitmap_format(
        ALLEGRO_PIXEL_FORMAT.ALLEGRO_PIXEL_FORMAT_RGBA_8888);
    al_set_new_display_flags(ALLEGRO_WINDOWED);
    al_set_window_title(the_display, "Gravity Strike Nostalgia");
    the_display = al_create_display(640, 480);
    
    globals.initialize_colors();
}



void cleanup_allegro()
{
    al_destroy_display(the_display);
    al_destroy_timer(the_calc_timer);
}



void main(string args[])
{
    setup_allegro();
    
    IScreen screen = new GsnScreen();
    
    // loading complete - time critical code starts now
    al_start_timer(the_calc_timer);
    
    // main loop
    while (!screen.is_finished()) {
        long update_ticks = al_get_timer_count(the_calc_timer);
        foreach (i; 0..min(update_ticks-the_game_time, FRAMESKIP_MAX+1))
        {
            screen.update();
            the_game_time++;
        }
        al_set_target_bitmap(al_get_backbuffer(the_display));
        screen.draw(0);
        al_flip_display();
    }
    
    // clean up everything in reverse order
    cleanup_allegro();
}

