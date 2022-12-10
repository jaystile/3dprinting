$fa = 1;
$fs = 0.4;
merge_offset=0.001;

// post_insert
post_insert_radius=2.5;
post_insert_diameter=2*post_insert_radius;
post_insert_height=15;

// The post_insert that gets inserted into the tube
module post_insert() {
    cylinder(h=post_insert_height,r=post_insert_radius);
}
//post_insert();

star_stem_radius=9;
star_stem_diameter=2*star_stem_radius;
star_stem_height=30;
// The star stem is padded to be subtracted from the receiver
module star_stem() {
    translate([0,0,-1]) {
     cylinder(h=star_stem_height+2,r=star_stem_radius);
    }    
    
}
//star_stem();


star_stem_receiver_radius=10;
star_stem_receiver_diameter=2*star_stem_receiver_radius;
star_stem_receiver_height=30;
module star_stem_receiver() {
    difference() {
        cylinder(h=star_stem_receiver_height,r=star_stem_receiver_radius);
        star_stem();
    }
}
// star_stem_receiver();


light_stop_radius=11;
light_stop_diameter=2*light_stop_radius;
light_stop_height=4;
// The star stem is padded to be subtracted from the receiver
module light_stop() {
  cylinder(h=light_stop_height,r=light_stop_radius);
}
//light_stop();


light_stop();
translate([0,0,light_stop_height-merge_offset]) { star_stem_receiver(); }
translate([0,0,-post_insert_height-merge_offset]) { post_insert(); }



