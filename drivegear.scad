
drive_gear_offset = 7;
drive_gear_width = 11;
drive_gear_id = 5;
drive_gear_od = 12.7;


// 3.5 -> 11/2 = 6.5.... 11 - 3.5 = 7.5
module drivegear(upsidedown=0, hires=0){
    if (upsidedown==1) {
        translate([0,0,drive_gear_width]) rotate([180,0,0]) realDrivegear(hires);
    }
    else {
        realDrivegear(hires);        
    }
}

module realDrivegear(hires=0){
	//paso = filament_id/2+0.5;
  	translate([0, 0, drive_gear_width/2]) 
	difference() {
    	cylinder(r=drive_gear_od/2, h=drive_gear_width, center=true);
    	cylinder(r=drive_gear_id/2, h=drive_gear_width+1, center=true, $fn=12);

        if (hires == 1) {
    		translate([0, 0, 1.7]) {
    			for ( i = [0 : 0.2 : 6] ) {
    				rotate( i * 360 / 6, [0, 0, 1])
    	    			translate([0, drive_gear_od/2, 0])
    	    				sphere(r=1.5, $fn=10);
    			}
    		}
	    }
	    else {
	        translate([0, 0, 1.7]) difference(){
    	        cylinder(r=drive_gear_od+1/2,h=2.9,center=true);
    	        cylinder(r=drive_gear_od/2-1.5,h=4,center=true);	            
	        }
	    }
	}
}
