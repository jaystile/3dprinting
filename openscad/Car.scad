$fa = 1;
$fs = 0.4;
wheel_radius = 10;
wheel_width=8;
wheel_turn = 0;
body_roll = -wheel_turn/3;
body_width = 18;
body_length = 60;
base_height = 10;
top_height = 10;
top_length = 30;
top_x_shift = 5;
track = 30;
// Car body base
rotate ([body_roll,0,0]) {
    resize([body_length,body_width,base_height])
    sphere(20);
    // Car body top
    translate([top_x_shift,0,base_height/2 - 0.001])
        resize([top_length,body_width,top_height]) 
        sphere(20);
        
}
// Front left wheel
translate([-20,-track/2,0])
    rotate([0,0,wheel_turn])
    resize([wheel_radius*2,wheel_width,wheel_radius*2])       
    sphere(r=wheel_radius);
// Front right wheel
translate([-20,track/2,0])
    rotate([0,0,wheel_turn])
    resize([wheel_radius*2,wheel_width,wheel_radius*2])       
    sphere(r=wheel_radius);
// Rear left wheel
translate([20,-track/2,0])
    rotate([0,0,0])
    resize([wheel_radius*2,wheel_width,wheel_radius*2])       
    sphere(r=wheel_radius);
// Rear right wheel
translate([20,track/2,0])
    rotate([0,0,0])
    resize([wheel_radius*2,wheel_width,wheel_radius*2])       
    sphere(r=wheel_radius);
// Front axle
translate([-20,0,0])
    rotate([90,0,0])
    cylinder(h=track,r=2,center=true);
// Rear axle
translate([20,0,0])
    rotate([90,0,0])
    cylinder(h=track,r=2,center=true);
