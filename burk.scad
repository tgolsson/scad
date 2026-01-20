include <BOSL2/std.scad>
include <BOSL2/threading.scad>

$fa = $preview ? 10 : 1;
tex = texture("diamonds");

WALL_THICKNESS = 3;

INNER_DIMENSION = 50;
INNER_RADIUS = INNER_DIMENSION / 2;
OUTER_RADIUS = INNER_RADIUS + WALL_THICKNESS;
OUTER_DIMENSION = OUTER_RADIUS * 2;

THREADED_SECTION = 7.5;
CONTENT_HEIGHT = 5 + 7.5 + 10;
INNER_HEIGHT= CONTENT_HEIGHT + 1;
LID_HEIGHT = WALL_THICKNESS;
THREAD_PITCH = 1.5;
THREAD_DEPTH = WALL_THICKNESS/3;
CHAMFER_SIZE = 0.5;
SLOP = 0.2;
TEX_DEPTH = 0.15;
BOTTOM_CHAMFER = 1.5;
CHAMFER_ANGLE = 70;
LEAD_LENGTH = 1.5;
STARTS = 3;
TEX_SIZE= [2, 2];
// projection(cut=true)
//   rotate([90, 0,0])
//     container();

// projection(cut=true)
// rotate([90, 0,0])
// up(45)
// lid();

container();
left(75) rotate([180, 0, 0]) down(WALL_THICKNESS)
lid();



module container()	{
	difference() {
		union() {
			difference()  {
				linear_sweep(
					[circle(OUTER_RADIUS)],
					texture=tex, h=INNER_HEIGHT + WALL_THICKNESS - THREADED_SECTION,
					tex_size=TEX_SIZE, style="concave",
					tex_depth=TEX_DEPTH

					);

				up(INNER_HEIGHT + WALL_THICKNESS - THREADED_SECTION) {
					chamfer_cylinder_mask(
						OUTER_RADIUS,
						CHAMFER_SIZE,
						ang=CHAMFER_ANGLE
						);
				}
			}
			up(INNER_HEIGHT + WALL_THICKNESS - THREADED_SECTION / 2) {
				threaded_rod(
					d=INNER_DIMENSION + WALL_THICKNESS * 3.5 / 3,
					l=THREADED_SECTION,
					pitch=THREAD_PITCH,
					starts=STARTS,
					blunt_start=true,
					bevel=false,
					end_len2=LEAD_LENGTH,
					$slop=SLOP
					);
			}
		}

		up(WALL_THICKNESS) {
			cylinder(INNER_HEIGHT+1, INNER_RADIUS, INNER_RADIUS);
		};

		up(WALL_THICKNESS - BOTTOM_CHAMFER) {
			cylinder(h=BOTTOM_CHAMFER/2, r1=0, r2=INNER_RADIUS*3/4);
		}
		up(WALL_THICKNESS - BOTTOM_CHAMFER / 2) {
			cylinder(h=BOTTOM_CHAMFER/2, r1=INNER_RADIUS*3/4, r2=INNER_RADIUS);
		}

		chamfer_cylinder_mask(
			OUTER_RADIUS,
			CHAMFER_SIZE,
			orient=DOWN,
			ang=CHAMFER_ANGLE
			);
	}
}

module lid() {
	union() {
		difference() {
			linear_sweep(
				[circle(OUTER_RADIUS)],
				texture=tex, h=LID_HEIGHT,
				tex_size=TEX_SIZE, style="convex",
				tex_depth=TEX_DEPTH
				);

			up(LID_HEIGHT){
				chamfer_cylinder_mask(
					OUTER_RADIUS,
					CHAMFER_SIZE,
					orient=UP,
					ang=CHAMFER_ANGLE
					);

				translate([0, 0, -0.30]) linear_extrude(0.41) scale(0.017) import(file = "svgviewer-png-output.svg", center = true, dpi = 96, $fn=100);
			}

			cylinder(h=BOTTOM_CHAMFER/2, r2=INNER_RADIUS*3/4, r1=INNER_RADIUS+1.5);
			up(BOTTOM_CHAMFER / 2) {
				cylinder(h=BOTTOM_CHAMFER/2, r2=0, r1=INNER_RADIUS*3/4);
			}


		}

		down(THREADED_SECTION) {
			difference() {
				intersection() {
					linear_sweep(
						[circle(OUTER_RADIUS)],
						texture=tex, h=THREADED_SECTION,
						tex_size=TEX_SIZE, style="convex",
						tex_depth=TEX_DEPTH
						);


					up(THREADED_SECTION/2) {
						threaded_nut(
							nutwidth=OUTER_DIMENSION + 10,
							id=INNER_DIMENSION + WALL_THICKNESS * 3.5 / 3,
							h=THREADED_SECTION,
							pitch=THREAD_PITCH,
							bevel=false,
							starts=STARTS,
							blunt_start=true,
							ibevel=false,
							end_len1=LEAD_LENGTH,
							end_len2=LEAD_LENGTH/2,
							$slop=SLOP
							);
					};


				};

				down(0) {
					chamfer_cylinder_mask(
						OUTER_RADIUS,
						CHAMFER_SIZE,
						orient=DOWN,
						ang=CHAMFER_ANGLE
						);
				}
			}
		}
	}
}
