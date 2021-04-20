import glfw
import math
import opengl

# Init GLFW
if glfw.init() == 0:
  raise newException(Exception, "Failed to Initialize GLFW")

# Open window.
var window = glfw.createWindow(800, 600, "GLFW3 WINDOW", nil, nil)
# Connect the GL context.
window.makeContextCurrent()
# This must be called to make any GL function work
opengl.loadExtensions()

glfw.swapInterval(1);

# Run while window is open.
proc adv(n: var float32, d: float32) =
  n = n + d; if n > 1f: n = 0

var r = 1/3f
var g = 2/3f
var b = 3/3f
var twoPi = math.PI
while window.windowShouldClose() == 0:
  adv(r, 0.007f)
  adv(g, 0.007f)
  adv(b, 0.007f)

  # Draw red color screen.
  glClearColor(sin(r * twoPi), sin(g * twoPi), sin(b * twoPi), 1)
  glClear(GL_COLOR_BUFFER_BIT)

  # Swap buffers (this will display the red color)
  window.swapBuffers()

  # Check for events.
  pollEvents()

  # If you get ESC key quit.
  if window.getKey(KEY_ESCAPE) == 1:
    window.setWindowShouldClose(1)

# Destroy the window.
window.destroyWindow()
# Exit GLFW.
terminate()