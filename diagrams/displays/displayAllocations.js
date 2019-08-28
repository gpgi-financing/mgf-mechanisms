function displayAllocations(x , y, isVertical) {
  const length = 820;
  const space = (length - totalScale) / 12;
  fill("#ffffff")
  const initX = x
  const initY = y

  const labels = {
    "Africa": [100, 100],
    "China": 0.0531,
    "EU": 0.3172,
    "Eurasia": 0.0118,
    "India": 0.0278,
    "Japan": 0.0323,
    "Latin America": 0.0562,
    "Middle East": 0.0939,
    "Other High Income": 0.0659,
    "Russia": 0.0156,
    "US": 0.1366,
    "Other Asia": 0.1524
  }
  rotate(-PI/4)
  Object.keys(allocations).forEach(player => {
    const allocation = allocations[player]
    const lengthAllocation = totalScale * allocation;
    const a = (x + lengthAllocation / 2 - (y - 5)) / sqrt(2)
    const b = (x + lengthAllocation / 2 + (y - 5)) / sqrt(2)
    fill("#111111")
    textSize(15);
    textAlign(LEFT, BOTTOM);  
    text(player, a, b);
    if (isVertical)
      y += lengthAllocation + space;
    else
      x += lengthAllocation + space;
  })
  rotate(PI/4)

  x = initX
  y = initY
  Object.keys(allocations).forEach(player => {
    const allocation = allocations[player]
    const lengthAllocation = totalScale * allocation;
    fill("#ffffff")
    drawRect(x, y, widthRect, lengthAllocation, isVertical);
    if (isVertical)
      y += lengthAllocation + space;
    else
      x += lengthAllocation + space;
  }) 

  fill("#111111")
  textSize(22);
  textAlign(LEFT, BOTTOM);
  text('Tax revenues collected', x + 5, y + widthRect - 4);
}