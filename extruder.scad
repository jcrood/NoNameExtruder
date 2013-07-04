
include <configuration.scad>
include <hotend.scad>
include <fan.scad>
include <drivegear.scad>
include <functions.scad>


module bearing()
{
    //8x22x7
    difference() {
        cylinder(r=22, h=7, center=true);
        cylinder(r=8, h=1, center=true);
    }
}


module nuttrap() {
    rotate([90, 0, 0]) cylinder(h =5, r = m3_nut_diameter_horizontal/2, $fn = 6);
}

module fanmount() {
    difference() {
        union() {
            //translate([0,0,1]) cube_fillet([41,4,10], vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,2,0,2], center=true);
            translate([-15 -0.75,0,1]) cube_fillet([11 + 1.5, 4, 10], vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,2,0,0], center=true);
            translate([15 -0.25,0,1]) cube_fillet([11 - 1.5, 4, 10], vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,0,0,2], center=true);
            
        }
        translate([-16.0 -1.5,0,0]) rotate([90,0,0]) cylinder(r=2,h=50, center=true);
        translate([16.0 -1.5,0,0]) rotate([90,0,0]) cylinder(r=2,h=50, center=true);                
    }
}


module carriagemount() {
    difference() {
        carriagemount_body();
        carriagemount_holes();
    }
}

module carriagemount_body() {
    translate([-0, 0, 0.5]) cube_fillet([45,26,9], vertical=[0,0,0,0], top=[0,0,0,0], bottom=[0,2,0,2], center=true);
    // %translate([-15+3,0,0]) rotate([90,0,0]) cylinder(r=1.5,h=50, center=true);
    // %translate([15+3,0,0]) rotate([90,0,0]) cylinder(r=1.5,h=50, center=true);        
}

module carriagemount_holes() {
    translate([-15 - 1.5, 5.2, 0.5]) rotate([90,0,0]) cylinder(r=2,h=50, center=false);
    translate([15 - 1.5, 5.2, 0.5]) rotate([90,0,0]) cylinder(r=2,h=50, center=false);    
    translate([-15 - 1.5, 6, 0.5]) rotate([-90,0,0]) cylinder(r=3.3,h=50, center=false);
    translate([15 - 1.5, 6, 0.5]) rotate([-90,0,0]) cylinder(r=3.3,h=50, center=false);    
}

module idler() {
    difference() {
        union() {
            // handle
            translate([-3, 11, 0]) cube_fillet([10,14,19], vertical=[2,2,2,2], top=[0,0,2,0],bottom=[0,0,2,0],center=true, $fn=36);
            // body
            translate([-3, 0.5, 0]) cube_fillet([10,35,16], vertical=[2,2,2,4], center=true, $fn=36);
            // bearing bump
            //translate([1, 0, 0]) cube_fillet([10,11,16], vertical=[2,0,0,2], center=true, $fn=36);                
            translate([1, 0, 0]) cylinder(r=11/2,h=16,center=true, $fn=36);                
            translate([0.8 -2.5,-13,0]) cylinder(r=4.5, h=16, center=true, $fn=32);
        }
        translate([0.3,0,0]) {
            // bearing cutout
            cylinder(r=15/2, h=6, center=true);
            // bearing screw
            cylinder(r=2.5, h=40, center=true);
        }
        
        // tensioner cutout
        translate([0, 15 - 3.8, -4]) rotate([0, 90, 0]) cylinder(r=3.6/2, h=40, center = true, $fn=36);
        translate([0, 15 - 3.8, 4]) rotate([0, 90, 0]) cylinder(r=3.6/2, h=40, center = true, $fn=36);
        translate([-10, 15 + 5 -3.8, -4]) cube([30,10,3.6], center = true);
        translate([-10, 15 + 5 -3.8, 4]) cube([30,10,3.6], center = true);

        // swivel cutout
        translate([0, -13.2, 0]) cube([30,12,7], center = true);
        //translate([2, -18, 0]) cylinder(r=10,h=7,center=true);
        
        // nuthole
        //translate([0.8 -1.5,-13,motor_offset_y]) cylinder(r=3.3, h=50, center=true, $fn=6);
        
        // fastener bolt hole
        translate([0.8 -2.5,-13,motor_offset_y]) cylinder(r=1.8, h=40, center=true, $fn=32);
        
    }
    
    if (debugbits == 1) {        
        translate([0.3,0,0]) {
            %cylinder(r=13/2, h=5, center=true);
            %cylinder(r=2, h=40, center=true);
        }
    }
}

module swivelscrew(angle = 20)
{
    hull() {
        cylinder(r=3.6/2, h=30, center = false, $fn=36);
        rotate([angle, 0, 0]) cylinder(r=3.6/2, h=30, center = false, $fn=36);    
    }

    rotate([180, 0, 0]) hull() {
        rotate([0,0,30]) cylinder(r=3.3, h=30, center = false, $fn=6);
        rotate([angle, 0, 0]) rotate([0,0,30]) cylinder(r=3.3, h=30, center = false, $fn=6);    
    }    
}

module motor() {
    translate([0,0,-36]) cylinder(r=21,h=36);
	translate([0,0,-2.5]) cube([44,44,5], center = true);
	translate([18,18,-5]) cylinder(r=2, h=10);
	translate([18,-18,-5]) cylinder(r=2, h=10);
	translate([-18,18,-5]) cylinder(r=2, h=10);
	translate([-18,-18,-5]) cylinder(r=2, h=10);
	// drive
	translate([22 - (2.5+10), 0,-2]) cylinder(r=5, h=4);
	translate([22 - (2.5+10), 0,-2]) cylinder(r=2.5, h=17);
	
}

module motor_holes() {
	translate([18,18,0]) cylinder(r=2, h=30);
	translate([18,-18,0]) cylinder(r=2, h=30);
	translate([-18,18,0]) cylinder(r=2, h=30);
	translate([-18,-18,0]) cylinder(r=2, h=30);
	translate([18,18,6]) rotate([0,0,30]) cylinder(r=3.4, h=30, $fn=6);
	translate([18,-18,6]) rotate([0,0,30]) cylinder(r=3.4, h=30, $fn=6);
	translate([-18,18,6]) rotate([0,0,30]) cylinder(r=3.4, h=30, $fn=6);
	translate([-18,-18,6]) rotate([0,0,30]) cylinder(r=3.4, h=30, $fn=6);
}

module motormount() {
    
    if (debugbits == 1) {    
        %motor();
        %translate([22 - 12.5, 0, 3]) drivegear(upsidedown=0,hires=0);
    }
    
    // test filament
    //%translate([-motor_offset_x,0,motor_offset_y]) color([1,0,0,0.5]) rotate([90,0,0]) cylinder(r=1.5, h=100, center=true, $fn=16);
    
    difference() {
        // body
        union() {
            //translate([0,0,4]) cube([44,44,8], center=true);
            translate([-22.5,-29.65,0]) rotate([0,0,0]) cube_fillet([9,16.5,8], vertical=[2,2,2,2], center=false);
            translate([10.75,0,base_width/2]) cube_fillet([23.5,45,base_width], vertical=[2,0,0,0], center=true);
         
            // idler mount
            translate([-2.5,0,0]) {
                translate([-4,-12.85,motor_offset_y]) cylinder(r=4.5, h=6.5, center=true);
                translate([0,-12.85,motor_offset_y]) cube([9,9,6.5], center=true);
                translate([0.079,-15.20,motor_offset_y]) rotate([0,0,60]) cube([9,10,6.5], center=true);
            }            
        }

        // idler bolt
        translate([-5 -1.5,-13,motor_offset_y]) cylinder(r=1.8, h=40, center=true);
        
        motor_holes();
        
        // drivegear clearing
        translate([22 - 12.5, 0, -1]) cylinder(r=drive_gear_od/2+2, h=40);
        translate([22 - 12.5 - (drive_gear_od/2+2) , 0, 20-1]) cube([drive_gear_od+4, drive_gear_od+4, 40], center=true);
        //translate([22 - 12.5 - (drive_gear_od/2+3) , 18, 20-1]) cube([drive_gear_od+6, drive_gear_od+6, 40], center=true);
        //#translate([0, 0, -1]) cylinder(r=9, h=40);
        
        //cutout
        translate([-18.0, 5, -1]) cube([22,22,26]);

        //filamenthole
        translate([-motor_offset_x,0,motor_offset_y]) color([1,0,0,0.5]) rotate([90,0,0]) cylinder(r=2, h=100, center=true, $fn=36);

        // idler tension screws
        translate([13, 11.8, motor_offset_y]) {            
            rotate([0, -90, 0]) {
                translate([-4, 0, 0]) swivelscrew(angle=-20);
                translate([4, 0, 0]) swivelscrew(angle=-20);
            }
        }        
    }
    
    //idler
    //color("green") translate([-4.8, 0, motor_offset_y]) idler();
}


// combine all the bits
module body() {
    intersection() {
        difference() {
            union() {
                translate([motor_offset_x,0,11]) carriagemount_body();
                translate([-0.15,motor_offset_y-2, 4]) fanmount();
                groovemount_body();

                //motormount
                translate([motor_offset_x,motor_offset_y,Hotend_h1 + Hotend_h2 + 22 + 6])
                    rotate([90,0,0]) {
                       motormount();
                       // breakaway idlermount support
                       color("red") translate([-13,-18,0]) rotate([0,0,-13]) {
                           difference() {
                               cube([9,14,8.25]);
                               translate([1.5, 1.5, -0.4]) cube([8,11,8.25]);
                           }
                       }
                    }

            }
    
            translate([motor_offset_x +3,0,11]) 
                carriagemount_holes();
            groovemount_holes();
        }

        translate([-30,-base_width + motor_offset_y,-10])
            cube([60,base_width,100], center=false);

        //translate([-50, 0, 0]) fan();
    }
    
    
    if (debugbits == 1) {
        translate([-1.5,38,-13]) rotate([90,0,0]) %fan();
        translate([-1.5,30.25,-13]) rotate([90,0,0]) %funnel();
        //filament
        translate([0,0,30])color([1,0,0,0.5]) cylinder(r=1.5, h=100, center=true, $fn=36);
        translate([0,0,-2.4]) color("blue") %hotend();
    }
}


// test
//motormount();
/*
// support
translate([-12,-18,0]) rotate([0,0,-10]) {
    difference() {
        cube([8,12,7]);
        translate([1,1,-0.6]) cube([8,10,7]);
    }
}
*/

// Pick one of these
rotate([-90, 0, 0]) body();
//rotate([0,-90,0]) idler();
//funnel();

// EOF