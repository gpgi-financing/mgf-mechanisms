
function drawLegendCorsia(x, y) {
  const length = 60;
  const width = 20
  fill("#ffffff")
  strokeWeight(2)
  rect(x - 20, y - 20, 480, y - 10 + 2 * (width + 5))
  strokeWeight(1)

  fill(colorCorsiaGpgi)
  rect(x, y, length, width)
  fill("#111111")
  textSize(16);
  textAlign(LEFT, BOTTOM);
  text(`Money allocated to the GPGI selected for CORSIA+`, x + length + 5, y + width + 1);
  y +=  width + 5

  fill("#111111")
  rect(x, y, length, width)
  textSize(16);
  textAlign(LEFT, BOTTOM);
  text(`Money retained by players (retention rate = ${retentionRate})`, x + length + 5, y + width + 1);
  y +=  width + 5
}