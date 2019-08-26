
function setup() {
  var canvas = createCanvas(1800, 1000);
  canvas.parent('sketch-holder');
  background('#fcfcfc');
  rectMode(CORNER);
  stroke('#000000');
  fill('#ffffff');

  displayAllocations(450, 100, false);
  displayStrategies(450, 200, false);

  displayTotalMoneyNotDirectlyAllocated(50, 400, false);
  displayTotalMoneyInitiallyAllocatedToMfs(50, 500, false);
  displayTotalMoneyDirectlyAllocated(50, 600, false);

  displayTotalMoneyNotDirectlyAllocatedAfterAllocationToMf(450, 400, false);
  displayTotalMoneyInitiallyAllocatedToMfs(450, 500, false);
  displayTotalMoneyDirectlyAllocated(450, 600, false);

  displayTotalMoneyAllocatedToMfs(850, 450, false);
  displayTotalMoneyDirectlyAllocated(850, 600, false);

  displayTotalMoneyAllocatedToMfsAfterAllocationToGpgi(1250, 450, false);
  displayTotalMoneyDirectlyAllocated(1250, 600, false);

  displayFinalRepartition(450, 750, false);
}
