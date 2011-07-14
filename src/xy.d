import std.math;
import std.traits;

struct XY(T)
{
    T x;
    T y;
    
    alias x w;
    alias y h;

    ref XY opAssign(U) (XY!U rhs)
        if (isAssignable!(T,U))
    {
        x = rhs.x;
        y = rhs.y;
        return this;
    }

    U opCast(U) ()
    {
        U u;
        u = this;
        return u;
    }

    ref XY opOpAssign(string s, U)(XY!U rhs)
        if (isAssignable!(T, U) && (s == "+" || s == "-"))
    {
        mixin("x " ~ s ~ "= rhs.x;");
        mixin("y " ~ s ~ "= rhs.y;");
        return this;
    }

const
{
    XY opUnary(string s)() if (s == "-")
    {
        return XY(-x, -y);
    }

    auto opBinary(string s, U) (XY!U rhs)
        if ((s == "-" || s == "+") && is(typeof(T.init + U.init)))
    {
        return XY!(CommonType!(T,U)) (x + rhs.x, y + rhs.y);
    }
        
    XY rotate (double angle)
    {
        return XY(cast(T)( x * std.math.cos(angle) + y * std.math.sin(angle)),
                  cast(T)(-x * std.math.sin(angle) + y * std.math.cos(angle)));
    }
    
    XY rotate_around (XY around, double angle)
    {
        return (this - around).rotate(angle) + around;
    }
    
    XY scale (T factor)
    {
        return XY(x * factor, y * factor);
    }
    
} // end const

} // end struct

alias XY!double XYd;
alias XY!int    XYi;
alias XY!double WH;
