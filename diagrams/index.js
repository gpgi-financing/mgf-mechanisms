
function setup() {
  var canvas = createCanvas(1600, 900);
  canvas.parent('sketch-holder');
  background('#fcfcfc');
  rectMode(CORNER);
  stroke('#000000');
  fill('#ffffff');

  displayAllocations(450, 100, false);
  displayStrategies(450, 200, false);

  displayTotalMoneyNotDirectlyAllocated(200, 400, false);
  displayTotalMoneyInitiallyAllocatedToMfs(200, 500, false);
  displayTotalMoneyDirectlyAllocated(200, 600, false);

  displayTotalMoneyNotDirectlyAllocatedAfterAllocationToMf(600, 400, false);
  displayTotalMoneyInitiallyAllocatedToMfs(200, 500, false);
  displayTotalMoneyDirectlyAllocated(200, 600, false);

}
