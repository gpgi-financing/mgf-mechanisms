
function drawLegend(x, y) {
  const length = 60;
  const width = 20
  fill("#ffffff")
  strokeWeight(2)
  rect(x - 20, y - 20, 440, y - 10 + 7 * (width + 5))
  strokeWeight(1)
  Object.keys(gpgis).forEach(gpgi => {
    const color = gpgis[gpgi]
    const gpgiName = gpgisName[gpgi]
    fill(color)
    rect(x, y, length, width)
    fill("#111111")
    textSize(16);
    textAlign(LEFT, BOTTOM);
    text(gpgiName, x + length + 5, y + width + 1);
    y +=  width + 5
  })
  fill("#111111")
  rect(x, y, length, width)
  textSize(16);
  textAlign(LEFT, BOTTOM);
  text(`Money retained by players (retention rate = ${retentionRate})`, x + length + 5, y + width + 1);
  y +=  width + 5


}