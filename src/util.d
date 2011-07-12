import allegro5.allegro;

struct XY
{
    double x;
    double y;
    
    alias x w;
    alias y h;
    
    XY translate (XY trans)
    {
        return XY(x+trans.x, y+trans.y);
    }
    
    XY rotate (double angle)
    {
        return XY(x*cos(angle)-y*sin(angle), y*cos(angle)-x*sin(angle), );
    }
    
    XY scale (double factor) { }
}

alias XY WH;
