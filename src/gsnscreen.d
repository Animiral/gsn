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


abstract class Physical
{
    XY pos;
    XY speed;
    XY accel;
    
    Drawable[] drawables; // primary drawables drawn at x/y
    
    void set_pos (XY pos, XY speed = XY(0,0), XY accel = XY(0,0))
    {
        this.pos = pos;
        this.speed = speed;
        this.accel = accel;
    }
    
    void calc()
    {
        pos.x += speed.x;
        pos.y += speed.y;
        speed.x += accel.x;
        speed.y += accel.y;
    }
    
    void draw(double dt)
    {
        double draw_x = pos.x + speed.x * dt;
        double draw_y = pos.y + speed.y * dt;
        
        foreach (d; drawables)
        {
            d.draw(XY(draw_x, draw_y));
        }
    }
}

class Obstacle : Physical
{
}

class Actor : Physical
{
    int health; // 0 == dead, -1 == infinite

    this() {}

    void calc ()
    {
        super.calc();
    }
    
    void receive_input (Input input) {}
} // ships, enemies

class Bullet : Physical {} // all kinds of bullet (more like projectile)

class Enemy : Actor
{
    // round shiznit with waypoints and a pony
}

class Ship : Actor
{
    double ori = 0;       // in radians, 0 = up, + = counter-clockwise
    double ori_speed = 0.04; // in radians per logic cycle
    PrimitiveShipDrawable temp_graphic;

    // this (Cutbit cutbit)
    this ()
    {
        super();
        // this.drawables ~= new Animation(cutbit);
        temp_graphic = new PrimitiveShipDrawable();
        this.drawables ~= temp_graphic;
    }
    
    void normalize_ori()
    {
        while (ori >= globals.TAU) ori -= globals.TAU;
        while (ori <  0)           ori += globals.TAU;
    }
    
    void receive_input(Input input)
    {
        double ori_diff = (input.left?1:0) - (input.right?1:0);
        ori += ori_diff * ori_speed;
        normalize_ori();
        temp_graphic.set_orientation(ori);
    }
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
