function displayAllocations(x , y, isVertical) {
  Object.values(allocations).forEach(allocation => {
    const lengthAllocation = totalScale * allocation;
    drawRect(x, y, widthRect, lengthAllocation, isVertical);
    if (isVertical)
      y += lengthAllocation + 10;
    else
      x += lengthAllocation + 10;
  }) 

  fill("#111111")
  textSize(22);
  textAlign(LEFT, BOTTOM);
  text('Tax revenues collected', x + 5, y + widthRect - 4);
}