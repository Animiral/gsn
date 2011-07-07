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
    
    // make display
    al_set_new_bitmap_format(
        ALLEGRO_PIXEL_FORMAT.ALLEGRO_PIXEL_FORMAT_RGBA_8888);
    al_set_new_display_flags(ALLEGRO_WINDOWED);
    al_set_window_title(the_display, "Gravity Strike Nostalgia");
    the_display = al_create_display(640, 480);
    
    globals.initialize_colors();
}

void main(string args[])
{
    setup_allegro();
    
    IScreen screen = new GsnScreen();
    
    // main loop
    while (!screen.is_finished()) {
    
        al_set_target_bitmap(al_get_backbuffer(the_display));
        screen.draw(1);
        al_flip_display();
    }
    
    // clean up everything in reverse order
    al_destroy_display(the_display);
}

