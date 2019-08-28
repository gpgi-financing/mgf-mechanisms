

function setup() {
  var canvas = createCanvas(canvasLength, canvasHeight);
  canvas.parent('sketch-holder');
  background('#fcfcfc');
  rectMode(CORNER);
  stroke('#000000');
  fill('#ffffff');

  if (currentMecanism === "corsia+") {
    showDiagramCorsiaPlus();
  } else if (currentMecanism === "simple-mgf") {
    showDiagramSimpleMgf();
  } else if (currentMecanism === "mgf") {
    showDiagramMgf();
  }
}

function showDiagramCorsiaPlus() {
  drawLegendCorsia(830, 50)
  displayAllocations(150, 320, false);
  displayCorsiaAllocations(150, 400, false);
  displayCorsiaFinalRepartition(550, 500, false);

}

function showDiagramSimpleMgf() {
  drawLegend(1150, 50)
  displayAllocations(50, 120, false);
  displayStrategies(50, 180, false);

  displayTotalMoneyNotDirectlyAllocated(450, 400, false);
  displayTotalMoneyDirectlyAllocated(450, 500, false);

  let s = 'Distribution of non-allocated money to the GPGIs proportionnally to the direct allocation to made to these GPGIs';
  fill("#111111")
  textSize(17);
  textAlign(CENTER, TOP);
  text(s, 690, 280, 220, 200);
  displayArrow(730, 450, false)

  displaySimpleMgfIndirectAllocationGpgis(900, 400, false);
  displayTotalMoneyDirectlyAllocated(900, 500, false);

  displaySimpleMgfFinalRepartition(550, 650, false);
}

function showDiagramMgf() {
  drawLegend(1150, 50)
  displayAllocations(50, 120, false);
  displayStrategies(50, 180, false);

  displayTotalMoneyNotDirectlyAllocated(50, 400, false);
  displayTotalMoneyInitiallyAllocatedToMfs(50, 500, false);
  displayTotalMoneyDirectlyAllocated(50, 600, false);

  let s = 'Distribution of non-allocated money to PMFs proportionnally to the allocation to each PMF weigthed by the number of GPGIs';
  fill("#111111")
  textSize(17);
  textAlign(CENTER, TOP);
  text(s, 240, 280, 240, 200);
  displayArrow(300, 450, false)

  displayTotalMoneyNotDirectlyAllocatedAfterAllocationToMf(450, 400, false);
  displayTotalMoneyInitiallyAllocatedToMfs(450, 500, false);
  displayTotalMoneyDirectlyAllocated(450, 600, false);


  s = 'We now sum the initial allocation to PMFs with the indirect allocation to PMFs';
  fill("#111111")
  textSize(17);
  textAlign(CENTER, TOP);
  text(s, 660, 280, 220, 200);
  displayArrow(700, 450, false)

  displayTotalMoneyAllocatedToMfs(850, 450, false);
  displayTotalMoneyDirectlyAllocated(850, 600, false);

  s = 'Distribution of total allocations to PMFs to the GPGIs proportionnally to the direct allocation to made to these GPGIs';
  fill("#111111")
  textSize(17 );
  textAlign(CENTER, TOP);
  text(s, 1050, 280, 240, 220);
  displayArrow(1100, 450, false)

  displayTotalMoneyAllocatedToMfsAfterAllocationToGpgi(1250, 450, false);
  displayTotalMoneyDirectlyAllocated(1250, 600, false);

  displayMgfFinalRepartition(500, 750, false);
}

