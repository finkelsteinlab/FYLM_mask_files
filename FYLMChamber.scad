// FYLM Environmental Chamber

module ChamberBase () {
    color("red");
    
    //needed values:
    
    //stage adapter width
    stageW = 100;
    //stage adapter depth
    stageD = 80;
    //stage adapter height
    stageH = 5;
    //chamber outer width
    outerW = 80;
    //chamber outer depth
    outerD = 70;
    //chamber outer height
    outerH = 30;
    //chamber inner width
    innerW = 60;
    //chamber inner depth
    innerD = 60;
    //chamber inner height
    innerH = 25;
    //scope opening radius
    scopeR = 10;
    
    difference(){
        union (){
            //adapt to stage
            cube([stageW,stageD,stageH]);
            //outer chamber
            translate([(stageW-outerW)/2,(stageD-outerD)/2,(stageH-outerH)/2]){
                cube([outerW,outerD,outerH]);
            }
        }
        //inner chamber
        translate([(stageW-innerW)/2,(stageD-innerD)/2,(stageH-innerH)/2]){
            cube([innerW,innerD,outerH]);
        }
        // microscope objective opening
        translate([(stageW-innerW)/2,(stageD-innerD)/2,(stageH-innerH)/2]){
            cylinder([scopeR,innerH])
        }
    }
}

ChamberBase();
    
    
    
    