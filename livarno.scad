SIZE = 90;
HALF_SIZE = SIZE / 2;
HEIGHT = 23;
ROUNDING = 32.5;
UPPER_ROUNDING = 20;
OFFSET = 15;

HO = -17.9;
VO = -5;
PO = 27;

HOLE_OFFSET = HALF_SIZE - OFFSET;

intersection() {
	union() {
		difference (){
			import("RackMod1UBlank.stl",center=true);
			translate([-HOLE_OFFSET, -HOLE_OFFSET - VO, HO]) linear_extrude(1.5) circle(d=8.5);
			translate([HOLE_OFFSET, HOLE_OFFSET - VO, HO]) linear_extrude(1.5) circle(d=8.5);
			translate([HOLE_OFFSET, - HOLE_OFFSET - VO, HO]) linear_extrude(1.5) circle(d=8.5);
			translate([-HOLE_OFFSET, HOLE_OFFSET - VO, HO]) linear_extrude(1.5) circle(d=8.5);


		}
		translate([HALF_SIZE - PO - 1, -HALF_SIZE+OFFSET - VO, HO]) peg();
		translate([-HALF_SIZE + PO + 1, -HALF_SIZE + OFFSET - VO, HO]) peg();
	}
}

module peg() {
	color([1,0,0,1])
		union() {
		linear_extrude(4) circle(d=3.5);
		translate([0, 0, 4]) cylinder(h=1.5, d1=3.5, d2=7.5);
	}
}
