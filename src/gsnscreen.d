import std.algorithm;
import allegro5.allegro;
import allegro5.allegro_primitives;
import globals;
import team;
import util;
import cutbit;
import IScreen;
import Drawable;

class Input
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
    void calc () {}
    void receive_input (Input input) {}
    
    int health; // 0 == dead, -1 == infinite
} // ships, enemies

class Bullet : Physical {} // all kinds of bullet (more like projectile)

class Enemy : Actor
{
    // round shiznit with waypoints and a pony
}

class Ship : Actor
{
    this (Cutbit cutbit)
    {
        super();
        this.drawables ~= new Animation(cutbit);
    }
}

class GsnScreen : IScreen
{
    Ship[]     ships;
    Enemy[]    enemies;
    Bullet[]   bullets;
    Obstacle[] obstacles;
    Team[]     teams;

    this()
    {
        auto my_ship = new Ship();
        my_ship.set_pos(XY(0,0));
        ships ~= my_ship;
    }

    void calc()
    {
        foreach (physical; joiner([cast(Physical[])ships, enemies, bullets, obstacles]))
        {
            physical.calc();
        }
    }

    void draw(double dt)
    {
        int width = al_get_display_width(the_display);
        int height = al_get_display_height(the_display);
    
        al_clear_to_color(ALLEGRO_COLOR.init);
        
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
