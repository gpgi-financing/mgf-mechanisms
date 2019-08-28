
function displayCorsiaFinalRepartition(x , y, isVertical) {
  fill(colorCorsiaGpgi);
  const totalProportionMoneyNotDirectlyAllocated = getTotalProportionMoneyNotDirectlyAllocated();
  const lengthTotalMoneyNotDirectlyAllocated = totalScale * totalProportionMoneyNotDirectlyAllocated;
  drawRect(x, y, widthRect , lengthTotalMoneyNotDirectlyAllocated, isVertical)

  fill("#111111")
  textSize(22);
  textAlign(LEFT, BOTTOM);
  text('Final repartition', x + lengthTotalMoneyNotDirectlyAllocated + 15, y + widthRect - 4);
}
