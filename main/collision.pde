//class made by ClickerMonkey http://stackoverflow.com/questions/18704999/how-to-fix-circle-and-rectangle-overlap-in-collision-response/18790389#18790389
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.event.MouseEvent;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Rectangle2D;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.event.MouseInputListener;

public class CircleRectangle extends JPanel implements MouseInputListener
{
   private static final long serialVersionUID = 1L;

   public static void main(String[] args )
    {
        JFrame window = new JFrame();
        window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        window.setTitle("Circle Rectangle");
        window.setLocationRelativeTo(null);

        CircleRectangle space = new CircleRectangle();
        window.add(space);
        window.setSize(640, 480);
        window.setResizable(false);

        window.setVisible(true);

        space.start();
    }

    public CircleRectangle()
    {
        setBackground(Color.BLACK);
        addMouseListener(this);
        addMouseMotionListener(this);
    }

    public static final Font FONT = new Font( "Monospaced" , Font.PLAIN, 12 );

    private enum DraggingState
    {
        START, END, RADIUS, NONE;
    }

    private class Intersection
    {
        public float cx, cy, time, nx, ny, ix, iy;
        public Intersection(float x, float y, float time, float nx, float ny, float ix, float iy)
        {
            this.cx = x;
            this.cy = y;
            this.time = time;
            this.nx = nx;
            this.ny = ny;
            this.ix = ix;
            this.iy = iy;
        }
    }

    private float pointRadius = 8.0f;
    private Vector2 start;
    private Vector2 end;
    private Vector2 radiusPoint;
    private float radius;
    private Bounds bounds;
    private DraggingState dragging;

    public void start()
    {
        bounds = new Bounds( 150, 150, 490, 330 );
        start = new Vector2( 50, 400 );
        end = new Vector2( 320, 240 );
        radius = 40.0f;
        radiusPoint = new Vector2( start.x, start.y - radius );
        dragging = DraggingState.NONE;
    }

    public void paint( Graphics g )
    {
        Graphics2D g2d = (Graphics2D)g;
        
        g2d.setRenderingHint( RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON );

        g2d.setColor(getBackground());
        g2d.fillRect(0, 0, getWidth(), getHeight());

        g2d.setColor( Color.BLUE );
        g2d.draw( new Rectangle2D.Float( bounds.left, bounds.top, bounds.getWidth(), bounds.getHeight() ) );

        g2d.setColor( Color.WHITE );
        g2d.draw( new Line2D.Float( start.x, start.y, end.x, end.y ) );

        g2d.setColor( Color.GREEN );
        g2d.draw( new Ellipse2D.Float( start.x - pointRadius, start.y - pointRadius, pointRadius * 2, pointRadius * 2 ) );

        g2d.setColor( Color.RED );
        g2d.draw( new Ellipse2D.Float( end.x - pointRadius, end.y - pointRadius, pointRadius * 2, pointRadius * 2 ) );

        g2d.setColor( Color.YELLOW );
        g2d.draw( new Ellipse2D.Float( radiusPoint.x - pointRadius, radiusPoint.y - pointRadius, pointRadius * 2, pointRadius * 2 ) );
        g2d.draw( new Ellipse2D.Float( start.x - radius, start.y - radius, radius * 2, radius * 2 ) );
        g2d.draw( new Ellipse2D.Float( end.x - radius, end.y - radius, radius * 2, radius * 2 ) );

        // Check for intersection

        g2d.setColor( Color.LIGHT_GRAY );
        g2d.setFont( FONT );

        Intersection inter = handleIntersection( bounds, start, end, radius );

        if (inter != null)
        {
            g2d.setColor( Color.LIGHT_GRAY );
            g2d.drawString( "time: " + inter.time, 10, 20 );

            g2d.setColor( Color.GRAY );
            g2d.draw( new Ellipse2D.Float( inter.cx - radius, inter.cy - radius, radius * 2, radius * 2 ) );
            g2d.draw( new Line2D.Float( inter.cx, inter.cy, inter.cx + inter.nx * 20, inter.cy + inter.ny * 20 ) );
         
            g2d.setColor( Color.RED );
            g2d.draw( new Ellipse2D.Float( inter.ix - 2, inter.iy - 2, 4, 4 ) );
         
            // Project Future Position
            float remainingTime = 1.0f - inter.time;
            float dx = end.x - start.x;
            float dy = end.y - start.y;
            float dot = dx * inter.nx + dy * inter.ny;
            float ndx = dx - 2 * dot * inter.nx;
            float ndy = dy - 2 * dot * inter.ny;
            float newx = inter.cx + ndx * remainingTime;
            float newy = inter.cy + ndy * remainingTime;
 
            g2d.setColor( Color.darkGray );
            g2d.draw( new Ellipse2D.Float( newx - radius, newy - radius, radius * 2, radius * 2 ) );
            g2d.draw( new Line2D.Float( inter.cx, inter.cy, newx, newy ) );
        }
    }

    private Intersection handleIntersection(Bounds bounds, Vector2 start, Vector2 end, float radius)
    {
        final float L = bounds.left;
        final float T = bounds.top;
        final float R = bounds.right;
        final float B = bounds.bottom;

        // If the bounding box around the start and end points (+radius on all
        // sides) does not intersect with the rectangle, definitely not an
        // intersection
        if ((Math.max( start.x, end.x ) + radius < L) ||
            (Math.min( start.x, end.x ) - radius > R) ||
            (Math.max( start.y, end.y ) + radius < T) ||
            (Math.min( start.y, end.y ) - radius > B) )
        {
            return null;
        }

        final float dx = end.x - start.x;
        final float dy = end.y - start.y;
        final float invdx = (dx == 0.0f ? 0.0f : 1.0f / dx);
        final float invdy = (dy == 0.0f ? 0.0f : 1.0f / dy);
        float cornerX = Float.MAX_VALUE;
        float cornerY = Float.MAX_VALUE;

        // Calculate intersection times with each side's plane
        // Check each side's quadrant for single-side intersection
        // Calculate Corner
     
        /** Left Side **/
        // Does the circle go from the left side to the right side of the rectangle's left?
        if ( start.x - radius < L && end.x + radius > L )
        {
            float ltime = ((L - radius) - start.x) * invdx;
            if (ltime >= 0.0f && ltime <= 1.0f)
            {
                float ly = dy * ltime + start.y;
                // Does the collisions point lie on the left side?
                if (ly >= T && ly <= B)
                {
                    return new Intersection( dx * ltime + start.x, ly, ltime, -1, 0, L, ly );
                }
            }
            cornerX = L;
        }

        /** Right Side **/
        // Does the circle go from the right side to the left side of the rectangle's right?
        if ( start.x + radius > R && end.x - radius < R )
        {
            float rtime = (start.x - (R + radius)) * -invdx;
            if (rtime >= 0.0f && rtime <= 1.0f)
            {
                float ry = dy * rtime + start.y;
                // Does the collisions point lie on the right side?
                if (ry >= T && ry <= B)
                {
                    return new Intersection( dx * rtime + start.x, ry, rtime, 1, 0, R, ry );
                }
            }
            cornerX = R;
        }

        /** Top Side **/
        // Does the circle go from the top side to the bottom side of the rectangle's top?
        if (start.y - radius < T && end.y + radius > T)
        {
            float ttime = ((T - radius) - start.y) * invdy;
            if (ttime >= 0.0f && ttime <= 1.0f)
            {
                float tx = dx * ttime + start.x;
                // Does the collisions point lie on the top side?
                if (tx >= L && tx <= R)
                {
                    return new Intersection( tx, dy * ttime + start.y, ttime, 0, -1, tx, T );
                }
            }
            cornerY = T;
        }
 
        /** Bottom Side **/
        // Does the circle go from the bottom side to the top side of the rectangle's bottom?
        if (start.y + radius > B && end.y - radius < B)
        {
            float btime = (start.y - (B + radius)) * -invdy;
            if (btime >= 0.0f && btime <= 1.0f) {
                float bx = dx * btime + start.x;
                // Does the collisions point lie on the bottom side?
                if (bx >= L && bx <= R)
                {
                    return new Intersection( bx, dy * btime + start.y, btime, 0, 1, bx, B );
                }
            }
            cornerY = B;
        }

        // No intersection at all!
        if (cornerX == Float.MAX_VALUE && cornerY == Float.MAX_VALUE)
        {
            return null;
        }

        // Account for the times where we don't pass over a side but we do hit it's corner
        if (cornerX != Float.MAX_VALUE && cornerY == Float.MAX_VALUE)
        {
            cornerY = (dy > 0.0f ? B : T);
        }
        if (cornerY != Float.MAX_VALUE && cornerX == Float.MAX_VALUE)
        {
            cornerX = (dx > 0.0f ? R : L);
        }

        /* Solve the triangle between the start, corner, and intersection point.
         *                    
         *           +-----------T-----------+
         *           |                       |
         *          L|                       |R
         *           |                       |
         *           C-----------B-----------+
         *          / \      
         *         /   \r     _.-E
         *        /     \ _.-'
         *       /    _.-I
         *      / _.-'
         *     S-'
         *
         * S = start of circle's path
         * E = end of circle's path
         * LTRB = sides of the rectangle
         * I = {ix, iY} = point at which the circle intersects with the rectangle
         * C = corner of intersection (and collision point)
         * C=>I (r) = {nx, ny} = radius and intersection normal
         * S=>C = cornerdist
         * S=>I = intersectionDistance
         * S=>E = lineLength
         * <S = innerAngle
         * <I = angle1
         * <C = angle2
         */

        double inverseRadius = 1.0 / radius;
        double lineLength = Math.sqrt( dx * dx + dy * dy );
        double cornerdx = cornerX - start.x;
        double cornerdy = cornerY - start.y;
        double cornerDistance = Math.sqrt( cornerdx * cornerdx + cornerdy * cornerdy );
        double innerAngle = Math.acos( (cornerdx * dx + cornerdy * dy) / (lineLength * cornerDistance) );
        
        // If the circle is too close, no intersection.
        if (cornerDistance < radius)
        {
           return null;
        }
        
        // If inner angle is zero, it's going to hit the corner straight on.
        if (innerAngle == 0.0f)
        {
           float time = (float)((cornerDistance - radius) / lineLength);
           
           // If time is outside the boundaries, return null. This algorithm can
           // return a negative time which indicates a previous intersection, and
           // can also return a time > 1.0f which can predict a corner intersection.
           if (time > 1.0f || time < 0.0f)
           {
               return null;
           }
           
           float ix = time * dx + start.x;
           float iy = time * dy + start.y;
           float nx = (float)(cornerdx / cornerDistance);
           float ny = (float)(cornerdy / cornerDistance);
           
           return new Intersection( ix, iy, time, nx, ny, cornerX, cornerY );
        }
        
        double innerAngleSin = Math.sin( innerAngle );
        double angle1Sin = innerAngleSin * cornerDistance * inverseRadius;

        // The angle is too large, there cannot be an intersection
        if (Math.abs( angle1Sin ) > 1.0f)
        {
            return null;
        }

        double angle1 = Math.PI - Math.asin( angle1Sin );
        double angle2 = Math.PI - innerAngle - angle1;
        double intersectionDistance = radius * Math.sin( angle2 ) / innerAngleSin;

        // Solve for time
        float time = (float)(intersectionDistance / lineLength);

        // If time is outside the boundaries, return null. This algorithm can
        // return a negative time which indicates a previous intersection, and
        // can also return a time > 1.0f which can predict a corner intersection.
        if (time > 1.0f || time < 0.0f)
        {
            return null;
        }

        // Solve the intersection and normal
        float ix = time * dx + start.x;
        float iy = time * dy + start.y;
        float nx = (float)((ix - cornerX) * inverseRadius);
        float ny = (float)((iy - cornerY) * inverseRadius);

        return new Intersection( ix, iy, time, nx, ny, cornerX, cornerY );
    }

    public void mousePressed( MouseEvent e )
    {
       Vector2 mouse = new Vector2(e.getX(), e.getY());
       
        if (mouse.distance( start ) <= pointRadius)
        {
            dragging = DraggingState.START;
        }
        else if (mouse.distance( end ) <= pointRadius)
        {
            dragging = DraggingState.END;
        }
        else if (mouse.distance( radiusPoint ) <= pointRadius)
        {
            dragging = DraggingState.RADIUS;
        }
        else
        {
           dragging = DraggingState.NONE;
        }
    }

    public void mouseReleased( MouseEvent e )
    {
       dragging = DraggingState.NONE;
    }

    public void mouseDragged( MouseEvent e )
    {
        Vector2 mouse = new Vector2(e.getX(), e.getY());

        switch (dragging)
        {
            case END:
                end.set( mouse );
                break;
            case RADIUS:
                radiusPoint.set( mouse );
                radius = radiusPoint.distance( start );
                break;
            case START:
                start.set( mouse );
                radiusPoint.set( mouse );
                radiusPoint.y -= radius;
                break;
            case NONE:
                break;
        }

        repaint();
    }

    // Unused Mouse Listener Methods
    public void mouseMoved( MouseEvent e ) {}
    public void mouseClicked( MouseEvent e ) {}
    public void mouseEntered( MouseEvent e ) {}
    public void mouseExited( MouseEvent e ) {}

    public class Vector2
    {
        public float x;
        public float y;
        public Vector2()
        {
            this(0, 0);
        }
        public Vector2(float x, float y)
        {
            this.x = (int)x;
            this.y = (int)y;
        }
        public float distance(Vector2 other)
        {
           float dx = other.x - x;
           float dy = other.y - y;
           
            return (float)Math.sqrt(dx * dx + dy * dy);
        }
        public void set(Vector2 other)
        {
            this.x = other.x;
            this.y = other.y;
        }
    }

    public class Bounds
    {
        public float left;
        public float top;
        public float right;
        public float bottom;
        public Bounds()
        {
            this(0, 0, 0, 0);
        }
        public Bounds(float left, float top, float right, float bottom)
        {
            this.left = left;
            this.top = top;
            this.right = right;
            this.bottom = bottom;
        }
        public float getWidth()
        {
            return right - left;
        }
        public float getHeight()
        {
            return bottom - top;
        }
    }

}