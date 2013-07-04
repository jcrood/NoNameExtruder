include <configuration.scad>
include <functions.scad>

module fan() {
  color([0.3,0.3,0.3]) {
    union() {
      difference() {
	cube([40,40,10], center=true);
	cylinder(r=19, h=15, center=true);
	for (x=[-16, 16]) {
	  for (y=[-16, 16]) {
	    translate([x, y, 0]) {
	      cylinder(r=1.75, h=15, center=true, $fn=10);
	    }
	  }
	}
      }
      cylinder(r=10, h=10, center=true);
      for (rot=[0 : 30 : 360]) {
	rotate([45,0,rot]) {
	  translate([0, -5, 0]) {
	    cube([18, 10, 1]);
	  }
	}
      }
      for (rot=[0 : 120 : 360]) {
	rotate([0,0,rot]) {
	  translate([0, -1, -5]) {
	    cube([20, 2, 1]);
	  }
	}
      }
    }
  }
}

module funnel() {
    difference() {
        union() {
            cube_fillet([41,41,2], vertical=[2,2,2,2], center=true, $fn=36);
            translate([-20.5,12.5,-1]) cube_fillet([41,8,20], vertical=[2,2,2,2], center=false, $fn=36);
            hull() {
                cylinder(r=41/2, h=4, center=false);
                translate([0,0,20]) cube_fillet([16,21,2],center=true);
            }
        }
        cylinder(r=38/2, h=4, center=true);

        hull() {
            cylinder(r=38/2, h=4, center=false);
            translate([0,0,20]) cube_fillet([13,18,2.1],center=true);
        }

        for (x=[-16, 16]) {
          for (y=[-16, 16]) {
            translate([x, y, 10]) {
              cylinder(r=1.75, h=35, center=true, $fn=10);
            }
          }
        }
    }
}


//funnel();
