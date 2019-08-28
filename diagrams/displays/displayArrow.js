
function displayArrow(x, y, isVertical) {
  fill("#ffffff")
  const length = 60;


  rect(x, y, length, widthRect)
  triangle(x + length, y - 10, x + length, y + widthRect + 10, x + length + 50, y + widthRect / 2);
  noStroke();
  rect(x + 10, y + 1, length , widthRect - 1)

  stroke("#000000");
}