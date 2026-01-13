include <Round-Anything-1.0.4/polyround.scad>


include <BOSL2/std.scad>
include <BOSL2/screws.scad>
$slop=0.2;

translate([0, 30, 0]) nut("M6", shape="hex");
translate([20, 30, 0]) nut("M6", shape="hex");
translate([0, -30, 0]) screw("M6,38", "hex");
translate([20, -30, 0]) screw("M6,18", "hex");

THICKNESS = 20;
WALL_THICKNESS = 10;
ROUNDING = 1;
DEPTH = 37.5;
WIDTH = 29.5;
HOLE_DIAMETER = 6;

HANDLE_LENGTH = 100;
HANDLE_WIDTH = 150;
part2();
translate([-100, 0, 0]) part1();

module part2() {
	difference ()
	{
		union() {
			extrudeWithRadius(THICKNESS, ROUNDING, ROUNDING)
				union() {
				translate([0, -WALL_THICKNESS, 0]) ear();
				translate([0, WALL_THICKNESS , 0]) ear();

				translate([WALL_THICKNESS*1.5, 0, 0])resize([WALL_THICKNESS, WALL_THICKNESS*3])square(10, center=true);
				translate([WALL_THICKNESS*1.5 + HANDLE_LENGTH / 4, 0, 0])resize([HANDLE_LENGTH / 4, WALL_THICKNESS]) square(10, center=true);
				difference() {
					translate([WALL_THICKNESS*2,0,0]) rotate([0, 0, 45]) square(sqrt(9 * WALL_THICKNESS * WALL_THICKNESS / 2),center=true);
					translate([WALL_THICKNESS,0,0])square(WALL_THICKNESS, center=true);
				}
				translate([HANDLE_LENGTH/2,0,0])
					difference() {
					translate([HANDLE_LENGTH / 2 + HANDLE_LENGTH / 4 , 0, 0]) circle(HANDLE_WIDTH/2 + WALL_THICKNESS/2);
					translate([HANDLE_LENGTH / 2 + HANDLE_LENGTH / 4 , 0, 0]) circle(HANDLE_WIDTH/2 - WALL_THICKNESS/2);
					translate([HANDLE_WIDTH,0, 0]) square(HANDLE_WIDTH+WALL_THICKNESS, center=true);
				}

			};
			translate([0, -WALL_THICKNESS, THICKNESS/2]) hole(4, 2);
			translate([0, WALL_THICKNESS, THICKNESS/2]) hole(4, 2);
			difference () {
				translate([HANDLE_LENGTH+20, HANDLE_LENGTH/2 + WALL_THICKNESS * 3, THICKNESS/2]) rotate([90, 0,0]) extrudeWithRadius(HANDLE_WIDTH+WALL_THICKNESS , ROUNDING, ROUNDING) circle(d=THICKNESS);

				linear_extrude(THICKNESS*2, center=true)
					translate([HANDLE_LENGTH/2,0,0])
					difference() {
					translate([HANDLE_LENGTH / 2 + HANDLE_LENGTH / 4 , 0, 0]) circle(HANDLE_WIDTH/2 + WALL_THICKNESS);
					translate([HANDLE_LENGTH / 2 + HANDLE_LENGTH / 4 , 0, 0]) circle(HANDLE_WIDTH/2 + WALL_THICKNESS/2);
				};
			}

		}
		translate([0, 0, THICKNESS/2]) hole(3.5, 3);
		translate([0, WALL_THICKNESS, THICKNESS/2]) hole2();
		translate([0, -WALL_THICKNESS, THICKNESS/2]) hole2();

	}
}


module part1() {
	difference() {
		union () {
			extrudeWithRadius(THICKNESS, ROUNDING, ROUNDING)
				union (){

				difference() {
					hull() {
						circle(WIDTH / 2 + WALL_THICKNESS);
						translate([DEPTH - WIDTH, 0, 0]) circle(WIDTH / 2 + WALL_THICKNESS);
					}

					hull() {
						circle(WIDTH / 2);
						translate([DEPTH - WIDTH, 0, 0]) circle(WIDTH / 2);
					}
				}
				translate([-WIDTH - WALL_THICKNESS, 0, 0]) ear();
				translate([-WIDTH + 2, 0, 0]) square(WALL_THICKNESS,center=true);
				translate([DEPTH + WALL_THICKNESS , 0, 0]) ear();
				translate([DEPTH - 2, 0, 0]) square(WALL_THICKNESS,center=true);
			};
			translate([-WIDTH - WALL_THICKNESS, 0, THICKNESS/2]) hole(4, 2);
			translate([DEPTH + WALL_THICKNESS , 0, THICKNESS/2]) hole(4, 2);


		}
		translate([-WIDTH - WALL_THICKNESS, 0, THICKNESS/2]) hole2();
		translate([DEPTH + WALL_THICKNESS , 0, THICKNESS/2]) hole2();
	}
}

module ear() {
	resize([WALL_THICKNESS * 2, WALL_THICKNESS]) square(WALL_THICKNESS, center=true);
}

module hole(s, r) {
	rotate([90, 0, 0]) 	translate([0, 0, -THICKNESS / 4 - r]) extrudeWithRadius(WALL_THICKNESS + s, ROUNDING, ROUNDING)
		difference() {
		circle(d=HOLE_DIAMETER + s + r);
		circle(d=HOLE_DIAMETER + s);
	};
}

module hole2() {
	rotate([90, 0, 0]) 	translate([0, 0, -THICKNESS / 2 -2 ])linear_extrude(THICKNESS)

		circle(d=HOLE_DIAMETER );

}
