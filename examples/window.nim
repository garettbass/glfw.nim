import glfw
import math
import opengl

if glfwInit() == 0:
  raise newException(Exception, "failed to initialize glfw")

var window = glfwCreateWindow(800, 600, "GLFW3 WINDOW", nil, nil)

glfwMakeContextCurrent(window)

opengl.loadExtensions()

glfwSwapInterval(1);

var r = 0.0f
var g = 0.3f
var b = 0.6f
var twoPi = math.PI

while glfwWindowShouldClose(window) == 0:
  r = floorMod(r + 0.005f, 1f)
  g = floorMod(g + 0.005f, 1f)
  b = floorMod(b + 0.005f, 1f)

  # Draw red color screen.
  glClearColor(sin(r * twoPi), sin(g * twoPi), sin(b * twoPi), 1)
  glClear(GL_COLOR_BUFFER_BIT)

  # Swap buffers (this will display the red color)
  glfwSwapBuffers(window)

  # Check for events.
  glfwPollEvents()

  # If you get ESC key quit.
  if glfwGetKey(window, GLFW_KEY_ESCAPE) == 1:
    glfwSetWindowShouldClose(window, 1)

# Destroy the window.
glfwDestroyWindow(window)

# Exit GLFW.
glfwTerminate()