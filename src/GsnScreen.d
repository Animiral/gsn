import allegro5.allegro;
import allegro5.allegro_primitives;
import globals;
import IScreen;

class GsnScreen : IScreen
{
    void calc()
    {

    }

    void draw()
    {
        int width = al_get_display_width(the_display);
        int height = al_get_display_height(the_display);
    
        al_clear_to_color(ALLEGRO_COLOR.init);
        al_draw_filled_circle(width/2.0, height/2.0, height/2.0, al_map_rgb(255, 255, 0));
    }

    bool is_finished()
    {
        ALLEGRO_KEYBOARD_STATE key_state;
        al_get_keyboard_state(&key_state);
        return al_key_down(&key_state, ALLEGRO_KEY_ESCAPE);
    }
}

public alias GsnScreen GSN_Screen;
