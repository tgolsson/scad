PAPER_THICKNESS = 2;

WIDTH1 = 4 * PAPER_THICKNESS - 1;
WIDTH2 = 6 * PAPER_THICKNESS - 1;
OVERHANG = 0;

LENGTH = 20;

translate([0, LENGTH/2+2.5])
linear_extrude(PAPER_THICKNESS*2)
square([WIDTH2*2, 5], center=true);

linear_extrude(PAPER_THICKNESS)
    square([WIDTH1, LENGTH], center=true);

translate([0, 0, PAPER_THICKNESS])
    linear_extrude(PAPER_THICKNESS)
    square([WIDTH1 + OVERHANG * 2, LENGTH], center=true);


translate([0, 2 * LENGTH, 0]){
	translate([0, LENGTH/2+2.5])
		linear_extrude(PAPER_THICKNESS*2)
		square([WIDTH2*2, 5], center=true);

	linear_extrude(PAPER_THICKNESS)
		square([WIDTH2, LENGTH], center=true);

	translate([0, 0, PAPER_THICKNESS])
		linear_extrude(PAPER_THICKNESS)
		square([WIDTH2 + OVERHANG * 2, LENGTH], center=true);
}
