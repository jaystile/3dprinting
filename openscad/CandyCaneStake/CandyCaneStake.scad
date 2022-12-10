$fa = 1;
$fs = 0.4;
merge_offset=0.001;

// post_insert
post_radius=7;
post_diameter=2*post_radius;
post_height=50;
module post() {
    cylinder(h=post_height,r=post_radius);
}
//post();


//post_cut
cut_post_radius=4;
cut_post_height=post_height+merge_offset;
module cut_post() {
    // cuts the notches out of the post
    cylinder(h=cut_post_height,r=cut_post_radius);
}
//cut_post();


// final post
module final_post(){
    // The completed post with cutouts
    difference() {
      post();
      translate([0,cut_post_radius+2,0]) { cut_post(); };
      translate([0,-(cut_post_radius+2),0]) { cut_post(); };
    }
}
//final_post();



stake_radius=12;
stake_diameter=2*stake_radius;
stake_height=105;
module stake() {
    cylinder(h=stake_height,d1=2,d2=stake_diameter);
}
//stake();

cut_stake_x=stake_radius;
cut_stake_y=stake_radius;
cut_stake_z=stake_height-3;
module cut_stake() {
    cube(size = [cut_stake_x,cut_stake_y,cut_stake_z]);
}


// final_stake

module final_stake() {
    pad=1;
    difference() {
      stake();
      translate([pad,pad,0]) { cut_stake(); };
      translate([-(cut_stake_x+pad),pad,0]) { cut_stake(); };
      translate([-(cut_stake_x+pad),-(cut_stake_y+pad),0]) { cut_stake(); };
      translate([pad,-(cut_stake_y+pad),0]) { cut_stake(); };
    }
}
//final_stake();



final_post();
translate([0,0,-(stake_height-merge_offset)]) { final_stake(); }

