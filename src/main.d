import allegro5.allegro;
import globals;
import GsnScreen;

void main(string args[])
{
    al_init();
    al_install_keyboard();
    
    // make display
    al_set_new_bitmap_format(
        ALLEGRO_PIXEL_FORMAT.ALLEGRO_PIXEL_FORMAT_ANY_32_WITH_ALPHA);
    al_set_new_display_flags(ALLEGRO_WINDOWED);
    al_set_window_title(the_display, "Gravity Strike Nostalgia");
    the_display = al_create_display(640, 480);
    
    // use display for test
    ALLEGRO_BITMAP* testbmp = al_get_backbuffer(the_display);
    al_set_target_bitmap(testbmp);
    al_clear_to_color(al_map_rgb(0x80, 0, 0xC0));
    al_flip_display();
    
    // main loop
    // doing nothing right now besides waiting for keypress
    ALLEGRO_KEYBOARD_STATE key_state;
    al_get_keyboard_state(&key_state);
    while (! al_key_down(&key_state, ALLEGRO_KEY_ESCAPE)) { }
    
    // clean up everything in reverse order
    al_destroy_display(the_display);
}

