$fa = 1;
$fs = 0.4;
merge_offset=0.001;

// clutch grabbing strength
b_clutch_strong=0.1+merge_offset;
b_clutch_weak=0.2+merge_offset;

//// AAA - battery model
//b_radius=5+b_clutch_weak;
//b_diameter=2*b_radius;
//b_height=43;
//b_pole_radius=3.5/2;
//b_pole_height=1;

// AA- battery model
b_radius=7+b_clutch_weak;
b_diameter=2*b_radius;
b_height=39;
b_pole_radius=2.5;
b_pole_height=1;

// battery bed
bed_height=8;

// closest packing https://en.wikipedia.org/wiki/Circle_packing
//  The space saved with hexagonal closest packing can be calculated 
//  with 30,60,90 angle triangle relationships. When packing cells 
//  this is the spaced saved between the rows.
row_offset_hex=b_radius*sqrt(3);

// battery bed
border_width=3;
num_rows=2;
num_cols=6;

// A model of a AAA battery
module battery() {
    cylinder(h=b_height,r=b_radius);
    translate([0,0,b_height - merge_offset]) {
     cylinder(h=b_pole_height,r=b_pole_radius);
    }    
}
//battery();


// batteries configured in a grid with rows and columns
//  This model is subtracted from the bed.
module battery_grid() {
    offsetx=b_radius;
    offsety=b_radius;
    for(row=[0:num_rows-1]) {
        for(col=[0:num_cols-1]) {
            translate([offsetx+b_diameter*col,offsety+b_diameter*row,0])
                battery();
        }
    }
}
//battery_grid();


// Module that created a rectangular grid to hold batteries
module battery_bed_grid() {
    difference() {
        cube([border_width+b_diameter*num_cols+.5,border_width+b_diameter*num_rows,bed_height]);
        translate([.5*border_width,.5*border_width,1]) {
          battery_grid();
        }
    }

}
//battery_bed_grid();


// batteries configured in a hex grid with rows and columns
//  This model is subtracted from the bed._radius
module battery_hex() {
    offsetx=b_radius;
    offsety=b_radius;
    offsetxodd=offsetx+b_radius; // the odd rows, get offet 1 radius
    row_delta=row_offset_hex;      // increment the starting point for each row
    col_delta=b_diameter;        // increment the starting point for each col

    for(row=[0:num_rows-1]) {
        for(col=[0:num_cols-1]) {
            if(row % 2 == 0) { // even row
                translate([offsetx+col_delta*col,offsety+row_delta*row,0])
                    battery();
            }
            else {
                translate([offsetxodd+col_delta*col,offsety+row_delta*row,0])
                    battery();                   
            }
        }
    }
}
//battery_hex();



module battery_bed_hex() {
    hex_length_x=border_width + b_diameter*num_cols + b_radius;
    hex_saved_space = b_diameter - row_offset_hex;
    hex_width_y=border_width + b_diameter*num_rows - (hex_saved_space)*(num_rows-1);
    difference() {
        cube([hex_length_x,hex_width_y,bed_height]);
        translate([.5*border_width,.5*border_width,1]) {
          battery_hex();
        }
    }
}
battery_bed_hex();

/*
module battery_top_hex() {
    hex_length_x=border_width + b_diameter*num_cols + b_radius;
    hex_saved_space = b_diameter - row_offset_hex;
    hex_width_y=border_width + b_diameter*num_rows - (hex_saved_space)*(num_rows-1);
    difference() {
        cube([hex_length_x,hex_width_y,6]);
        translate([.5*border_width,.5*border_width,1]) {
          battery_hex();
        }
    }
}
*/
