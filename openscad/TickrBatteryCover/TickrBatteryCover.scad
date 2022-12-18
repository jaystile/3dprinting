$fa = 1;
$fs = 0.4;
merge_offset=0.001;

module disk_body() {
    disk_diameter=25;
    disk_height=2;
    cylinder(h=disk_height,d=disk_diameter);
}


module inner_pins() {
    
    module pin_cylinder() { 
        cylinder(h=3,d=22.75);
    }
    
    module pin_cylinder_inner_cutout() { 
        // removes the interior of the cylinder to make a ring
        cylinder(h=3+merge_offset,d=20.75);
    }
    
    module cut_arc() {
        // Removes a portion of the ring to make a pin
        rotate_extrude(angle = 90, convexity = 10)
        translate([20.75/2-2*merge_offset, 0, 0])
        square([1+4*merge_offset,3+merge_offset]);        
    }
    
    module cut_pin() {
        // removes a chunk from the pin so it mates with the monitor
        rotate_extrude(angle = -23, convexity = 10)
        translate([21.75/2+merge_offset, 0, 0])
        square([1.5+merge_offset,1.5+merge_offset]);        
    }    
    
    difference() {
        pin_cylinder();
        pin_cylinder_inner_cutout();
        cut_arc();
        rotate([0,0, 120]) cut_arc();
        rotate([0,0, 240]) cut_arc();
        rotate([0,0, merge_offset]) cut_pin();
        rotate([0,0, 120 + merge_offset]) cut_pin();
        rotate([0,0, 240 + merge_offset]) cut_pin();
    }

}

module coin_slot() {
    // modeled on a quarter and used to open and close the cover.
    disk_diameter=24;
    disk_height=1.6;
    translate ([0,0,-disk_diameter/2 + 1.5 ])
      rotate([0, 90, 0]) 
        cylinder(h=disk_height,d=disk_diameter,center = true);
}


difference() {
  disk_body();
  coin_slot();
}
translate([0,0,2-merge_offset]) inner_pins();



