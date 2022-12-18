$fa = 1;
$fs = 0.4;
merge_offset=0.001;

module disk_body() {
    cylinder(h=2.5,d=25);
}


module inner_pins() {
    
    module pin_cylinder() { 
        cylinder(h=3,d=22.75);
    }
    
    module pin_cylinder_inner_cutout() { 
        // removes the interior of the cylinder to make a ring
        color("green") cylinder(h=3+merge_offset,d=20.25);
    }
    
    module cut_arc() {
        // Removes a portion of the ring to make a pin
        color("red") rotate_extrude(angle = 90, convexity = 10)
        translate([20.25/2-2*merge_offset, 0, 0])
        square([1.5+4*merge_offset,3+merge_offset]);        
    }
    
    module cut_pin() {
        // removes a chunk from the pin so it mates with the monitor
        rotate_extrude(angle = -22, convexity = 10)
        translate([21.75/2+merge_offset, 0, 0])
        square([1.5+merge_offset,1.9+merge_offset]);        
    }    
    
    
    difference() {
        color("blue") pin_cylinder();
        pin_cylinder_inner_cutout();
        cut_arc();
        rotate([0,0, 120]) cut_arc();
        rotate([0,0, 240]) cut_arc();
        rotate([0,0, merge_offset]) cut_pin();
        rotate([0,0, 120 + merge_offset]) cut_pin();
        rotate([0,0, 240 + merge_offset]) cut_pin();
    }
    
}

module pressure_point() {
    disk_diameter=5;
    disk_height=2.7;
    cylinder(h=2.8,d=5);    
}

module coin_slot() {
    // modeled on a quarter and used to open and close the cover.
    disk_diameter=24;
    disk_height=1.85;
    translate ([0,0,-disk_diameter/2 + 2.3 ])
      rotate([0, 90, 0]) 
        cylinder(h=disk_height,d=disk_diameter,center = true);
}


difference() {
    union() {
        pressure_point();
        disk_body();
    }  
  coin_slot();
}
translate([0,0,2.5-merge_offset]) inner_pins();




