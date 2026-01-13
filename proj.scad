include <BOSL2/std.scad>
include <BOSL2/threading.scad>

$fa = $preview ? 10 : 1;
tex = texture("diamonds");

WALL_THICKNESS = 3;

INNER_DIMENSION = 50;
INNER_RADIUS = INNER_DIMENSION / 2;
OUTER_RADIUS = INNER_RADIUS + WALL_THICKNESS;
OUTER_DIMENSION = OUTER_RADIUS * 2;

THREADED_SECTION = 5;
CONTENT_HEIGHT = 5 + 7.5 + 10;
INNER_HEIGHT= CONTENT_HEIGHT + 1;
LID_HEIGHT = WALL_THICKNESS;
THREAD_PITCH = 2.0;
THREAD_DEPTH = WALL_THICKNESS/3;
CHAMFER_SIZE = 0.5;
SLOP = 0.2;

// Bottom
ROT_Y = 10;
projection(cut=true)
rotate([90, ROT_Y, 0]) {
	difference() {
		union() {
			difference()  {
				linear_sweep(
					[circle(OUTER_RADIUS)],
					texture=tex, h=INNER_HEIGHT + WALL_THICKNESS - THREADED_SECTION,
					tex_size=[2,2], style="concave",
					tex_depth=0.1
					);

				up(INNER_HEIGHT + WALL_THICKNESS - THREADED_SECTION) {
					chamfer_cylinder_mask(
						OUTER_RADIUS,
						CHAMFER_SIZE
						);
				}
			}
			up(INNER_HEIGHT) {
				threaded_rod(
					d=INNER_DIMENSION + WALL_THICKNESS * 3.5 / 3,
					l=THREADED_SECTION,
					pitch=THREAD_PITCH,
					starts=2,
					blunt_start=true,
					bevel=false,
					$slop=SLOP
					);
			}
		}

		up(WALL_THICKNESS) {
			cylinder(INNER_HEIGHT+1, INNER_RADIUS, INNER_RADIUS);
		};

		chamfer_cylinder_mask(
			OUTER_RADIUS,
			CHAMFER_SIZE,
			orient=DOWN
			);

	};
};


 projection(cut=true)
rotate([90, ROT_Y, 0]) {
	up(26.5) {
//	rotate([0, 180, 0]) {
		union() {
			difference() {
				linear_sweep(
					[circle(OUTER_RADIUS)],
					texture=tex, h=LID_HEIGHT,
					tex_size=[2,2], style="concave",
					tex_depth=0.1
					);

				up(LID_HEIGHT){
					chamfer_cylinder_mask(
						OUTER_RADIUS,
						CHAMFER_SIZE,
						orient=UP
						);
				}
			}

			down(THREADED_SECTION) {
				difference() {
					intersection() {
						linear_sweep(
							[circle(OUTER_RADIUS)],
							texture=tex, h=THREADED_SECTION,
							tex_size=[2,2], style="concave",
							tex_depth=0.1
							);

						up(THREADED_SECTION/2) {
							threaded_nut(
								nutwidth=OUTER_DIMENSION + 10,
								id=INNER_DIMENSION + WALL_THICKNESS * 3.5 / 3,
								h=THREADED_SECTION,
								pitch=THREAD_PITCH,
								bevel=false,
								starts=2,
								blunt_start=false,
								$slop=SLOP,
                            spin=120 
								);
						};
					};

					down(0) {
						chamfer_cylinder_mask(
							OUTER_RADIUS,
							CHAMFER_SIZE,
							orient=DOWN);
					}
				}
			};
		};
	};
}
