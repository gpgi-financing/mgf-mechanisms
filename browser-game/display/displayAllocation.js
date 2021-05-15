function displayAllocations() {
  var x = 100;
  var y = 90;
  Object.values(allocations).forEach(allocation => {
    const lengthAllocation = totalScale * allocation;
    rect(x, y, widthRect , lengthAllocation)
    y += lengthAllocation + 10;
  }) 
}