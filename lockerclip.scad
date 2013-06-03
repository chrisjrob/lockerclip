// lockerclip.scad
// 
// Copyright (C) 2013 Christopher Roberts

// Base parameters
width           = 9;
length          = 32.3;
thickness       = 2.2;

// Clip parameters
clip_length     = 9;
clip_diameter   = 5;
clip_thickness  = 2.85;

// General parameters
roundedness     = 3;
precision       = 100;

// Screw holes
hole_diameter   = 3;
cntrsnk_diameter = 5;
cntrsnk_height  = 1.5; // Must be less than thickness


module lockerclip() {

    difference() {

        // Things that exist
        union() {
            base();
            translate( v = [0, 0, thickness] ) {
                clip();
            }

        }

        // Things to be cut out
        union() {

        }
    }

}

module clip() {

    difference() {

        // Things that exist
        union() {
            translate( v = [ -width/2, -clip_thickness/2, 0] ) {
                cube( size = [ width, clip_thickness, clip_length - clip_diameter/2 ] );
            }
            translate( v = [ -width/2, 0, (clip_thickness + clip_length - clip_diameter)] ) {
                rotate( a = [0, 90, 0] ) {
                    cylinder( r = clip_diameter/2, h = width, $fn = precision );
                }
            }
            // Extra block to support base
            translate( v = [ -width/2, -clip_thickness * 1.5, 0] ) {
                cube( size = [ width, clip_thickness * 3, thickness ] );
            }
        }

        // Things that don't exist
        union() {
            for (y = [ -clip_thickness * 1.5, clip_thickness * 1.5] ) {
                translate( v = [ -width/2 -0.1, y, clip_thickness ] ) {
                    rotate( a = [0, 90, 0] ) {
                        cylinder( r = clip_thickness, h = width + 0.2, $fn = precision );
                    }
                }
            }

        }
    
    }

}

module base() {

    difference() {

        // Things that exist
        union() {
            minkowski() {
                // Base
                translate( v = [ -(width - roundedness)/2, -(length - roundedness)/2, 0] ) {
                    cube( size = [ width - roundedness, length - roundedness, thickness - 1 ] );
                }
                cylinder( r = roundedness/2, h = 1, $fn = precision, center = false );
            }

        }

        // Things that don't exist
        union() {
            // Screw holes
            for (y = [(length * -0.75)/2, (length * 0.75)/2] ) {
                translate( v = [ 0, y, -0.1] ) {
                    cylinder( r = hole_diameter/2, h = thickness +0.2, $fn = precision );
                    translate( v = [0, 0, thickness + 0.1 - cntrsnk_height] ) {
                        cylinder( r1 = hole_diameter/2, r2 = cntrsnk_diameter/2, h = cntrsnk_height +0.1, $fn = precision );
                    }
                }
            }

        }
    
    }

}

lockerclip();

// -------------------------------------------------------------------------------------------
// Commands
// -------------------------------------------------------------------------------------------

// http://en.wikibooks.org/wiki/OpenSCAD_User_Manual

// primitives
// cube(size = [1,2,3], center = true);
// sphere( r = 10, $fn=100 );
// circle( r = 10 );
// cylinder( h = 10, r = 20, $fs = 6, center = true );
// cylinder( h = 10, r1 = 10, r2 = 20, $fs = 6, center = false );
// polyhedron(points = [ [x, y, z], ... ], triangles = [ [p1, p2, p3..], ... ], convexity = N);
// polygon(points = [ [x, y], ... ], paths = [ [p1, p2, p3..], ... ], convexity = N);

// transormations
// scale(v = [x, y, z]) { ... }
// rotate(a=[0,180,0]) { ... }
// translate(v = [x, y, z]) { ... }
// mirror([ 0, 1, 0 ]) { ... }

// rounded box by combining a cube and single cylinder
// $fn=50;
// minkowski() {
//   cube([10,10,1]);
//   cylinder(r=2,h=1);
// }

// hull() {
//   translate([15,10,0]) circle(10);
//   circle(10);
// }

// linear_extrude(height=1, convexity = 1) import("tridentlogo.dxf");
// deprecated - dxf_linear_extrude(file="tridentlogo.dxf", height = 1, center = false, convexity = 10);
// deprecated - import_dxf(file="design.dxf", layer="layername", origin = [100,100], scale = 0.5);
// linear_extrude(height = 10, center = true, convexity = 10, twist = 0, $fn = 100)
// rotate_extrude(convexity = 10, $fn = 100)
// import_stl("example012.stl", convexity = 5);

// for (z = [-1, 1] ) { ... } // two iterations, z = -1, z = 1
// for (z = [ 0 : 5 ] ) { ... } // range of interations step 1
// for (z = [ 0 : 2 : 5 ] ) { ... } // range of interations step 2

// for (i = [ [ 0, 0, 0 ], [...] ] ) { ... } // range of rotations or vectors
// usage say rotate($i) or translate($i)
// if ( x > y ) { ... } else { ... }
// assign (angle = i*360/20, distance = i*10, r = i*2)

// text http://www.thingiverse.com/thing:25036
// inkscape / select all items
// objects to path
// select the object to export
// extensions / generate from path / paths to openscad

