$fa = 1;
$fs = 0.4;
merge_offset=0.001;

// Use right triangle geometry to figure out the minimum
//  radius of a 'ngon' (hexagon, pentagon, etc), a n-sided polygon inside a circle
function ngon_min_radius(radius,sides) 
  = radius*cos(180/sides); 
function ngon_side_length(radius,sides) 
  = radius;

module aaa_battery() {
    AAA_radius=5;
    AAA_height=43;
    AAA_pole_radius=3.5/2;
    AAA_pole_height=1;
    cylinder(h=AAA_height,r=AAA_radius);
    translate([0,0,AAA_height - merge_offset]) {
     cylinder(h=AAA_pole_height,r=AAA_pole_radius);
    }    
}
// aaa_battery();

module aaa_cell_interior(height=15) {
   
    // bottom hole
    translate([0,0,-(merge_offset)])
        cylinder(h=15,r=2);
    
    // bottom clutch
    translate([0,0,3])
      resize([10.5,10.5,3])
        sphere(2);
    
    // tube
    translate([0,0,3])
        cylinder(h=height-3+merge_offset, d1=10.5, d2=10.6);

}
//aaa_cell_interior();
    
module aaa_cell(radius=7.5,height=15) {
    difference() {
        cylinder(h=height,r=radius,$fn=6);
        aaa_cell_interior();
    }
}
//aaa_cell();

/*
This is a longer comment.
*/
module honeycomb(radius=7.5,sides=6) {
    
    cell_radius_min=ngon_min_radius(radius,sides);
    cell_radius_max=radius;
    cell_wall_offset=( (cell_radius_max - cell_radius_min) * .5);
    
    function center_y(col, row) =
        ( col % 2 ? 0 : cell_radius_min )
       +( 2 * cell_radius_min * row )
       -( cell_wall_offset * row );    
    
    function center_x(col, row) = 
        (.5*radius)*col
       +( cell_radius_max * col)
       -( cell_wall_offset * col );
    
    for (xcol=[0:3]) {
        for (yrow=[0:2]) {
            translate([center_x(xcol,yrow),center_y(xcol,yrow),0])
              aaa_cell();            
        }
    }
}
honeycomb();
