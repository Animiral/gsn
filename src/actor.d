/*
 * Actors are Physicals which can accept inputs.
 * Examples for actors are ships and enemies.
 */
module actor;

import drawable;
import physical;

struct Input
{
    bool left;
    bool right;
    bool thrust;
    bool shoot;
}

class Actor : Physical
{
    int health; // 0 == dead, -1 == infinite

    this() {}

    void update ()
    {
        super.update();
    }
    
    void receive_input (Input input) {}
} // ships, enemies

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
