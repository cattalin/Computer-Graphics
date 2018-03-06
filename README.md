# Computer-Graphics

Here I've stored the solutions to the problems we got at the Computer-Graphics lab as a progress tracking solution.

In the SVG folder you will find a few examples that implement vectorial graphics manipulated using pure javascript.

1. The Superman example shows a basic mousemove event that helps superman point lasers to your cursor's position.

The point behind this animation is to show a way to animate a background using animateTransform tags and translation, but also to show a javascript user interaction.

The background is created using multiple "mountain-item" symbols defined as follows:
  <symbol id="mountain-item">
      <polygon id="mountain-poly" points="0,600 100,210 200,600" fill="gray" stroke="aqua" stroke-width="1" >
      </polygon>
  </symbol>
Those symbols are then multiplied using the <use href="symbol-name"/> tag but translated to different positions on screen using an animateTransform for each one of them.
<animateTransform
  attributeName="transform" type="translate"
  values="400 50; -400 50"
  additive="sum"
  dur="3s"
repeatCount="indefinite" />
This allows the used symbol to start with all it's coordinates offseted by 400 pixels on the X axis and 50 on the Y(what their positions were + the offset). This way the triangle goes out of the screen and seems smaller, although the better way to do this, would have been using the transform="scale(scale_factor)" property.
By using this symbols and translations system, I was able to create multiple instances with different properties of the mountain symbol, in order to simulate some smaller, faster moving ones, or even ones moving in front of the character.
Also by chaining multiple points in the values property, the animations are chained. We can also tune the duration of the animation, it's type(the other ones being scale and rotate) and also the additive operation when applying the offset.

The character is an <image href="path" /> that has a chained animation to simulate an up and down movement, to look like flying. This was implemented different as above, by changing the animation's "to" and "from" parameters, using javascript.
It is an alternative to using an animateTransform.

The lasers that follow the mouse position are created using 2 different elements(a <polygon> and a <line> so that you can see both of them fit this scenario), that use the same method: an onmousemove event is bound to the svg canvas so that the x and y position of the mouse is always updated.
At each mouse movement, both of the mouse coordinates are scaled to the current screen size using: pt.matrixTransform(canvas.getScreenCTM().inverse())
This is useful as the svg canvas varies depending on the current screen size but the virtual viewBox="0 0 800 600" restricts any element contained in the canvas to those coordinates. This way all of the javascript's parameters given to the onmousemove event are scaled to that viewbox;
Also the resulting coordinates are printed inside two <text> fields 



2. The Graph example generates with javascript all the points of a <path/> element, in order to get a rounded graphic that animates between changing it's data. The input is the array of Y's.



