import std.algorithm;
import std.math;
import allegro5.allegro;
import allegro5.allegro_primitives;
import xallegro;
import globals;
import team;
import xy;
import cutbit;
import iscreen;
import drawable;
import actor;
import physical;
import map;

class GsnScreen : IScreen
{
    Map    map;
    Team[] teams;
    Ship   my_ship;

    double gravity = STANDARD_GRAVITY;

    this()
    {
        // Cutbit ship_img = new Cutbit("res/ball.bmp");
        my_ship = new Ship(); // new Ship(ship_img);
        int display_w = al_get_display_width(the_display);
        int display_h = al_get_display_height(the_display);
        my_ship.set_pos(XYd(display_w/2,display_h/2),
                        XYd(0,0), XYd(0, gravity));
        map.physicals ~= my_ship;
    }

    void update()
    {
        Input input;
        ALLEGRO_KEYBOARD_STATE key_state;
        al_get_keyboard_state(&key_state);
        input.left = al_key_down(&key_state, ALLEGRO_KEY_LEFT);
        input.right = al_key_down(&key_state, ALLEGRO_KEY_RIGHT);
        my_ship.receive_input(input);
        
        map.update();
    }

    void draw(double dt)
    {
        map.draw(dt);
    }

    bool is_finished()
    {
        ALLEGRO_KEYBOARD_STATE key_state;
        al_get_keyboard_state(&key_state);
        return al_key_down(&key_state, ALLEGRO_KEY_ESCAPE);
    }
}

public alias GsnScreen GSN_Screen;
