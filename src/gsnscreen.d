import std.algorithm;
import std.math;
import allegro5.allegro;
import allegro5.allegro_primitives;
import xallegro;
import globals;
import team;
import util;
import cutbit;
import iscreen;
import drawable;

struct Input
{
    bool left;
    bool right;
    bool thrust;
    bool shoot;
}


class GsnScreen : IScreen
{
    Ship[]     ships;
    Enemy[]    enemies;
    Bullet[]   bullets;
    Obstacle[] obstacles;
    Team[]     teams;

    double gravity = STANDARD_GRAVITY;

    this()
    {
        // Cutbit ship_img = new Cutbit("res/ball.bmp");
        auto my_ship = new Ship(); // new Ship(ship_img);
        int display_w = al_get_display_width(the_display);
        int display_h = al_get_display_height(the_display);
        my_ship.set_pos(XY(display_w/2,display_h/2), XY(0,0), XY(0, gravity));
        ships ~= my_ship;
    }

    void calc()
    {
        Input input;
        ALLEGRO_KEYBOARD_STATE key_state;
        al_get_keyboard_state(&key_state);
        input.left = al_key_down(&key_state, ALLEGRO_KEY_LEFT);
        input.right = al_key_down(&key_state, ALLEGRO_KEY_RIGHT);
    
        if (ships.length > 0)
        {
            ships[0].receive_input(input);
        }
        
        foreach (physical; joiner([cast(Physical[])ships, enemies, bullets, obstacles]))
        {
            physical.calc();
        }
    }

    void draw(double dt)
    {
        int width = al_get_display_width(the_display);
        int height = al_get_display_height(the_display);
        
        dal_clear_to_color(dal_map_rgb(0, 0, 0));
        
        foreach (physical; joiner([cast(Physical[])ships, enemies, bullets, obstacles]))
        {
            physical.draw(dt);
        }
    }

    bool is_finished()
    {
        ALLEGRO_KEYBOARD_STATE key_state;
        al_get_keyboard_state(&key_state);
        return al_key_down(&key_state, ALLEGRO_KEY_ESCAPE);
    }
}

public alias GsnScreen GSN_Screen;
