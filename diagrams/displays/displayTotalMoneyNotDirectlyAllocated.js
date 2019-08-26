
function displayTotalMoneyNotDirectlyAllocated(x, y, isVertical) {
  fill('#afafaf');
  const totalProportionMoneyNotDirectlyAllocated = getTotalProportionMoneyNotDirectlyAllocated();
  const lengthTotalMoneyNotDirectlyAllocated = totalScale * totalProportionMoneyNotDirectlyAllocated;
  drawRect(x, y, widthRect , lengthTotalMoneyNotDirectlyAllocated, isVertical)
}