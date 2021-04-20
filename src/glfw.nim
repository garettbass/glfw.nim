when defined(emscripten):
  {.
    passL: "-s USE_WEBGL2=1"
    passL: "-s USE_GLFW=3"
  .}
else:
  when defined(windows):
    when defined(gcc) or defined(clang):
      {.
        passL: "-lgdi32"
        passL: "-lopengl32"
      .}
    when defined(vcc):
      {.
        passC: "-D_GLFW_WIN32"
        link: "kernel32.lib"
        link: "gdi32.lib"
        link: "shell32.lib"
        link: "user32.lib"
      .}
    {.
      passC: "-D_GLFW_WIN32"
      compile: "glfw/src/egl_context.c"
      compile: "glfw/src/osmesa_context.c"
      compile: "glfw/src/wgl_context.c"
      compile: "glfw/src/win32_init.c"
      compile: "glfw/src/win32_joystick.c"
      compile: "glfw/src/win32_monitor.c"
      compile: "glfw/src/win32_thread.c"
      compile: "glfw/src/win32_time.c"
      compile: "glfw/src/win32_window.c"
    .}
  elif defined(macosx):
    {.
      passC: "-D_GLFW_COCOA"
      passL: "-framework Cocoa"
      passL: "-framework OpenGL"
      passL: "-framework IOKit"
      passL: "-framework CoreVideo"
      compile: "glfw/src/cocoa_init.m"
      compile: "glfw/src/cocoa_joystick.m"
      compile: "glfw/src/cocoa_monitor.m"
      compile: "glfw/src/cocoa_time.c"
      compile: "glfw/src/cocoa_window.m"
      compile: "glfw/src/egl_context.c"
      compile: "glfw/src/nsgl_context.m"
      compile: "glfw/src/osmesa_context.c"
      compile: "glfw/src/posix_thread.c"
    .}
  elif defined(linux):
    {.
      passL: "-pthread"
      passL: "-lGL"
      passL: "-lX11"
      passL: "-lXrandr"
      passL: "-lXxf86vm"
      passL: "-lXi"
      passL: "-lXcursor"
      passL: "-lm"
      passL: "-lXinerama"
    .}
    when defined(wayland):
      {.
        passC: "-D_GLFW_WAYLAND"
        compile: "glfw/src/egl_context.c"
        compile: "glfw/src/osmesa_context.c"
        compile: "glfw/src/posix_thread.c"
        compile: "glfw/src/posix_time.c"
        compile: "glfw/src/wl_init.c"
        compile: "glfw/src/wl_monitor.c"
        compile: "glfw/src/wl_window.c"
        compile: "glfw/src/xkb_unicode.c"
      .}
    else:
      {.
        passC: "-D_GLFW_X11"
        compile: "glfw/src/egl_context.c"
        compile: "glfw/src/glx_context.c"
        compile: "glfw/src/osmesa_context.c"
        compile: "glfw/src/posix_thread.c"
        compile: "glfw/src/posix_time.c"
        compile: "glfw/src/x11_init.c"
        compile: "glfw/src/x11_monitor.c"
        compile: "glfw/src/x11_window.c"
        compile: "glfw/src/xkb_unicode.c"
      .}
    {.
      compile: "glfw/src/linux_joystick.c"
    .}
  else:
    # If unsupported/unknown OS, use null system
    {.
      compile: "glfw/src/null_init.c",
      compile: "glfw/src/null_joystick.c",
      compile: "glfw/src/null_monitor.c",
      compile: "glfw/src/null_window.c",
      compile: "glfw/src/osmesa_context.c"
      compile: "glfw/src/posix_thread.c",
      compile: "glfw/src/posix_time.c",
    .}
  {.
    compile: "glfw/src/context.c",
    compile: "glfw/src/init.c",
    compile: "glfw/src/input.c",
    compile: "glfw/src/monitor.c",
    compile: "glfw/src/vulkan.c",
    compile: "glfw/src/window.c"
  .}

#-------------------------------------------------------------------------------

const
  VERSION_MAJOR*    = 3
  VERSION_MINOR*    = 4
  VERSION_REVISION* = 0

const
  RELEASE* = 0
  PRESS*   = 1
  REPEAT*  = 2

const
  HAT_CENTERED*   = 0
  HAT_UP*         = 1
  HAT_RIGHT*      = 2
  HAT_DOWN*       = 4
  HAT_LEFT*       = 8
  HAT_RIGHT_UP*   = 3
  HAT_RIGHT_DOWN* = 6
  HAT_LEFT_UP*    = 9
  HAT_LEFT_DOWN*  = 12

const
  KEY_UNKNOWN*        = -1
  KEY_SPACE*          = 32
  KEY_APOSTROPHE*     = 39
  KEY_COMMA*          = 44
  KEY_MINUS*          = 45
  KEY_PERIOD*         = 46
  KEY_SLASH*          = 47
  KEY_0*              = 48
  KEY_1*              = 49
  KEY_2*              = 50
  KEY_3*              = 51
  KEY_4*              = 52
  KEY_5*              = 53
  KEY_6*              = 54
  KEY_7*              = 55
  KEY_8*              = 56
  KEY_9*              = 57
  KEY_SEMICOLON*      = 59
  KEY_EQUAL*          = 61
  KEY_A*              = 65
  KEY_B*              = 66
  KEY_C*              = 67
  KEY_D*              = 68
  KEY_E*              = 69
  KEY_F*              = 70
  KEY_G*              = 71
  KEY_H*              = 72
  KEY_I*              = 73
  KEY_J*              = 74
  KEY_K*              = 75
  KEY_L*              = 76
  KEY_M*              = 77
  KEY_N*              = 78
  KEY_O*              = 79
  KEY_P*              = 80
  KEY_Q*              = 81
  KEY_R*              = 82
  KEY_S*              = 83
  KEY_T*              = 84
  KEY_U*              = 85
  KEY_V*              = 86
  KEY_W*              = 87
  KEY_X*              = 88
  KEY_Y*              = 89
  KEY_Z*              = 90
  KEY_LEFT_BRACKET*   = 91
  KEY_BACKSLASH*      = 92
  KEY_RIGHT_BRACKET*  = 93
  KEY_GRAVE_ACCENT*   = 96
  KEY_WORLD_1*        = 161
  KEY_WORLD_2*        = 162
  KEY_ESCAPE*         = 256
  KEY_ENTER*          = 257
  KEY_TAB*            = 258
  KEY_BACKSPACE*      = 259
  KEY_INSERT*         = 260
  KEY_DELETE*         = 261
  KEY_RIGHT*          = 262
  KEY_LEFT*           = 263
  KEY_DOWN*           = 264
  KEY_UP*             = 265
  KEY_PAGE_UP*        = 266
  KEY_PAGE_DOWN*      = 267
  KEY_HOME*           = 268
  KEY_END*            = 269
  KEY_CAPS_LOCK*      = 280
  KEY_SCROLL_LOCK*    = 281
  KEY_NUM_LOCK*       = 282
  KEY_PRINT_SCREEN*   = 283
  KEY_PAUSE*          = 284
  KEY_F1*             = 290
  KEY_F2*             = 291
  KEY_F3*             = 292
  KEY_F4*             = 293
  KEY_F5*             = 294
  KEY_F6*             = 295
  KEY_F7*             = 296
  KEY_F8*             = 297
  KEY_F9*             = 298
  KEY_F10*            = 299
  KEY_F11*            = 300
  KEY_F12*            = 301
  KEY_F13*            = 302
  KEY_F14*            = 303
  KEY_F15*            = 304
  KEY_F16*            = 305
  KEY_F17*            = 306
  KEY_F18*            = 307
  KEY_F19*            = 308
  KEY_F20*            = 309
  KEY_F21*            = 310
  KEY_F22*            = 311
  KEY_F23*            = 312
  KEY_F24*            = 313
  KEY_F25*            = 314
  KEY_KP_0*           = 320
  KEY_KP_1*           = 321
  KEY_KP_2*           = 322
  KEY_KP_3*           = 323
  KEY_KP_4*           = 324
  KEY_KP_5*           = 325
  KEY_KP_6*           = 326
  KEY_KP_7*           = 327
  KEY_KP_8*           = 328
  KEY_KP_9*           = 329
  KEY_KP_DECIMAL*     = 330
  KEY_KP_DIVIDE*      = 331
  KEY_KP_MULTIPLY*    = 332
  KEY_KP_SUBTRACT*    = 333
  KEY_KP_ADD*         = 334
  KEY_KP_ENTER*       = 335
  KEY_KP_EQUAL*       = 336
  KEY_LEFT_SHIFT*     = 340
  KEY_LEFT_CONTROL*   = 341
  KEY_LEFT_ALT*       = 342
  KEY_LEFT_SUPER*     = 343
  KEY_RIGHT_SHIFT*    = 344
  KEY_RIGHT_CONTROL*  = 345
  KEY_RIGHT_ALT*      = 346
  KEY_RIGHT_SUPER*    = 347
  KEY_MENU*           = 348
  KEY_LAST*           = KEY_MENU

const
  MOD_SHIFT*    = 0x0001
  MOD_CONTROL*  = 0x0002
  MOD_ALT*      = 0x0004
  MOD_SUPER*    = 0x0008

const
  MOUSE_BUTTON_1*      = 0
  MOUSE_BUTTON_2*      = 1
  MOUSE_BUTTON_3*      = 2
  MOUSE_BUTTON_4*      = 3
  MOUSE_BUTTON_5*      = 4
  MOUSE_BUTTON_6*      = 5
  MOUSE_BUTTON_7*      = 6
  MOUSE_BUTTON_8*      = 7
  MOUSE_BUTTON_LAST*   = MOUSE_BUTTON_8
  MOUSE_BUTTON_LEFT*   = MOUSE_BUTTON_1
  MOUSE_BUTTON_RIGHT*  = MOUSE_BUTTON_2
  MOUSE_BUTTON_MIDDLE* = MOUSE_BUTTON_3

const
  JOYSTICK_1*    = 0
  JOYSTICK_2*    = 1
  JOYSTICK_3*    = 2
  JOYSTICK_4*    = 3
  JOYSTICK_5*    = 4
  JOYSTICK_6*    = 5
  JOYSTICK_7*    = 6
  JOYSTICK_8*    = 7
  JOYSTICK_9*    = 8
  JOYSTICK_10*   = 9
  JOYSTICK_11*   = 10
  JOYSTICK_12*   = 11
  JOYSTICK_13*   = 12
  JOYSTICK_14*   = 13
  JOYSTICK_15*   = 14
  JOYSTICK_16*   = 15
  JOYSTICK_LAST* = JOYSTICK_16

const
  GAMEPAD_BUTTON_A*            = 0
  GAMEPAD_BUTTON_B*            = 1
  GAMEPAD_BUTTON_X*            = 2
  GAMEPAD_BUTTON_Y*            = 3
  GAMEPAD_BUTTON_LEFT_BUMPER*  = 4
  GAMEPAD_BUTTON_RIGHT_BUMPER* = 5
  GAMEPAD_BUTTON_BACK*         = 6
  GAMEPAD_BUTTON_START*        = 7
  GAMEPAD_BUTTON_GUIDE*        = 8
  GAMEPAD_BUTTON_LEFT_THUMB*   = 9
  GAMEPAD_BUTTON_RIGHT_THUMB*  = 10
  GAMEPAD_BUTTON_DPAD_UP*      = 11
  GAMEPAD_BUTTON_DPAD_RIGHT*   = 12
  GAMEPAD_BUTTON_DPAD_DOWN*    = 13
  GAMEPAD_BUTTON_DPAD_LEFT*    = 14
  GAMEPAD_BUTTON_LAST*         = GAMEPAD_BUTTON_DPAD_LEFT
  GAMEPAD_BUTTON_CROSS*        = GAMEPAD_BUTTON_A
  GAMEPAD_BUTTON_CIRCLE*       = GAMEPAD_BUTTON_B
  GAMEPAD_BUTTON_SQUARE*       = GAMEPAD_BUTTON_X
  GAMEPAD_BUTTON_TRIANGLE*     = GAMEPAD_BUTTON_Y
  GAMEPAD_AXIS_LEFT_X*         = 0
  GAMEPAD_AXIS_LEFT_Y*         = 1
  GAMEPAD_AXIS_RIGHT_X*        = 2
  GAMEPAD_AXIS_RIGHT_Y*        = 3
  GAMEPAD_AXIS_LEFT_TRIGGER*   = 4
  GAMEPAD_AXIS_RIGHT_TRIGGER*  = 5
  GAMEPAD_AXIS_LAST*           = GAMEPAD_AXIS_RIGHT_TRIGGER

const
  NO_ERROR*              = 0
  NOT_INITIALIZED*       = 0x00010001
  NO_CURRENT_CONTEXT*    = 0x00010002
  INVALID_ENUM*          = 0x00010003
  INVALID_VALUE*         = 0x00010004
  OUT_OF_MEMORY*         = 0x00010005
  API_UNAVAILABLE*       = 0x00010006
  VERSION_UNAVAILABLE*   = 0x00010007
  PLATFORM_ERROR*        = 0x00010008
  FORMAT_UNAVAILABLE*    = 0x00010009
  NO_WINDOW_CONTEXT*     = 0x0001000A
  CURSOR_UNAVAILABLE*    = 0x0001000B
  FEATURE_UNAVAILABLE*   = 0x0001000C
  FEATURE_UNIMPLEMENTED* = 0x0001000D

const
  FOCUSED*                 = 0x00020001
  ICONIFIED*               = 0x00020002
  RESIZABLE*               = 0x00020003
  VISIBLE*                 = 0x00020004
  DECORATED*               = 0x00020005
  AUTO_ICONIFY*            = 0x00020006
  FLOATING*                = 0x00020007
  MAXIMIZED*               = 0x00020008
  CENTER_CURSOR*           = 0x00020009
  TRANSPARENT_FRAMEBUFFER* = 0x0002000A
  HOVERED*                 = 0x0002000B
  FOCUS_ON_SHOW*           = 0x0002000C
  MOUSE_PASSTHROUGH*       = 0x0002000D

const
  RED_BITS*         = 0x00021001
  GREEN_BITS*       = 0x00021002
  BLUE_BITS*        = 0x00021003
  ALPHA_BITS*       = 0x00021004
  DEPTH_BITS*       = 0x00021005
  STENCIL_BITS*     = 0x00021006
  ACCUM_RED_BITS*   = 0x00021007
  ACCUM_GREEN_BITS* = 0x00021008
  ACCUM_BLUE_BITS*  = 0x00021009
  ACCUM_ALPHA_BITS* = 0x0002100A
  AUX_BUFFERS*      = 0x0002100B
  STEREO*           = 0x0002100C
  SAMPLES*          = 0x0002100D
  SRGB_CAPABLE*     = 0x0002100E
  REFRESH_RATE*     = 0x0002100F
  DOUBLEBUFFER*     = 0x00021010

const
  CLIENT_API*               = 0x00022001
  CONTEXT_VERSION_MAJOR*    = 0x00022002
  CONTEXT_VERSION_MINOR*    = 0x00022003
  CONTEXT_REVISION*         = 0x00022004
  CONTEXT_ROBUSTNESS*       = 0x00022005
  OPENGL_FORWARD_COMPAT*    = 0x00022006
  OPENGL_DEBUG_CONTEXT*     = 0x00022007
  OPENGL_PROFILE*           = 0x00022008
  CONTEXT_RELEASE_BEHAVIOR* = 0x00022009
  CONTEXT_NO_ERROR*         = 0x0002200A
  CONTEXT_CREATION_API*     = 0x0002200B

const
  SCALE_TO_MONITOR*         = 0x0002200C
  COCOA_RETINA_FRAMEBUFFER* = 0x00023001
  COCOA_FRAME_NAME*         = 0x00023002
  COCOA_GRAPHICS_SWITCHING* = 0x00023003
  X11_CLASS_NAME*           = 0x00024001
  X11_INSTANCE_NAME*        = 0x00024002
  WIN32_KEYBOARD_MENU*      = 0x00025001

const
  NO_API*        = 0
  OPENGL_API*    = 0x00030001
  OPENGL_ES_API* = 0x00030002

const
  NO_ROBUSTNESS*         = 0
  NO_RESET_NOTIFICATION* = 0x00031001
  LOSE_CONTEXT_ON_RESET* = 0x00031002

const
  OPENGL_ANY_PROFILE*    = 0
  OPENGL_CORE_PROFILE*   = 0x00032001
  OPENGL_COMPAT_PROFILE* = 0x00032002

const
  CURSOR*               = 0x00033001
  STICKY_KEYS*          = 0x00033002
  STICKY_MOUSE_BUTTONS* = 0x00033003
  LOCK_KEY_MODS*        = 0x00033004
  RAW_MOUSE_MOTION*     = 0x00033005

const
  CURSOR_NORMAL*   = 0x00034001
  CURSOR_HIDDEN*   = 0x00034002
  CURSOR_DISABLED* = 0x00034003

const
  ANY_RELEASE_BEHAVIOR*   = 0
  RELEASE_BEHAVIOR_FLUSH* = 0x00035001
  RELEASE_BEHAVIOR_NONE*  = 0x00035002

const
  NATIVE_CONTEXT_API* = 0x00036001
  EGL_CONTEXT_API*    = 0x00036002
  OSMESA_CONTEXT_API* = 0x00036003

const
  ANGLE_PLATFORM_TYPE_NONE*     = 0x00037001
  ANGLE_PLATFORM_TYPE_OPENGL*   = 0x00037002
  ANGLE_PLATFORM_TYPE_OPENGLES* = 0x00037003
  ANGLE_PLATFORM_TYPE_D3D9*     = 0x00037004
  ANGLE_PLATFORM_TYPE_D3D11*    = 0x00037005
  ANGLE_PLATFORM_TYPE_VULKAN*   = 0x00037007
  ANGLE_PLATFORM_TYPE_METAL*    = 0x00037008

const
  ARROW_CURSOR*         = 0x00036001
  IBEAM_CURSOR*         = 0x00036002
  CROSSHAIR_CURSOR*     = 0x00036003
  POINTING_HAND_CURSOR* = 0x00036004
  RESIZE_EW_CURSOR*     = 0x00036005
  RESIZE_NS_CURSOR*     = 0x00036006
  RESIZE_NWSE_CURSOR*   = 0x00036007
  RESIZE_NESW_CURSOR*   = 0x00036008
  RESIZE_ALL_CURSOR*    = 0x00036009
  NOT_ALLOWED_CURSOR*   = 0x0003600A
  HRESIZE_CURSOR*       = RESIZE_EW_CURSOR
  VRESIZE_CURSOR*       = RESIZE_NS_CURSOR
  HAND_CURSOR*          = POINTING_HAND_CURSOR

const
  CONNECTED*    = 0x00040001
  DISCONNECTED* = 0x00040002

const
  JOYSTICK_HAT_BUTTONS* = 0x00050001
  ANGLE_PLATFORM_TYPE*  = 0x00050002

const
  COCOA_CHDIR_RESOURCES* = 0x00051001
  COCOA_MENUBAR*         = 0x00051002

const
  DONT_CARE* = -1

#-------------------------------------------------------------------------------

type
  Glproc*        = proc() {.cdecl.}
  Vkproc*        = proc() {.cdecl.}
  Monitor*       = pointer
  Window*        = pointer
  CursorHandle*  = pointer

type
  ErrorFun*              = proc (errorCode: cint, description: cstring) {.cdecl.}
  WindowPosFun*          = proc (window: Window, x: cint, y: cint) {.cdecl.}
  WindowSizeFun*         = proc (window: Window, width: cint, height: cint) {.cdecl.}
  WindowCloseFun*        = proc (window: Window) {.cdecl.}
  WindowRefreshFun*      = proc (window: Window) {.cdecl.}
  WindowFocusFun*        = proc (window: Window, focused: cint) {.cdecl.}
  WindowIconifyFun*      = proc (window: Window, iconified: cint) {.cdecl.}
  WindowMaximizeFun*     = proc (window: Window, maximized: cint) {.cdecl.}
  FrameBufferSizeFun*    = proc (window: Window, width: cint, height: cint) {.cdecl.}
  WindowContentScaleFun* = proc (window: Window, xscale: cfloat, yscale: cfloat) {.cdecl.}
  MouseButtonFun*        = proc (window: Window, button: cint, action: cint, mods: cint) {.cdecl.}
  CursorPosFun*          = proc (window: Window, x: cdouble, y: cdouble) {.cdecl.}
  CursorEnterFun*        = proc (window: Window, entered: cint) {.cdecl.}
  ScrollFun*             = proc (window: Window, xoffset: cdouble, yoffset: cdouble) {.cdecl.}
  KeyFun*                = proc (window: Window, key: cint, scancode: cint, action: cint, mods: cint) {.cdecl.}
  CharFun*               = proc (window: Window, character: cuint) {.cdecl.}
  CharModsFun*           = proc (window: Window, codepoint: cuint, mods: cint) {.cdecl.}
  DropFun*               = proc (window: Window, count: cint, paths: cstringArray) {.cdecl.}
  MonitorFun*            = proc (monitor: Monitor, connected: cint) {.cdecl.}
  JoystickFun*           = proc (jid: cint, event: cint)

type
  VidMode* {.final.} = object
    width*: cint
    height*: cint
    redBits*: cint
    greenBits*: cint
    blueBits*: cint
    refreshRate*: cint

type
  GammaRamp* {.final.} = object
    red*: ptr cushort
    green*: ptr cushort
    blue*: ptr cushort
    size*: cuint

type
  Image* {.final.} = object
    width: cint
    height: cint
    pixels: seq[byte]

type
  GamepadState* {.final.} = object
    buttons: array[15,bool]
    axes: array[6,cfloat]

#-------------------------------------------------------------------------------

proc init*(): cint {.cdecl, importc: "glfwInit".}
proc terminate*() {.cdecl, importc: "glfwTerminate".}
proc initHint*(hint: cint, value: cint) {.cdecl, importc: "glfwInitHint".}
proc getVersion*(major: ptr cint, minor: ptr cint, rev: ptr cint) {.cdecl, importc: "glfwGetVersion".}
proc getVersionString*(): cstring {.cdecl, importc: "glfwGetVersionString".}
proc getError*(description:ptr cstring): cint {.cdecl, importc:"glfwGetError".}
proc setErrorCallback*(callback:ErrorFun): ErrorFun {.cdecl, importc:"glfwSetErrorCallback".}

proc getMonitors*(count: ptr cint): ptr Monitor {.cdecl, importc: "glfwGetMonitors".}
proc getPrimaryMonitor*(): Monitor {.cdecl, importc: "glfwGetPrimaryMonitor".}
proc getMonitorPos*(monitor: Monitor, xpos: ptr cint, ypos: ptr cint) {.cdecl, importc: "glfwGetMonitorPos".}
proc getMonitorWorkarea*(monitor: Monitor, xpos: ptr cint, ypos: ptr cint, width: ptr cint, height: ptr cint) {.cdecl, importc: "glfwGetMonitorWorkarea".}
proc getMonitorPhysicalSize*(monitor: Monitor, widthMM: ptr cint, heightMM: ptr cint) {.cdecl, importc: "glfwGetMonitorPhysicalSize".}
proc getMonitorContentScale*(monitor: Monitor, xscale: ptr cfloat, yscale: ptr cfloat) {.cdecl, importc: "glfwGetMonitorContentScale".}
proc getMonitorName*(monitor: Monitor): cstring {.cdecl, importc: "glfwGetMonitorName".}
proc setMonitorUserPointer*(monitor: Monitor, data: pointer) {.cdecl, importc: "glfwSetMonitorUserPointer".}
proc getMonitorUserPointer*(monitor: Monitor): pointer {.cdecl, importc: "glfwGetMonitorUserPointer".}
proc setMonitorCallback*(cbfun: MonitorFun): MonitorFun {.cdecl, importc: "glfwSetMonitorCallback".}
proc getVideoModes*(monitor: Monitor, count: ptr cint): ptr VidMode {.cdecl, importc: "glfwGetVideoModes".}
proc getVideoMode*(monitor: Monitor): ptr VidMode {.cdecl, importc: "glfwGetVideoMode".}
proc setGamma*(monitor: Monitor, gamma: cfloat) {.cdecl, importc: "glfwSetGamma".}
proc getGammaRamp*(monitor: Monitor): ptr GammaRamp {.cdecl, importc: "glfwGetGammaRamp".}
proc setGammaRamp*(monitor: Monitor, ramp: ptr GammaRamp) {.cdecl, importc: "glfwSetGammaRamp".}

proc defaultWindowHints*() {.cdecl, importc: "glfwDefaultWindowHints".}
proc windowHint*(target: cint, hint: cint) {.cdecl, importc: "glfwWindowHint".}
proc windowHintString*(hint: cint, value: cstring) {.cdecl, importc: "glfwWindowHintString".}
proc createWindow*(width: cint, height: cint, title: cstring, monitor: Monitor, share: Window): Window{.cdecl, importc: "glfwCreateWindow".}
proc destroyWindow*(window: Window) {.cdecl, importc: "glfwDestroyWindow".}
proc windowShouldClose*(window: Window): cint {.cdecl, importc: "glfwWindowShouldClose".}
proc setWindowShouldClose*(window: Window, value: cint) {.cdecl, importc: "glfwSetWindowShouldClose".}
proc setWindowTitle*(window: Window, title: cstring) {.cdecl, importc: "glfwSetWindowTitle".}
proc setWindowIcon*(window: Window, count: cint, image: ptr Image) {.cdecl, importc: "glfwSetWindowIcon".}
proc getWindowPos*(window: Window, xpos: ptr cint, ypos: ptr cint) {.cdecl, importc: "glfwGetWindowPos".}
proc setWindowPos*(window: Window, xpos: cint, ypos: cint) {.cdecl, importc: "glfwSetWindowPos".}
proc getWindowSize*(window: Window, width: ptr cint, height: ptr cint) {.cdecl, importc: "glfwGetWindowSize".}
proc setWindowSizeLimits*(window: Window, minwidth, minheight, maxwidth, maxheight: cint) {.cdecl, importc: "glfwSetWindowSizeLimits".}
proc setWindowAspectRatio*(window: Window, numer, denom: cint) {.cdecl, importc: "glfwSetWindowAspectRatio".}
proc setWindowSize*(window: Window, width: cint, height: cint) {.cdecl, importc: "glfwSetWindowSize".}
proc getFramebufferSize*(window: Window, width: ptr cint, height: ptr cint) {.cdecl, importc: "glfwGetFramebufferSize".}
proc getWindowFrameSize*(window: Window, left, top, right, bottom: ptr int) {.cdecl, importc: "glfwGetWindowFrameSize".}
proc getWindowContentScale*(window: Window, xscale: ptr cfloat, yscale: ptr cfloat) {.cdecl, importc: "glfwGetWindowContentScale".}
proc getWindowOpacity*(window: Window): cfloat {.cdecl, importc: "glfwGetWindowOpacity".}
proc setWindowOpacity*(window: Window, opacity: cfloat) {.cdecl, importc: "glfwSetWindowOpacity".}
proc iconifyWindow*(window: Window) {.cdecl, importc: "glfwIconifyWindow".}
proc restoreWindow*(window: Window) {.cdecl, importc: "glfwRestoreWindow".}
proc maximizeWindow*(window: Window) {.cdecl, importc: "glfwMaximizeWindow".}
proc showWindow*(window: Window) {.cdecl, importc: "glfwShowWindow".}
proc hideWindow*(window: Window) {.cdecl, importc: "glfwHideWindow".}
proc focusWindow*(window: Window) {.cdecl, importc: "glfwFocusWindow".}
proc requestWindowAttention*(window: Window) {.cdecl, importc: "glfwRequestWindowAttention".}
proc getWindowMonitor*(window: Window): Monitor {.cdecl, importc: "glfwGetWindowMonitor".}
proc setWindowMonitor*(window: Window, monitor: Monitor, xpos, ypos, width, height: cint) {.cdecl, importc: "glfwSetWindowMonitor".}
proc getWindowAttrib*(window: Window, attrib: cint): cint {.cdecl, importc: "glfwGetWindowAttrib".}
proc setWindowAttrib*(window: Window, attrib: cint, value: cint) {.cdecl, importc: "glfwSetWindowAttrib".}
proc setWindowUserPointer*(window: Window, pointer: pointer) {.cdecl, importc: "glfwSetWindowUserPointer".}
proc getWindowUserPointer*(window: Window): pointer {.cdecl, importc: "glfwGetWindowUserPointer".}
proc setWindowPosCallback*(window: Window, cbfun: WindowPosFun): WindowPosFun {.cdecl, importc: "glfwSetWindowPosCallback".}
proc setWindowSizeCallback*(window: Window, cbfun: WindowSizeFun): WindowSizeFun {.cdecl, importc: "glfwSetWindowSizeCallback".}
proc setWindowCloseCallback*(window: Window, cbfun: WindowCloseFun): WindowCloseFun {.cdecl, importc: "glfwSetWindowCloseCallback".}
proc setWindowRefreshCallback*(window: Window, cbfun: Windowrefreshfun): Windowrefreshfun {.cdecl, importc: "glfwSetWindowRefreshCallback".}
proc setWindowFocusCallback*(window: Window, cbfun: WindowFocusFun): WindowFocusFun {.cdecl, importc: "glfwSetWindowFocusCallback".}
proc setWindowIconifyCallback*(window: Window, cbfun: WindowIconifyFun): WindowIconifyFun {.cdecl, importc: "glfwSetWindowIconifyCallback".}
proc setWindowMaximizeCallback*(window: Window, callback: WindowMaximizeFun): WindowMaximizeFun {.cdecl, importc: "glfwSetWindowMaximizeCallback".}
proc setFramebufferSizeCallback*(window: Window, cbfun: FrameBufferSizeFun): FrameBufferSizeFun {.cdecl, importc: "glfwSetFramebufferSizeCallback".}
proc setWindowContentScaleCallback*(window: Window, callback: WindowContentScaleFun): WindowContentScaleFun {.cdecl, importc: "glfwSetWindowContentScaleCallback".}

proc pollEvents*() {.cdecl, importc: "glfwPollEvents".}
proc waitEvents*() {.cdecl, importc: "glfwWaitEvents".}
proc waitEventsTimeout*(timeout: cdouble) {.cdecl, importc: "glfwWaitEventsTimeout".}
proc postEmptyEvent*() {.cdecl, importc: "glfwPostEmptyEvent".}

proc getInputMode*(window: Window, mode: cint): cint {.cdecl, importc: "glfwGetInputMode".}
proc setInputMode*(window: Window, mode: cint, value: cint) {.cdecl, importc: "glfwSetInputMode".}
proc rawMouseMotionSupported*(): cint {.cdecl, importc: "glfwRawMouseMotionSupported".}
proc getKeyName*(key: cint, scanmode: cint): cstring {.cdecl, importc: "glfwGetKeyName".}
proc getKeyScancode*(key: cint): cint {.cdecl, importc: "glfwGetKeyScancode".}
proc getKey*(window: Window, key: cint): cint {.cdecl, importc: "glfwGetKey".}
proc getMouseButton*(window: Window, button: cint): cint {.cdecl, importc: "glfwGetMouseButton".}

proc getCursorPos*(window: Window, xpos: ptr cdouble, ypos: ptr cdouble) {.cdecl, importc: "glfwGetCursorPos".}
proc setCursorPos*(window: Window, xpos: cdouble, ypos: cdouble) {.cdecl, importc: "glfwSetCursorPos".}
proc createCursor*(image: ptr Image, xhot, yhot: cint): CursorHandle {.cdecl, importc: "glfwCreateCursor".}
proc createStandardCursor*(shape: cint): CursorHandle {.cdecl, importc: "glfwCreateStandardCursor".}
proc destroyCursor*(cusor: CursorHandle) {.cdecl, importc: "glfwDestroyCursor".}
proc setCursor*(window: Window, cursor: CursorHandle) {.cdecl, importc: "glfwSetCursor".}

proc setKeyCallback*(window: Window, cbfun: KeyFun): KeyFun {.cdecl, importc: "glfwSetKeyCallback".}
proc setCharCallback*(window: Window, cbfun: CharFun): CharFun {.cdecl, importc: "glfwSetCharCallback".}
proc setCharModsCallback*(window: Window, cbfun: CharModsFun): CharModsFun {.cdecl, importc: "glfwSetCharModsCallback".}
proc setMouseButtonCallback*(window: Window, cbfun: MouseButtonFun): MouseButtonFun {.cdecl, importc: "glfwSetMouseButtonCallback".}
proc setCursorPosCallback*(window: Window, cbfun: CursorPosFun): CursorPosFun {.cdecl, importc: "glfwSetCursorPosCallback".}
proc setCursorEnterCallback*(window: Window, cbfun: CursorEnterFun): CursorEnterFun {.cdecl, importc: "glfwSetCursorEnterCallback".}
proc setScrollCallback*(window: Window, cbfun: ScrollFun): ScrollFun {.cdecl, importc: "glfwSetScrollCallback".}
proc setDropCallback*(window: Window, cbfun: DropFun) {.cdecl, importc: "glfwSetDropCallback".}

proc joystickPresent*(joy: cint): cint {.cdecl, importc: "glfwJoystickPresent".}
proc getJoystickAxes*(joy: cint, count: ptr cint): ptr cfloat {.cdecl, importc: "glfwGetJoystickAxes".}
proc getJoystickButtons*(joy: cint, count: ptr cint): ptr cuchar {.cdecl, importc: "glfwGetJoystickButtons".}
proc getJoystickHats*(jid: cint, count: ptr cint): ptr cuchar {.cdecl, importc: "glfwGetJoystickHats".}
proc getJoystickName*(joy: cint): cstring {.cdecl, importc: "glfwGetJoystickName".}
proc getJoystickGUID*(jid: cint): cstring {.cdecl, importc: "glfwGetJoystickGUID".}
proc setJoystickUserPointer*(jid: cint, data: pointer) {.cdecl, importc: "glfwSetJoystickUserPointer".}
proc getJoystickUserPointer*(jid: cint): pointer {.cdecl, importc: "glfwGetJoystickUserPointer".}
proc joystickIsGamepad*(jid: cint): cint {.cdecl, importc: "glfwJoystickIsGamepad".}
proc setJoystickCallback*(cbfun: JoystickFun): JoystickFun {.cdecl, importc: "glfwSetJoystickCallback".}
proc updateGamepadMappings*(mappings: cstring): cint {.cdecl, importc: "glfwUpdateGamepadMappings".}
proc getGamepadName*(jid: cint): cstring {.cdecl, importc: "glfwGetGamepadName".}
proc getGamepadState*(jid: cint, state: ptr GamepadState): cint {.cdecl, importc: "glfwGetGamepadState".}

proc setClipboardString*(window: Window, string: cstring) {.cdecl, importc: "glfwSetClipboardString".}
proc getClipboardString*(window: Window): cstring {.cdecl, importc: "glfwGetClipboardString".}

proc getTime*(): cdouble {.cdecl, importc: "glfwGetTime".}
proc setTime*(time: cdouble) {.cdecl, importc: "glfwSetTime".}
proc getTimerValue*(): culonglong {.cdecl, importc: "glfwGetTimerValue".}
proc getTimerFrequency*(): culonglong {.cdecl, importc: "glfwGetTimerFrequency".}

proc makeContextCurrent*(window: Window) {.cdecl, importc: "glfwMakeContextCurrent".}
proc getCurrentContext*(): Window {.cdecl, importc: "glfwGetCurrentContext".}

proc swapBuffers*(window: Window) {.cdecl, importc: "glfwSwapBuffers".}
proc swapInterval*(interval: cint) {.cdecl, importc: "glfwSwapInterval".}

proc extensionSupported*(extension: cstring): cint {.cdecl, importc: "glfwExtensionSupported".}
proc getProcAddress*(procname: cstring): GLProc {.cdecl, importc: "glfwGetProcAddress".}

# Vulkan types & functions
type
  VkInstance* = pointer
  VkPhysicalDevice* = pointer
  VkAllocationCallbacks* = pointer
  VkSurfaceKHR* = pointer
  VkResult* = enum
    VK_ERROR_FRAGMENTED_POOL = -12
    VK_ERROR_FORMAT_NOT_SUPPORTED = -11
    VK_ERROR_TOO_MANY_OBJECTS = -10
    VK_ERROR_INCOMPATIBLE_DRIVER = -9
    VK_ERROR_FEATURE_NOT_PRESENT = -8
    VK_ERROR_EXTENSION_NOT_PRESENT = -7
    VK_ERROR_LAYER_NOT_PRESENT = -6
    VK_ERROR_MEMORY_MAP_FAILED = -5
    VK_ERROR_DEVICE_LOST = -4
    VK_ERROR_INITIALIZATION_FAILED = -3
    VK_ERROR_OUT_OF_DEVICE_MEMORY = -2
    VK_ERROR_OUT_OF_HOST_MEMORY = -1
    VK_SUCCESS = 0
    VK_NOT_READY = 1
    VK_TIMEOUT = 2
    VK_EVENT_SET = 3
    VK_EVENT_RESET = 4
    VK_INCOMPLETE = 5

proc vulkanSupported*(): cint {.cdecl, importc: "glfwVulkanSupported".}
proc getRequiredInstanceExtensions*(count: ptr cuint): ptr cstring {.cdecl, importc: "glfwGetRequiredInstanceExtensions".}
proc getInstanceProcAddress*(instance: VkInstance, procname: cstring): VKProc {.cdecl, importc: "glfwGetInstanceProcAddress".}
proc getPhysicalDevicePresentationSupport*(instance: VkInstance, device: VkPhysicalDevice, queuefamily: cuint): cint {.cdecl, importc: "glfwGetPhysicalDevicePresentationSupport".}
proc createWindowSurface*(instance: VkInstance, window: Window, allocator: ptr VkAllocationCallbacks, surface: ptr VkSurfaceKHR): VkResult {.cdecl, importc: "glfwCreateWindowSurface".}

# todo: glfw3native.h

when isMainModule:
  import opengl

  # Init GLFW
  if init() == 0:
    raise newException(Exception, "Failed to Initialize GLFW")

  # Open window.
  var window = createWindow(800, 600, "glfw.nim", nil, nil)

  # Connect the GL context.
  window.makeContextCurrent()

  # This must be called to make any GL function work
  loadExtensions()

  # Run while window is open.
  while windowShouldClose(window) == 0:

    # Draw red color screen.
    glClearColor(100/255f, 149/255f, 237/255f, 1)
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
