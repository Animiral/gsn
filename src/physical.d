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

import xy;
import drawable;

abstract class Physical
{
    XYd pos;
    XYd speed;
    XYd accel;
    
    Drawable[] drawables; // primary drawables drawn at x/y
    
    void set_pos (XYd pos, XYd speed = XYd(0,0), XYd accel = XYd(0,0))
    {
        this.pos = pos;
        this.speed = speed;
        this.accel = accel;
    }
    
    void update()
    {
        pos   += speed;
        speed -= accel;
    }
    
    void draw(double dt)
    {
        double draw_x = pos.x + speed.x * dt;
        double draw_y = pos.y + speed.y * dt;
        
        foreach (d; drawables)
        {
            d.draw(XYd(draw_x, draw_y));
        }
    }
}

class Obstacle : Physical
{
}

class Bullet : Physical {} // all kinds of bullet (more like projectile)
