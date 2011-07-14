/**
 * camera to view a map
 */

module camera;

import std.algorithm;
import cutbit;
import physical;
import map;
import xy;

class Camera
{

private
{
    Map map;
    Physical followee; // null if nothing is followed
    
    XYd src_pos;  // center (!) of area that shall be visible
    XYd src_size;
    XYd tar_pos;  // upper left corner of target bitmap
    XYd tar_size;
}

    void set_followee(Physical followee) { this.followee = followee; }


    this(Map map, XYd src_size, XYd tar_pos, XYd tar_size,
         Physical followee = null)
    {
        this.map = map;
        this.src_size = src_size;
        this.tar_pos = tar_pos;
        this.tar_size = tar_size;
        this.followee = followee;
    }

    void scroll_to(XYd where)   
    {
        followee = null;
        src_pos = where;
        normalize_src_pos();
    }
    
    void scroll_by(XYd howmuch)
    {
        followee = null;
        src_pos += howmuch;
        normalize_src_pos();
    }
    
    void follow()
    {
        src_pos = followee.get_pos();
    }

const
{
    XYd get_src_pos()  { return src_pos; }
    XYd get_src_size() { return src_size; }
    XYd get_tar_pos()  { return tar_pos; }
    XYd get_tar_size() { return tar_size; }

    /**
     * Function which maps map coordinates to screen coordinates.
     * Screen coordinates are coordinates in the target bitmap
     * relative to tar_pos.
     */
    XYd to_screen(XYd xy)
    {
        xy -= src_pos;
        xy.x *= tar_size.w / src_size.w;
        xy.y *= tar_size.h / src_size.h;
        return xy + tar_size.scale(.5);
    }
}
    
private
{
    void normalize_src_pos()
    {
        XYi mapl  = map.get_px_size();
        src_pos.x = std.algorithm.min(src_pos.x, src_size.x / 2);
        src_pos.y = std.algorithm.min(src_pos.y, src_size.y / 2);
        src_pos.x = std.algorithm.max(src_pos.x, mapl.x - src_size.x / 2);
        src_pos.y = std.algorithm.max(src_pos.x, mapl.y - src_size.y / 2);
    }
}

}
