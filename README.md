# Computer-Graphics

Here I've stored the solutions to the problems we got at the Computer-Graphics lab as a progress tracking solution.

In the SVG folder you will find a few examples that implement vectorial graphics manipulated using pure javascript.

1. The Superman example shows a basic mousemove event that helps superman point lasers to your cursor's position.

The point behind this animation is to show a way to animate a background using animateTransform tags and translation, but also to show a javascript user interaction.

The background is created using multiple "mountain-item" symbols defined as follows:
``` 
 <symbol id="mountain-item">
      <polygon id="mountain-poly" points="0,600 100,210 200,600" fill="gray" stroke="aqua" stroke-width="1" >
      </polygon>
  </symbol>
```
Those symbols are then multiplied using the <use href="symbol-name"/> tag but translated to different positions on screen using an animateTransform for each one of them.
``` 
<animateTransform
  attributeName="transform" type="translate"
  values="400 50; -400 50"
  additive="sum"
  dur="3s"
repeatCount="indefinite" />
```

This allows the used symbol to start with all it's coordinates offseted by 400 pixels on the X axis and 50 on the Y(what their positions were + the offset). This way the triangle goes out of the screen and seems smaller, although the better way to do this, would have been using the transform="scale(scale_factor)" property.
By using this symbols and translations system, I was able to create multiple instances with different properties of the mountain symbol, in order to simulate some smaller, faster moving ones, or even ones moving in front of the character.
Also by chaining multiple points in the values property, the animations are chained. We can also tune the duration of the animation, it's type(the other ones being scale and rotate) and also the additive operation when applying the offset.

The character is an <image href="path" /> that has a chained animation to simulate an up and down movement, to look like flying. This was implemented different as above, by changing the animation's "to" and "from" parameters, using javascript.
It is an alternative to using an animateTransform.

The lasers that follow the mouse position are created using 2 different elements(a <polygon> and a <line> so that you can see both of them fit this scenario), that use the same method: an onmousemove event is bound to the svg canvas so that the x and y position of the mouse is always updated.
At each mouse movement, both of the mouse coordinates are scaled to the current screen size using: pt.matrixTransform(canvas.getScreenCTM().inverse())
This is useful as the svg canvas varies depending on the current screen size but the virtual viewBox="0 0 800 600" restricts any element contained in the canvas to those coordinates. This way all of the javascript's parameters given to the onmousemove event are scaled to that viewbox;
Also the resulting coordinates are printed inside two <text> fields 



2. The Graph example generates with javascript all the points of a <path/> element, in order to get a rounded graphic that animates between changing it's data.

The generating javascript algorithm works as follows:
1. It receives an array of Y positions, as an input.
2. It generates all the SVG points from those Ys and stores them as graphPoints.
3. It generates all the bezier points(in this case quadratic Beziers) between all the graphPoints.
4. It merges the graphPoints and bezierPoints into an pathPoints array.
5. It stringifies and merges the points in the pathPoints array and then changes the "d" attribute of the path(after animating it).
6. Adds circles on the graphPoints and lines between any bezierPoint and it's adjacent graphPoints, so that it shows how the graph was constructed.

The power of this algorithm is the simplicity of changing how the graph looks like, by adjusting the bezier points calculation rule:
```
function calculateBezierPointsBetweenInterval(p1, p2){
  var bez1 = {};
  bez1.x = p2.x + (p1.y>p2.y? -40: 10);
  bez1.y=  p2.y + (p1.y>p2.y? 1: -1)*((30*Math.abs(p1.y-p2.y))/100);
  return [bez1];
}
```
The idea here is that, both x and y adjust based on whether the graph is increasing or decreasing, and the y is also adjusted by 30% of the Y absolute difference between points, so that the quadratic bezier point is well placed between p1 and p2 even if the difference is very small or very big.



