/*
 * Physicals are game objects on the map that are not part of the
 * map itself. Physicals know their position, speed and acceleration,
 * as well as how to draw themselves.
 * 
 * Examples for Physicals are obstacles and actors.
 * Counter-examples are map tiles, background graphics, the panel and
 * mission texts.
 */
module physical;

import util;

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

class Bullet : Physical {} // all kinds of bullet (more like projectile)
