$fa = 1;
$fs = 1;
CHAMFER = 5;
THICKNESS = 2;
DEPTH = 40;

DRAWER_WIDTH = 335;
DRAWER_HEIGHT = 450;

COMPARTMENT_PADDING = 2;
COMPARTMENT_COUNT_X = 4; // left-to-right
COMPARTMENT_COUNT_Y = 6; // front-to-back

COMPARTMENT_SIZE_X = (DRAWER_WIDTH / COMPARTMENT_COUNT_X);
COMPARTMENT_SIZE_Y = (DRAWER_HEIGHT / COMPARTMENT_COUNT_Y);

PROFILE_WIDTH = CHAMFER*2 + COMPARTMENT_PADDING;

module compartment(w, h) {
	mirror([0, 1, 0])
		union() {

		linear_extrude(COMPARTMENT_SIZE_Y*h) profile();

// R
		translate([COMPARTMENT_SIZE_X*w - PROFILE_WIDTH, 0, 0])
			linear_extrude(COMPARTMENT_SIZE_Y*h) mirror([1,0,0]) translate([-PROFILE_WIDTH,0,0]) profile();


		mirror([0, 0, 1])rotate([0, 90, 0]) linear_extrude(COMPARTMENT_SIZE_X*w) profile();
		translate([0, 0, COMPARTMENT_SIZE_Y*h])rotate([0, 90, 0]) linear_extrude(COMPARTMENT_SIZE_X*w) profile();

		// base plate
		translate([PROFILE_WIDTH,  -THICKNESS/2, PROFILE_WIDTH]) linear_extrude(COMPARTMENT_SIZE_Y*h - PROFILE_WIDTH*2) square([COMPARTMENT_SIZE_X*w - PROFILE_WIDTH*2, 1], center=0);
	}
}

module drawer1()  {
	place_at(1,1) compartment(1,1);
	place_at(2,1) compartment(3,1);
	place_at(2,2) compartment(1,4);
	place_at(3,2) compartment(1,4);
	place_at(4,2) compartment(1,4);
	place_at(2,6) compartment(3,1);
	place_at(1,5) compartment(1,2);
	place_at(1,2) compartment(1,3);
}

module profile(){
	translate([CHAMFER*2+COMPARTMENT_PADDING,0,0])
	mirror([1,0,0])
		union() {
	translate([CHAMFER, (DEPTH-CHAMFER*2-THICKNESS)/2+CHAMFER+THICKNESS/2, 0])
		square([THICKNESS, DEPTH-CHAMFER*2-THICKNESS], center=true);

	difference() {
		square(CHAMFER+THICKNESS/2);
		translate([0, THICKNESS, 0]) rotate(45) square(CHAMFER*2);
		translate([sqrt(2*CHAMFER*CHAMFER)+THICKNESS, 0, 0]) rotate(45) 	square(CHAMFER*2, center=true);
	}

	translate([CHAMFER-THICKNESS/2, DEPTH-CHAMFER*2+THICKNESS*2, 0])
		difference() {
		square(CHAMFER+THICKNESS/2);
		translate([0, THICKNESS, 0]) rotate(45) square(CHAMFER*2);
		translate([sqrt(2*CHAMFER*CHAMFER)+THICKNESS, 0, 0]) rotate(45) 	square(CHAMFER*2, center=true);
	}

	translate([10+COMPARTMENT_PADDING/2, 39, 0])
		square([COMPARTMENT_PADDING, THICKNESS], center=true);
}
}


// }
// compartment(1, 4);
// // A compartment is a square section, with rounded internal corners
// // and straight external corners.
// module compartment(x_count, y_count) {
// 	w = x_count * COMPARTMENT_SIZE_X;
// 	h = y_count * COMPARTMENT_SIZE_Y;

// 	color("lightgrey")
// 		translate([w / 2, h / 2, 0]){
// 		// Extrude to give depth
// 		linear_extrude(height = DEPTH) {
// 			difference() {
// 				// Outer shape
// 				square([w, h], center = true);

// 				// Inner shape with rounded corners
// 				offset(r = CHAMFER) {
// 					square([w - 2 * CHAMFER - COMPARTMENT_PADDING, h - 2 * CHAMFER - COMPARTMENT_PADDING], center = true);
// 				}
// 			}
// 		}

// 		// Bottom face
// 		linear_extrude(height = 3) square([w, h], center = true);
// 	}
// }


module place_at(x, y) {
	translate([(x - 1) * COMPARTMENT_SIZE_X,  0, (y - 1) * COMPARTMENT_SIZE_Y])
		children();
}
