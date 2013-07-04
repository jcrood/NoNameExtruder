
include <functions.scad>

// Hotend
Hotend_d1 = 12.5;
Hotend_d2 = 16.2;
Hotend_h1 = 4.45; // to be modified a bit, if necessary to allow better fit with the hotend groove
Hotend_h2 = 5.2;
Hotend_tr = 11; // hotend translation along the guide made during mounting

// filament Hole offset
H_offset = 6.5;

// Base plate
B_height = 7;
B_width = 63.5;
B_depth = 42;

groovemount_thickness = 12;

module hotend() {
    difference() {
    union() {
        translate([0,0,B_height-Hotend_h1-40]) cylinder(r=Hotend_d2/2,h=40,$fn=100);
        translate([0,0,B_height-Hotend_h1]) cylinder(r=Hotend_d1/2,h=Hotend_h1,$fn=100);
        translate([0,0,B_height]) cylinder(r=Hotend_d2/2,h=5,$fn=100);        
    }
    translate([0,0,-40]) cylinder(r=2, h=80);
    }
}




module groovemount() {
    difference() {
        groovemount_body();
        groovemount_holes();
    }
}

module groovemount_body() {
    // body
    union(){
        translate([0,0,groovemount_thickness/2])
            cube_fillet([24,26,groovemount_thickness], vertical=[0,0,0,0], bottom=[0,2,0,2], center=true);
        difference() {
            translate([-12,-14,-1.2]) cube([24,12.5,4]);
            // screwanglethingy
            translate([-13,-4.6,-7]) rotate([40,0,0]) cube([26,9,5]);
            
        }
    }
}

module groovemount_holes() {
    // small section
    translate([0,0,-0.5]) cylinder(r=Hotend_d1/2, h=Hotend_h1+1, $fn=72);
    //translate([0,-4,-0.5]) #cylinder(r=Hotend_d1/2, h=Hotend_h1+1, $fn=72);
    translate([0,-Hotend_d1/2,(Hotend_h1+1)/2 - 0.5]) cube([Hotend_d1,Hotend_d1+2,Hotend_h1+1], center=true);

    // wide section
    translate([0, 0, Hotend_h1]) cylinder(r=Hotend_d2/2, h=Hotend_h2, $fn=72);
    translate([0, -4, Hotend_h1]) cylinder(r=Hotend_d2/2, h=Hotend_h2, $fn=72);
    translate([0, -Hotend_d2/2 -4, Hotend_h1 + Hotend_h2/2]) cube([Hotend_d2,Hotend_d2,Hotend_h2], center=true);

    // clearance rim
    translate([0, 0, Hotend_h1 + Hotend_h2 -0.5]) cylinder(r=Hotend_d2/2+0.5, h=0.5, $fn=72);
    translate([0, -Hotend_d2/2, Hotend_h1 + Hotend_h2-0.25]) cube([Hotend_d2+1,Hotend_d2,0.5], center=true);

    translate([0, -Hotend_d2/2 -4, -3]) cube([Hotend_d2,Hotend_d2,6], center=true);

    // screw hole (made too tigh, so needs drilling)
    translate([0,-Hotend_d1/2-m3_diameter/2 + 0.1, Hotend_h1 - m3_diameter/2 - 0.3]) rotate([0,90,0]) cylinder(r=m3_diameter/2 - 0.2, h=50, center=true, $fn=36);


    cylinder(r=2, h=100, center=true, $fn=16);

}
