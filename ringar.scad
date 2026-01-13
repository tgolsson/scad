include <Round-Anything-1.0.4/polyround.scad>

$fa = $preview? 1 : 1;
//$fn = $preview? 20 : 100;
$fs = $preview? 0.1 :  0.2;
OUTER_RADIUS = 49;
WIDTH = 4;
RINGS = 4;
ROUNDING = 0.1;

INDENT_SIZE = 1.8;
INDENT_HEIGHT=0.2;
OFFSET = 0.75;

BASE = 3.9;
H1=BASE+OFFSET/2;
H2=BASE*2+OFFSET/2;
H3=BASE*3;
heights = [H1, H2, H3];
//translate([0, 4.1, 0]) profile(5);
//profile(5)
for (hi = [0:len(heights)-1]) {
 	for (i = [0:RINGS-1]) {
        r = OUTER_RADIUS - i* (WIDTH * 2 + 1);
        translate([49/2 +(49+1)*hi, 0, 0])
		ring(r, heights[hi]);
 	}
 }


module ring(outer_radii, h) {
	rotate_extrude(convexity=10)
    translate([outer_radii/2, 0, 0])
    profile(h);
}


//profile(5);

module profile(h) {
    h = h - ROUNDING *2;
    w = WIDTH - 2*ROUNDING;
    mirror([0, 1, 0])
    translate([-WIDTH, -h, 0])
	translate([ROUNDING, ROUNDING, 0])
	offset(ROUNDING)
	union() {
		polygon(points=[[0, h],
						[w*5/8, h],
						[w*5.5/8, h-OFFSET],
						[w*8/8, h-OFFSET*2],
						//[w*0.95, OFFSET*2],
						[w, 0],
						[w*6.0/8, 0],
						[w*5.7/8, OFFSET],
						[0, OFFSET]
					]);
	}
}

// BASE = 3.9;
// H1=BASE+OFFSET/2;
// H2=BASE*2+OFFSET/2;
// H3=BASE*3;
// color([1,0,0,1]) translate([0, 0, 0]) profile(H1);
// color([0,1,0,1]) translate([5, 0, 0])profile(H2);

// translate([10, 0, 0]) profile(H3);
// color([1,0,0,1]) translate([15, H2-OFFSET+0.01, 0]) profile(H1);
// color([0,1,0,1]) translate([15, 0, 0]) profile(H2);

// color([1,0,0,1]) translate([20, H3-OFFSET+0.01, 0]) profile(H1);
// translate([20, 0, 0]) profile(H3);

// color([0,1,0,1]) translate([25, H3-OFFSET, 0]) profile(H2);
// translate([25, 0, 0]) profile(H3);

// color([1,0,0,1]) translate([30, H3-OFFSET+0.01, 0]) profile(H1);
// color([0,1,0,1]) translate([30, H1+H3-OFFSET*2, 0]) profile(H2);
// translate([30, 0, 0]) profile(H3);
// // 5 + 7.5 + 10 = 22.5;
// // 4 + 8 + 12 = 24.5;
// // 3 + 6 + 9 = 18;
// // 3.5 + 7 + 10.5 = 21;
// echo(H1, H2, H3);
// echo(H1+H2+H3-2*OFFSET);
// echo(5+7.5+10);
