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

protected
{
    XYd pos;   // central
    XYd speed;
    XYd accel;
    WH size;   // bounding box reaches from [pos-size/2 .. pos+size/2]
   
    Drawable[] drawables; // primary drawables drawn at x/y
}

    XYd get_pos()   { return pos; }
    XYd get_speed() { return speed; }
    XYd get_accel() { return accel; }
    WH  get_size()  { return size; }

    void set_xys (XYd pos, XYd speed = XYd(0,0), XYd accel = XYd(0,0))
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
