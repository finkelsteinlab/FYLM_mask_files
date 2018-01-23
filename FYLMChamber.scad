// FYLM Environmental Chamber

//needed values:   
    //stage adapter width
    stageW = 159;
    //stage adapter depth
    stageD = 110;
    //stage adapter height
    stageH = 3;
    //stage corner radius
    stageR = 5;
    //chamber outer width
    outerW = 135;
    //chamber outer depth
    outerD = 95;
    //chamber outer height
    outerH = 30;
    //chamber inner width
    innerW = 112;
    //chamber inner depth
    innerD = 82;
    //chamber inner height
    innerH = 25;
    //scope opening radius
    scopeR = 12;
    //tubing path width
    tubingW = 15;
    //tubing path height
    tubingH = 3;
    //slide hold-down screw-hole radius
    screwR = 1.25;
    //slide hold-down screw-hole offset from slide
    screwO = 5;
    //slide width
    slideW = 60;
    //slide depth
    slideD = 48;
    //slide height
    slideH = 2;
    //lid height
    lidH = 3;
    //heatsink height
    heatH = 15;
    //heatsink outer clearance
    heatO = 2;
    //heatsink inner clearance
    heatI = 2;
    //heatsink element radius
    heatR = 2;
    //heatsink element length
    heatL = 25;
    
    
module Slide () {
    color("blue");
    translate([(stageW-slideW)/2,(stageD-slideD)/2,(stageH-innerH)/2]){
        cube([slideW,slideD,slideH]);
    }
}

module Lid () {
    color("green");
    translate([(stageW-outerW)/2,(stageD-outerD)/2,(stageH+outerH)/2]){
        cube([outerW,outerD,lidH]);
    }
}

module HeatSink () {
    color("grey");
    difference(){
        //outer heatsink dimensions
        translate([(stageW-innerW+heatO)/2,(stageD-innerD+heatO)/2,(stageH-innerH)/2]){
            cube([innerW-heatO,innerD-heatO,heatH]);
        }
        //inner heatsink dimensions
        translate([(stageW-slideW-2*(screwO+screwR+heatI))/2,(stageD-slideD-2*(screwO+screwR+heatI))/2,(stageH-innerH)/2]){
            cube([slideW+2*(screwO+screwR+heatI),slideD+2*(screwO+screwR+heatI),heatH]);
        }
        //thermostat and element slots
        translate([(stageW-innerW)/2+10,(stageD)/2,(stageH-innerH+heatH)/2]){
            rotate([60,0,0]){
                cylinder(r=heatR,h=heatL,$fn=32);
            }
        }
        translate([(stageW+innerW)/2-10,(stageD)/2,(stageH-innerH+heatH)/2]){
            rotate([60,0,0]){
                cylinder(r=heatR,h=heatL,$fn=32);
            }
        }
    }
}
        
module ChamberBase () {
    color("red");
    difference(){
        union (){
            //main stage adapter plate with radiused corners
            translate([stageR,0,0])
                cube([stageW-2*stageR,stageD,stageH]);
            translate([0,stageR,0])
                cube([stageW,stageD-2*stageR,stageH]);
            for (i = [0,1]){
                for (j = [0,1]){
                    translate([stageR+i*(stageW-2*stageR),stageR+j*(stageD-2*stageR),0])
                        cylinder(r=stageR,h=stageH,$fn=32);
                }
            }
            //outer chamber
            translate([(stageW-outerW)/2,(stageD-outerD)/2,(stageH-outerH)/2]){
                cube([outerW,outerD,outerH]);
            }
        }

        //inner chamber
        translate([(stageW-innerW)/2,(stageD-innerD)/2,(stageH-innerH)/2]){
            cube([innerW,innerD,outerH]);
        }
        //tubing passages
        translate([(stageW-tubingW)/2,0,outerH/2]){
            cube([tubingW,stageD,tubingH]);
        }
        translate([0,(stageD-tubingW)/2,outerH/2]){
            cube([stageW,tubingW,tubingH]);
        }
        // microscope objective opening
        translate([stageW/2,stageD/2,-outerH/2]){
            sphere(r=scopeR);
        }
        //screw holes
        for (i = [1,-1]){
            for (j = [1,-1]){
                translate([stageW/2-i*(slideW/2+screwO),stageD/2-j*(slideD/2+screwO),-outerH/2]){
                    cylinder(r=screwR,h=outerH,$fn=32);
                }
            }
        }
    }
}

ChamberBase();
//Lid();
//Slide();
HeatSink();
    
    
    
    
