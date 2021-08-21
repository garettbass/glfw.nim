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
        passL: "-lshell32"
        passL: "-luser32"
      .}
    when defined(vcc):
      {.
        link: "kernel32.lib"
        link: "gdi32.lib"
        link: "shell32.lib"
        link: "user32.lib"
      .}
    {.
      passC: "-D_GLFW_WIN32"
      passC: "-DGLFW_EXPOSE_NATIVE_WIN32"
      compile: ".glfw/src/egl_context.c"
      compile: ".glfw/src/osmesa_context.c"
      compile: ".glfw/src/wgl_context.c"
      compile: ".glfw/src/win32_init.c"
      compile: ".glfw/src/win32_joystick.c"
      compile: ".glfw/src/win32_monitor.c"
      compile: ".glfw/src/win32_thread.c"
      compile: ".glfw/src/win32_time.c"
      compile: ".glfw/src/win32_window.c"
    .}
  elif defined(macosx):
    {.
      passC: "-D_GLFW_COCOA"
      passC: "-DGLFW_EXPOSE_NATIVE_COCOA"
      passL: "-framework Cocoa"
      passL: "-framework OpenGL"
      passL: "-framework IOKit"
      passL: "-framework CoreVideo"
      compile: ".glfw/src/cocoa_init.m"
      compile: ".glfw/src/cocoa_joystick.m"
      compile: ".glfw/src/cocoa_monitor.m"
      compile: ".glfw/src/cocoa_time.c"
      compile: ".glfw/src/cocoa_window.m"
      compile: ".glfw/src/egl_context.c"
      compile: ".glfw/src/nsgl_context.m"
      compile: ".glfw/src/osmesa_context.c"
      compile: ".glfw/src/posix_thread.c"
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
        passC: "-DGLFW_EXPOSE_NATIVE_WAYLAND"
        compile: ".glfw/src/egl_context.c"
        compile: ".glfw/src/osmesa_context.c"
        compile: ".glfw/src/posix_thread.c"
        compile: ".glfw/src/posix_time.c"
        compile: ".glfw/src/wl_init.c"
        compile: ".glfw/src/wl_monitor.c"
        compile: ".glfw/src/wl_window.c"
        compile: ".glfw/src/xkb_unicode.c"
      .}
    else:
      {.
        passC: "-D_GLFW_X11"
        passC: "-DGLFW_EXPOSE_NATIVE_X11"
        compile: ".glfw/src/egl_context.c"
        compile: ".glfw/src/glx_context.c"
        compile: ".glfw/src/osmesa_context.c"
        compile: ".glfw/src/posix_thread.c"
        compile: ".glfw/src/posix_time.c"
        compile: ".glfw/src/x11_init.c"
        compile: ".glfw/src/x11_monitor.c"
        compile: ".glfw/src/x11_window.c"
        compile: ".glfw/src/xkb_unicode.c"
      .}
    {.
      compile: ".glfw/src/linux_joystick.c"
    .}
  else:
    # If unsupported/unknown OS, use null system
    {.
      compile: ".glfw/src/null_init.c",
      compile: ".glfw/src/null_joystick.c",
      compile: ".glfw/src/null_monitor.c",
      compile: ".glfw/src/null_window.c",
      compile: ".glfw/src/osmesa_context.c"
      compile: ".glfw/src/posix_thread.c",
      compile: ".glfw/src/posix_time.c",
    .}
  {.
    compile: ".glfw/src/context.c",
    compile: ".glfw/src/init.c",
    compile: ".glfw/src/input.c",
    compile: ".glfw/src/monitor.c",
    compile: ".glfw/src/vulkan.c",
    compile: ".glfw/src/window.c"
  .}

#-------------------------------------------------------------------------------

const
  GLFW_VERSION_MAJOR*    = 3
  GLFW_VERSION_MINOR*    = 4
  GLFW_VERSION_REVISION* = 0

const
  GLFW_TRUE*  = 1
  GLFW_FALSE* = 0

const
  GLFW_RELEASE* = 0
  GLFW_PRESS*   = 1
  GLFW_REPEAT*  = 2

const
  GLFW_HAT_CENTERED*   = 0
  GLFW_HAT_UP*         = 1
  GLFW_HAT_RIGHT*      = 2
  GLFW_HAT_DOWN*       = 4
  GLFW_HAT_LEFT*       = 8
  GLFW_HAT_RIGHT_UP*   = 3
  GLFW_HAT_RIGHT_DOWN* = 6
  GLFW_HAT_LEFT_UP*    = 9
  GLFW_HAT_LEFT_DOWN*  = 12

const
  GLFW_KEY_UNKNOWN*        = -1
  GLFW_KEY_SPACE*          = 32
  GLFW_KEY_APOSTROPHE*     = 39
  GLFW_KEY_COMMA*          = 44
  GLFW_KEY_MINUS*          = 45
  GLFW_KEY_PERIOD*         = 46
  GLFW_KEY_SLASH*          = 47
  GLFW_KEY_0*              = 48
  GLFW_KEY_1*              = 49
  GLFW_KEY_2*              = 50
  GLFW_KEY_3*              = 51
  GLFW_KEY_4*              = 52
  GLFW_KEY_5*              = 53
  GLFW_KEY_6*              = 54
  GLFW_KEY_7*              = 55
  GLFW_KEY_8*              = 56
  GLFW_KEY_9*              = 57
  GLFW_KEY_SEMICOLON*      = 59
  GLFW_KEY_EQUAL*          = 61
  GLFW_KEY_A*              = 65
  GLFW_KEY_B*              = 66
  GLFW_KEY_C*              = 67
  GLFW_KEY_D*              = 68
  GLFW_KEY_E*              = 69
  GLFW_KEY_F*              = 70
  GLFW_KEY_G*              = 71
  GLFW_KEY_H*              = 72
  GLFW_KEY_I*              = 73
  GLFW_KEY_J*              = 74
  GLFW_KEY_K*              = 75
  GLFW_KEY_L*              = 76
  GLFW_KEY_M*              = 77
  GLFW_KEY_N*              = 78
  GLFW_KEY_O*              = 79
  GLFW_KEY_P*              = 80
  GLFW_KEY_Q*              = 81
  GLFW_KEY_R*              = 82
  GLFW_KEY_S*              = 83
  GLFW_KEY_T*              = 84
  GLFW_KEY_U*              = 85
  GLFW_KEY_V*              = 86
  GLFW_KEY_W*              = 87
  GLFW_KEY_X*              = 88
  GLFW_KEY_Y*              = 89
  GLFW_KEY_Z*              = 90
  GLFW_KEY_LEFT_BRACKET*   = 91
  GLFW_KEY_BACKSLASH*      = 92
  GLFW_KEY_RIGHT_BRACKET*  = 93
  GLFW_KEY_GRAVE_ACCENT*   = 96
  GLFW_KEY_WORLD_1*        = 161
  GLFW_KEY_WORLD_2*        = 162
  GLFW_KEY_ESCAPE*         = 256
  GLFW_KEY_ENTER*          = 257
  GLFW_KEY_TAB*            = 258
  GLFW_KEY_BACKSPACE*      = 259
  GLFW_KEY_INSERT*         = 260
  GLFW_KEY_DELETE*         = 261
  GLFW_KEY_RIGHT*          = 262
  GLFW_KEY_LEFT*           = 263
  GLFW_KEY_DOWN*           = 264
  GLFW_KEY_UP*             = 265
  GLFW_KEY_PAGE_UP*        = 266
  GLFW_KEY_PAGE_DOWN*      = 267
  GLFW_KEY_HOME*           = 268
  GLFW_KEY_END*            = 269
  GLFW_KEY_CAPS_LOCK*      = 280
  GLFW_KEY_SCROLL_LOCK*    = 281
  GLFW_KEY_NUM_LOCK*       = 282
  GLFW_KEY_PRINT_SCREEN*   = 283
  GLFW_KEY_PAUSE*          = 284
  GLFW_KEY_F1*             = 290
  GLFW_KEY_F2*             = 291
  GLFW_KEY_F3*             = 292
  GLFW_KEY_F4*             = 293
  GLFW_KEY_F5*             = 294
  GLFW_KEY_F6*             = 295
  GLFW_KEY_F7*             = 296
  GLFW_KEY_F8*             = 297
  GLFW_KEY_F9*             = 298
  GLFW_KEY_F10*            = 299
  GLFW_KEY_F11*            = 300
  GLFW_KEY_F12*            = 301
  GLFW_KEY_F13*            = 302
  GLFW_KEY_F14*            = 303
  GLFW_KEY_F15*            = 304
  GLFW_KEY_F16*            = 305
  GLFW_KEY_F17*            = 306
  GLFW_KEY_F18*            = 307
  GLFW_KEY_F19*            = 308
  GLFW_KEY_F20*            = 309
  GLFW_KEY_F21*            = 310
  GLFW_KEY_F22*            = 311
  GLFW_KEY_F23*            = 312
  GLFW_KEY_F24*            = 313
  GLFW_KEY_F25*            = 314
  GLFW_KEY_KP_0*           = 320
  GLFW_KEY_KP_1*           = 321
  GLFW_KEY_KP_2*           = 322
  GLFW_KEY_KP_3*           = 323
  GLFW_KEY_KP_4*           = 324
  GLFW_KEY_KP_5*           = 325
  GLFW_KEY_KP_6*           = 326
  GLFW_KEY_KP_7*           = 327
  GLFW_KEY_KP_8*           = 328
  GLFW_KEY_KP_9*           = 329
  GLFW_KEY_KP_DECIMAL*     = 330
  GLFW_KEY_KP_DIVIDE*      = 331
  GLFW_KEY_KP_MULTIPLY*    = 332
  GLFW_KEY_KP_SUBTRACT*    = 333
  GLFW_KEY_KP_ADD*         = 334
  GLFW_KEY_KP_ENTER*       = 335
  GLFW_KEY_KP_EQUAL*       = 336
  GLFW_KEY_LEFT_SHIFT*     = 340
  GLFW_KEY_LEFT_CONTROL*   = 341
  GLFW_KEY_LEFT_ALT*       = 342
  GLFW_KEY_LEFT_SUPER*     = 343
  GLFW_KEY_RIGHT_SHIFT*    = 344
  GLFW_KEY_RIGHT_CONTROL*  = 345
  GLFW_KEY_RIGHT_ALT*      = 346
  GLFW_KEY_RIGHT_SUPER*    = 347
  GLFW_KEY_MENU*           = 348
  GLFW_KEY_LAST*           = GLFW_KEY_MENU

const
  GLFW_MOD_SHIFT*    = 0x0001
  GLFW_MOD_CONTROL*  = 0x0002
  GLFW_MOD_ALT*      = 0x0004
  GLFW_MOD_SUPER*    = 0x0008

const
  GLFW_MOUSE_BUTTON_1*      = 0
  GLFW_MOUSE_BUTTON_2*      = 1
  GLFW_MOUSE_BUTTON_3*      = 2
  GLFW_MOUSE_BUTTON_4*      = 3
  GLFW_MOUSE_BUTTON_5*      = 4
  GLFW_MOUSE_BUTTON_6*      = 5
  GLFW_MOUSE_BUTTON_7*      = 6
  GLFW_MOUSE_BUTTON_8*      = 7
  GLFW_MOUSE_BUTTON_LAST*   = GLFW_MOUSE_BUTTON_8
  GLFW_MOUSE_BUTTON_LEFT*   = GLFW_MOUSE_BUTTON_1
  GLFW_MOUSE_BUTTON_RIGHT*  = GLFW_MOUSE_BUTTON_2
  GLFW_MOUSE_BUTTON_MIDDLE* = GLFW_MOUSE_BUTTON_3

const
  GLFW_JOYSTICK_1*    = 0
  GLFW_JOYSTICK_2*    = 1
  GLFW_JOYSTICK_3*    = 2
  GLFW_JOYSTICK_4*    = 3
  GLFW_JOYSTICK_5*    = 4
  GLFW_JOYSTICK_6*    = 5
  GLFW_JOYSTICK_7*    = 6
  GLFW_JOYSTICK_8*    = 7
  GLFW_JOYSTICK_9*    = 8
  GLFW_JOYSTICK_10*   = 9
  GLFW_JOYSTICK_11*   = 10
  GLFW_JOYSTICK_12*   = 11
  GLFW_JOYSTICK_13*   = 12
  GLFW_JOYSTICK_14*   = 13
  GLFW_JOYSTICK_15*   = 14
  GLFW_JOYSTICK_16*   = 15
  GLFW_JOYSTICK_LAST* = GLFW_JOYSTICK_16

const
  GLFW_GAMEPAD_BUTTON_A*            = 0
  GLFW_GAMEPAD_BUTTON_B*            = 1
  GLFW_GAMEPAD_BUTTON_X*            = 2
  GLFW_GAMEPAD_BUTTON_Y*            = 3
  GLFW_GAMEPAD_BUTTON_LEFT_BUMPER*  = 4
  GLFW_GAMEPAD_BUTTON_RIGHT_BUMPER* = 5
  GLFW_GAMEPAD_BUTTON_BACK*         = 6
  GLFW_GAMEPAD_BUTTON_START*        = 7
  GLFW_GAMEPAD_BUTTON_GUIDE*        = 8
  GLFW_GAMEPAD_BUTTON_LEFT_THUMB*   = 9
  GLFW_GAMEPAD_BUTTON_RIGHT_THUMB*  = 10
  GLFW_GAMEPAD_BUTTON_DPAD_UP*      = 11
  GLFW_GAMEPAD_BUTTON_DPAD_RIGHT*   = 12
  GLFW_GAMEPAD_BUTTON_DPAD_DOWN*    = 13
  GLFW_GAMEPAD_BUTTON_DPAD_LEFT*    = 14
  GLFW_GAMEPAD_BUTTON_LAST*         = GLFW_GAMEPAD_BUTTON_DPAD_LEFT
  GLFW_GAMEPAD_BUTTON_CROSS*        = GLFW_GAMEPAD_BUTTON_A
  GLFW_GAMEPAD_BUTTON_CIRCLE*       = GLFW_GAMEPAD_BUTTON_B
  GLFW_GAMEPAD_BUTTON_SQUARE*       = GLFW_GAMEPAD_BUTTON_X
  GLFW_GAMEPAD_BUTTON_TRIANGLE*     = GLFW_GAMEPAD_BUTTON_Y

const
  GLFW_GAMEPAD_AXIS_LEFT_X*         = 0
  GLFW_GAMEPAD_AXIS_LEFT_Y*         = 1
  GLFW_GAMEPAD_AXIS_RIGHT_X*        = 2
  GLFW_GAMEPAD_AXIS_RIGHT_Y*        = 3
  GLFW_GAMEPAD_AXIS_LEFT_TRIGGER*   = 4
  GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER*  = 5
  GLFW_GAMEPAD_AXIS_LAST*           = GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER

const
  GLFW_NO_ERROR*              = 0
  GLFW_NOT_INITIALIZED*       = 0x00010001
  GLFW_NO_CURRENT_CONTEXT*    = 0x00010002
  GLFW_INVALID_ENUM*          = 0x00010003
  GLFW_INVALID_VALUE*         = 0x00010004
  GLFW_OUT_OF_MEMORY*         = 0x00010005
  GLFW_API_UNAVAILABLE*       = 0x00010006
  GLFW_VERSION_UNAVAILABLE*   = 0x00010007
  GLFW_PLATFORM_ERROR*        = 0x00010008
  GLFW_FORMAT_UNAVAILABLE*    = 0x00010009
  GLFW_NO_WINDOW_CONTEXT*     = 0x0001000A
  GLFW_CURSOR_UNAVAILABLE*    = 0x0001000B
  GLFW_FEATURE_UNAVAILABLE*   = 0x0001000C
  GLFW_FEATURE_UNIMPLEMENTED* = 0x0001000D

const
  GLFW_FOCUSED*                 = 0x00020001
  GLFW_ICONIFIED*               = 0x00020002
  GLFW_RESIZABLE*               = 0x00020003
  GLFW_VISIBLE*                 = 0x00020004
  GLFW_DECORATED*               = 0x00020005
  GLFW_AUTO_ICONIFY*            = 0x00020006
  GLFW_FLOATING*                = 0x00020007
  GLFW_MAXIMIZED*               = 0x00020008
  GLFW_CENTER_CURSOR*           = 0x00020009
  GLFW_TRANSPARENT_FRAMEBUFFER* = 0x0002000A
  GLFW_HOVERED*                 = 0x0002000B
  GLFW_FOCUS_ON_SHOW*           = 0x0002000C
  GLFW_MOUSE_PASSTHROUGH*       = 0x0002000D

const
  GLFW_RED_BITS*         = 0x00021001
  GLFW_GREEN_BITS*       = 0x00021002
  GLFW_BLUE_BITS*        = 0x00021003
  GLFW_ALPHA_BITS*       = 0x00021004
  GLFW_DEPTH_BITS*       = 0x00021005
  GLFW_STENCIL_BITS*     = 0x00021006
  GLFW_ACCUM_RED_BITS*   = 0x00021007
  GLFW_ACCUM_GREEN_BITS* = 0x00021008
  GLFW_ACCUM_BLUE_BITS*  = 0x00021009
  GLFW_ACCUM_ALPHA_BITS* = 0x0002100A
  GLFW_AUX_BUFFERS*      = 0x0002100B
  GLFW_STEREO*           = 0x0002100C
  GLFW_SAMPLES*          = 0x0002100D
  GLFW_SRGB_CAPABLE*     = 0x0002100E
  GLFW_REFRESH_RATE*     = 0x0002100F
  GLFW_DOUBLEBUFFER*     = 0x00021010

const
  GLFW_CLIENT_API*               = 0x00022001
  GLFW_CONTEXT_VERSION_MAJOR*    = 0x00022002
  GLFW_CONTEXT_VERSION_MINOR*    = 0x00022003
  GLFW_CONTEXT_REVISION*         = 0x00022004
  GLFW_CONTEXT_ROBUSTNESS*       = 0x00022005
  GLFW_OPENGL_FORWARD_COMPAT*    = 0x00022006
  GLFW_OPENGL_DEBUG_CONTEXT*     = 0x00022007
  GLFW_OPENGL_PROFILE*           = 0x00022008
  GLFW_CONTEXT_RELEASE_BEHAVIOR* = 0x00022009
  GLFW_CONTEXT_NO_ERROR*         = 0x0002200A
  GLFW_CONTEXT_CREATION_API*     = 0x0002200B

const
  GLFW_SCALE_TO_MONITOR*         = 0x0002200C
  GLFW_COCOA_RETINA_FRAMEBUFFER* = 0x00023001
  GLFW_COCOA_FRAME_NAME*         = 0x00023002
  GLFW_COCOA_GRAPHICS_SWITCHING* = 0x00023003
  GLFW_X11_CLASS_NAME*           = 0x00024001
  GLFW_X11_INSTANCE_NAME*        = 0x00024002
  GLFW_WIN32_KEYBOARD_MENU*      = 0x00025001

const
  GLFW_NO_API*        = 0
  GLFW_OPENGL_API*    = 0x00030001
  GLFW_OPENGL_ES_API* = 0x00030002

const
  GLFW_NO_ROBUSTNESS*         = 0
  GLFW_NO_RESET_NOTIFICATION* = 0x00031001
  GLFW_LOSE_CONTEXT_ON_RESET* = 0x00031002

const
  GLFW_OPENGL_ANY_PROFILE*    = 0
  GLFW_OPENGL_CORE_PROFILE*   = 0x00032001
  GLFW_OPENGL_COMPAT_PROFILE* = 0x00032002

const
  GLFW_INPUT_MODE_CURSOR*               = 0x00033001
  GLFW_INPUT_MODE_STICKY_KEYS*          = 0x00033002
  GLFW_INPUT_MODE_STICKY_MOUSE_BUTTONS* = 0x00033003
  GLFW_INPUT_MODE_LOCK_KEY_MODS*        = 0x00033004
  GLFW_INPUT_MODE_RAW_MOUSE_MOTION*     = 0x00033005

const
  GLFW_CURSOR_NORMAL*   = 0x00034001
  GLFW_CURSOR_HIDDEN*   = 0x00034002
  GLFW_CURSOR_DISABLED* = 0x00034003

const
  GLFW_ANY_RELEASE_BEHAVIOR*   = 0
  GLFW_RELEASE_BEHAVIOR_FLUSH* = 0x00035001
  GLFW_RELEASE_BEHAVIOR_NONE*  = 0x00035002

const
  GLFW_NATIVE_CONTEXT_API* = 0x00036001
  GLFW_EGL_CONTEXT_API*    = 0x00036002
  GLFW_OSMESA_CONTEXT_API* = 0x00036003

const
  GLFW_ANGLE_PLATFORM_TYPE_NONE*     = 0x00037001
  GLFW_ANGLE_PLATFORM_TYPE_OPENGL*   = 0x00037002
  GLFW_ANGLE_PLATFORM_TYPE_OPENGLES* = 0x00037003
  GLFW_ANGLE_PLATFORM_TYPE_D3D9*     = 0x00037004
  GLFW_ANGLE_PLATFORM_TYPE_D3D11*    = 0x00037005
  GLFW_ANGLE_PLATFORM_TYPE_VULKAN*   = 0x00037007
  GLFW_ANGLE_PLATFORM_TYPE_METAL*    = 0x00037008

const
  GLFW_ARROW_CURSOR*         = 0x00036001
  GLFW_IBEAM_CURSOR*         = 0x00036002
  GLFW_CROSSHAIR_CURSOR*     = 0x00036003
  GLFW_POINTING_HAND_CURSOR* = 0x00036004
  GLFW_RESIZE_EW_CURSOR*     = 0x00036005
  GLFW_RESIZE_NS_CURSOR*     = 0x00036006
  GLFW_RESIZE_NWSE_CURSOR*   = 0x00036007
  GLFW_RESIZE_NESW_CURSOR*   = 0x00036008
  GLFW_RESIZE_ALL_CURSOR*    = 0x00036009
  GLFW_NOT_ALLOWED_CURSOR*   = 0x0003600A
  GLFW_HRESIZE_CURSOR*       = GLFW_RESIZE_EW_CURSOR
  GLFW_VRESIZE_CURSOR*       = GLFW_RESIZE_NS_CURSOR
  GLFW_HAND_CURSOR*          = GLFW_POINTING_HAND_CURSOR

const
  GLFW_CONNECTED*    = 0x00040001
  GLFW_DISCONNECTED* = 0x00040002

const
  GLFW_JOYSTICK_HAT_BUTTONS* = 0x00050001
  GLFW_ANGLE_PLATFORM_TYPE*  = 0x00050002

const
  GLFW_COCOA_CHDIR_RESOURCES* = 0x00051001
  GLFW_COCOA_MENUBAR*         = 0x00051002

const
  GLFW_DONT_CARE* = -1

#-------------------------------------------------------------------------------

type
  GLFWglproc*  = proc() {.cdecl.}
  GLFWvkproc*  = proc() {.cdecl.}
  GLFWmonitor* = ptr object
  GLFWwindow*  = ptr object
  GLFWcursor*  = ptr object

type
  GLFWerrorfun*              = proc (errorCode: cint, description: cstring) {.cdecl.}
  GLFWwindowposfun*          = proc (window: GLFWwindow, x: cint, y: cint) {.cdecl.}
  GLFWwindowsizefun*         = proc (window: GLFWwindow, width: cint, height: cint) {.cdecl.}
  GLFWwindowclosefun*        = proc (window: GLFWwindow) {.cdecl.}
  GLFWwindowrefreshfun*      = proc (window: GLFWwindow) {.cdecl.}
  GLFWwindowfocusfun*        = proc (window: GLFWwindow, focused: cint) {.cdecl.}
  GLFWwindowiconifyfun*      = proc (window: GLFWwindow, iconified: cint) {.cdecl.}
  GLFWwindowmaximizefun*     = proc (window: GLFWwindow, maximized: cint) {.cdecl.}
  GLFWframebuffersizefun*    = proc (window: GLFWwindow, width: cint, height: cint) {.cdecl.}
  GLFWwindowcontentscalefun* = proc (window: GLFWwindow, xscale: cfloat, yscale: cfloat) {.cdecl.}
  GLFWmousebuttonfun*        = proc (window: GLFWwindow, button: cint, action: cint, mods: cint) {.cdecl.}
  GLFWcursorposfun*          = proc (window: GLFWwindow, x: cdouble, y: cdouble) {.cdecl.}
  GLFWcursorenterfun*        = proc (window: GLFWwindow, entered: cint) {.cdecl.}
  GLFWscrollfun*             = proc (window: GLFWwindow, xoffset: cdouble, yoffset: cdouble) {.cdecl.}
  GLFWkeyfun*                = proc (window: GLFWwindow, key: cint, scancode: cint, action: cint, mods: cint) {.cdecl.}
  GLFWcharfun*               = proc (window: GLFWwindow, character: cuint) {.cdecl.}
  GLFWcharmodsfun*           = proc (window: GLFWwindow, codepoint: cuint, mods: cint) {.cdecl.}
  GLFWdropfun*               = proc (window: GLFWwindow, count: cint, paths: cstringArray) {.cdecl.}
  GLFWmonitorfun*            = proc (monitor: GLFWmonitor, connected: cint) {.cdecl.}
  GLFWjoystickfun*           = proc (jid: cint, event: cint)

type
  GLFWvidmode* {.final.} = object
    width*: cint
    height*: cint
    redBits*: cint
    greenBits*: cint
    blueBits*: cint
    refreshRate*: cint

type
  GLFWgammaramp* {.final.} = object
    red*: ptr cushort
    green*: ptr cushort
    blue*: ptr cushort
    size*: cuint

type
  GLFWimage* {.final.} = object
    width: cint
    height: cint
    pixels: seq[byte]

type
  GLFWgamepadstate* {.final.} = object
    buttons: array[15,bool]
    axes: array[6,cfloat]

#-------------------------------------------------------------------------------

proc glfwInit*(): cint {.cdecl, importc.}
proc glfwTerminate*() {.cdecl, importc.}
proc glfwInitHint*(hint: cint, value: cint) {.cdecl, importc.}
proc glfwGetVersion*(major: ptr cint, minor: ptr cint, rev: ptr cint) {.cdecl, importc.}
proc glfwGetVersionString*(): cstring {.cdecl, importc.}
proc glfwGetError*(description:ptr cstring): cint {.cdecl, importc.}
proc glfwSetErrorCallback*(callback:GLFWerrorfun): GLFWerrorfun {.cdecl, importc.}

proc glfwGetMonitors*(count: ptr cint): ptr UncheckedArray[GLFWmonitor] {.cdecl, importc.}
proc glfwGetPrimaryMonitor*(): GLFWmonitor {.cdecl, importc.}
proc glfwGetMonitorPos*(monitor: GLFWmonitor, xpos: ptr cint, ypos: ptr cint) {.cdecl, importc.}
proc glfwGetMonitorWorkarea*(monitor: GLFWmonitor, xpos: ptr cint, ypos: ptr cint, width: ptr cint, height: ptr cint) {.cdecl, importc.}
proc glfwGetMonitorPhysicalSize*(monitor: GLFWmonitor, widthMM: ptr cint, heightMM: ptr cint) {.cdecl, importc.}
proc glfwGetMonitorContentScale*(monitor: GLFWmonitor, xscale: ptr cfloat, yscale: ptr cfloat) {.cdecl, importc.}
proc glfwGetMonitorName*(monitor: GLFWmonitor): cstring {.cdecl, importc.}
proc glfwSetMonitorUserPointer*(monitor: GLFWmonitor, data: pointer) {.cdecl, importc.}
proc glfwGetMonitorUserPointer*(monitor: GLFWmonitor): pointer {.cdecl, importc.}
proc glfwSetMonitorCallback*(cbfun: GLFWmonitorfun): GLFWmonitorfun {.cdecl, importc.}
proc glfwGetVideoModes*(monitor: GLFWmonitor, count: ptr cint): ptr GLFWvidmode {.cdecl, importc.}
proc glfwGetVideoMode*(monitor: GLFWmonitor): ptr GLFWvidmode {.cdecl, importc.}
proc glfwSetGamma*(monitor: GLFWmonitor, gamma: cfloat) {.cdecl, importc.}
proc glfwGetGammaRamp*(monitor: GLFWmonitor): ptr GLFWgammaramp {.cdecl, importc.}
proc glfwSetGammaRamp*(monitor: GLFWmonitor, ramp: ptr GLFWgammaramp) {.cdecl, importc.}

proc glfwDefaultWindowHints*() {.cdecl, importc.}
proc glfwWindowHint*(target: cint, hint: cint) {.cdecl, importc.}
proc glfwWindowHintString*(hint: cint, value: cstring) {.cdecl, importc.}
proc glfwCreateWindow*(width: cint, height: cint, title: cstring, monitor: GLFWmonitor, share: GLFWwindow): GLFWwindow{.cdecl, importc.}
proc glfwDestroyWindow*(window: GLFWwindow) {.cdecl, importc.}
proc glfwWindowShouldClose*(window: GLFWwindow): cint {.cdecl, importc.}
proc glfwSetWindowShouldClose*(window: GLFWwindow, value: cint) {.cdecl, importc.}
proc glfwSetWindowTitle*(window: GLFWwindow, title: cstring) {.cdecl, importc.}
proc glfwSetWindowIcon*(window: GLFWwindow, count: cint, image: ptr GLFWimage) {.cdecl, importc.}
proc glfwGetWindowPos*(window: GLFWwindow, xpos: ptr cint, ypos: ptr cint) {.cdecl, importc.}
proc glfwSetWindowPos*(window: GLFWwindow, xpos: cint, ypos: cint) {.cdecl, importc.}
proc glfwGetWindowSize*(window: GLFWwindow, width: ptr cint, height: ptr cint) {.cdecl, importc.}
proc glfwSetWindowSizeLimits*(window: GLFWwindow, minwidth, minheight, maxwidth, maxheight: cint) {.cdecl, importc.}
proc glfwSetWindowAspectRatio*(window: GLFWwindow, numer, denom: cint) {.cdecl, importc.}
proc glfwSetWindowSize*(window: GLFWwindow, width: cint, height: cint) {.cdecl, importc.}
proc glfwGetFramebufferSize*(window: GLFWwindow, width: ptr cint, height: ptr cint) {.cdecl, importc.}
proc glfwGetWindowFrameSize*(window: GLFWwindow, left, top, right, bottom: ptr int) {.cdecl, importc.}
proc glfwGetWindowContentScale*(window: GLFWwindow, xscale: ptr cfloat, yscale: ptr cfloat) {.cdecl, importc.}
proc glfwGetWindowOpacity*(window: GLFWwindow): cfloat {.cdecl, importc.}
proc glfwSetWindowOpacity*(window: GLFWwindow, opacity: cfloat) {.cdecl, importc.}
proc glfwIconifyWindow*(window: GLFWwindow) {.cdecl, importc.}
proc glfwRestoreWindow*(window: GLFWwindow) {.cdecl, importc.}
proc glfwMaximizeWindow*(window: GLFWwindow) {.cdecl, importc.}
proc glfwShowWindow*(window: GLFWwindow) {.cdecl, importc.}
proc glfwHideWindow*(window: GLFWwindow) {.cdecl, importc.}
proc glfwFocusWindow*(window: GLFWwindow) {.cdecl, importc.}
proc glfwRequestWindowAttention*(window: GLFWwindow) {.cdecl, importc.}
proc glfwGetWindowMonitor*(window: GLFWwindow): GLFWmonitor {.cdecl, importc.}
proc glfwSetWindowMonitor*(window: GLFWwindow, monitor: GLFWmonitor, xpos, ypos, width, height: cint) {.cdecl, importc.}
proc glfwGetWindowAttrib*(window: GLFWwindow, attrib: cint): cint {.cdecl, importc.}
proc glfwSetWindowAttrib*(window: GLFWwindow, attrib: cint, value: cint) {.cdecl, importc.}
proc glfwSetWindowUserPointer*(window: GLFWwindow, pointer: pointer) {.cdecl, importc.}
proc glfwGetWindowUserPointer*(window: GLFWwindow): pointer {.cdecl, importc.}
proc glfwSetWindowPosCallback*(window: GLFWwindow, cbfun: GLFWwindowposfun): GLFWwindowposfun {.cdecl, importc.}
proc glfwSetWindowSizeCallback*(window: GLFWwindow, cbfun: GLFWwindowsizefun): GLFWwindowsizefun {.cdecl, importc.}
proc glfwSetWindowCloseCallback*(window: GLFWwindow, cbfun: GLFWwindowclosefun): GLFWwindowclosefun {.cdecl, importc.}
proc glfwSetWindowRefreshCallback*(window: GLFWwindow, cbfun: GLFWwindowrefreshfun): GLFWwindowrefreshfun {.cdecl, importc.}
proc glfwSetWindowFocusCallback*(window: GLFWwindow, cbfun: GLFWwindowfocusfun): GLFWwindowfocusfun {.cdecl, importc.}
proc glfwSetWindowIconifyCallback*(window: GLFWwindow, cbfun: GLFWwindowiconifyfun): GLFWwindowiconifyfun {.cdecl, importc.}
proc glfwSetWindowMaximizeCallback*(window: GLFWwindow, callback: GLFWwindowmaximizefun): GLFWwindowmaximizefun {.cdecl, importc.}
proc glfwSetFramebufferSizeCallback*(window: GLFWwindow, cbfun: GLFWframebuffersizefun): GLFWframebuffersizefun {.cdecl, importc.}
proc glfwSetWindowContentScaleCallback*(window: GLFWwindow, callback: GLFWwindowcontentscalefun): GLFWwindowcontentscalefun {.cdecl, importc.}

proc glfwPollEvents*() {.cdecl, importc.}
proc glfwWaitEvents*() {.cdecl, importc.}
proc glfwWaitEventsTimeout*(timeout: cdouble) {.cdecl, importc.}
proc glfwPostEmptyEvent*() {.cdecl, importc.}

proc glfwGetInputMode*(window: GLFWwindow, mode: cint): cint {.cdecl, importc.}
proc glfwSetInputMode*(window: GLFWwindow, mode: cint, value: cint) {.cdecl, importc.}
proc glfwRawMouseMotionSupported*(): cint {.cdecl, importc.}
proc glfwGetKeyName*(key: cint, scanmode: cint): cstring {.cdecl, importc.}
proc glfwGetKeyScancode*(key: cint): cint {.cdecl, importc.}
proc glfwGetKey*(window: GLFWwindow, key: cint): cint {.cdecl, importc.}
proc glfwGetMouseButton*(window: GLFWwindow, button: cint): cint {.cdecl, importc.}

proc glfwGetCursorPos*(window: GLFWwindow, xpos: ptr cdouble, ypos: ptr cdouble) {.cdecl, importc.}
proc glfwSetCursorPos*(window: GLFWwindow, xpos: cdouble, ypos: cdouble) {.cdecl, importc.}
proc glfwCreateCursor*(image: ptr GLFWimage, xhot, yhot: cint): GLFWcursor {.cdecl, importc.}
proc glfwCreateStandardCursor*(shape: cint): GLFWcursor {.cdecl, importc.}
proc glfwDestroyCursor*(cusor: GLFWcursor) {.cdecl, importc.}
proc glfwSetCursor*(window: GLFWwindow, cursor: GLFWcursor) {.cdecl, importc.}

proc glfwSetKeyCallback*(window: GLFWwindow, cbfun: GLFWkeyfun): GLFWkeyfun {.cdecl, importc.}
proc glfwSetCharCallback*(window: GLFWwindow, cbfun: GLFWcharfun): GLFWcharfun {.cdecl, importc.}
proc glfwSetCharModsCallback*(window: GLFWwindow, cbfun: GLFWcharmodsfun): GLFWcharmodsfun {.cdecl, importc.}
proc glfwSetMouseButtonCallback*(window: GLFWwindow, cbfun: GLFWmousebuttonfun): GLFWmousebuttonfun {.cdecl, importc.}
proc glfwSetCursorPosCallback*(window: GLFWwindow, cbfun: GLFWcursorposfun): GLFWcursorposfun {.cdecl, importc.}
proc glfwSetCursorEnterCallback*(window: GLFWwindow, cbfun: GLFWcursorenterfun): GLFWcursorenterfun {.cdecl, importc.}
proc glfwSetScrollCallback*(window: GLFWwindow, cbfun: GLFWscrollfun): GLFWscrollfun {.cdecl, importc.}
proc glfwSetDropCallback*(window: GLFWwindow, cbfun: GLFWdropfun) {.cdecl, importc.}

proc glfwJoystickPresent*(joy: cint): cint {.cdecl, importc.}
proc glfwGetJoystickAxes*(joy: cint, count: ptr cint): ptr cfloat {.cdecl, importc.}
proc glfwGetJoystickButtons*(joy: cint, count: ptr cint): ptr cuchar {.cdecl, importc.}
proc glfwGetJoystickHats*(jid: cint, count: ptr cint): ptr cuchar {.cdecl, importc.}
proc glfwGetJoystickName*(joy: cint): cstring {.cdecl, importc.}
proc glfwGetJoystickGUID*(jid: cint): cstring {.cdecl, importc.}
proc glfwSetJoystickUserPointer*(jid: cint, data: pointer) {.cdecl, importc.}
proc glfwGetJoystickUserPointer*(jid: cint): pointer {.cdecl, importc.}
proc glfwJoystickIsGamepad*(jid: cint): cint {.cdecl, importc.}
proc glfwSetJoystickCallback*(cbfun: GLFWjoystickfun): GLFWjoystickfun {.cdecl, importc.}
proc glfwUpdateGamepadMappings*(mappings: cstring): cint {.cdecl, importc.}
proc glfwGetGamepadName*(jid: cint): cstring {.cdecl, importc.}
proc glfwGetGamepadState*(jid: cint, state: ptr GLFWgamepadstate): cint {.cdecl, importc.}

proc glfwSetClipboardString*(window: GLFWwindow, string: cstring) {.cdecl, importc.}
proc glfwGetClipboardString*(window: GLFWwindow): cstring {.cdecl, importc.}

proc glfwGetTime*(): cdouble {.cdecl, importc.}
proc glfwSetTime*(time: cdouble) {.cdecl, importc.}
proc glfwGetTimerValue*(): culonglong {.cdecl, importc.}
proc glfwGetTimerFrequency*(): culonglong {.cdecl, importc.}

proc glfwMakeContextCurrent*(window: GLFWwindow) {.cdecl, importc.}
proc glfwGetCurrentContext*(): GLFWwindow {.cdecl, importc.}

proc glfwSwapBuffers*(window: GLFWwindow) {.cdecl, importc.}
proc glfwSwapInterval*(interval: cint) {.cdecl, importc.}

proc glfwExtensionSupported*(extension: cstring): cint {.cdecl, importc.}
proc glfwGetProcAddress*(procname: cstring): GLFWglproc {.cdecl, importc.}

# Vulkan types & functions
type VkInstance* = pointer
type VkPhysicalDevice* = pointer
type VkAllocationCallbacks* = pointer
type VkSurfaceKHR* = pointer

type VkResult* = enum
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

proc glfwVulkanSupported*(): cint {.cdecl, importc.}
proc glfwGetRequiredInstanceExtensions*(count: ptr cuint): ptr cstring {.cdecl, importc.}
proc glfwGetInstanceProcAddress*(instance: VkInstance, procname: cstring): GLFWvkproc {.cdecl, importc.}
proc glfwGetPhysicalDevicePresentationSupport*(instance: VkInstance, device: VkPhysicalDevice, queuefamily: cuint): cint {.cdecl, importc.}
proc glfwCreateWindowSurface*(instance: VkInstance, window: GLFWwindow, allocator: ptr VkAllocationCallbacks, surface: ptr VkSurfaceKHR): VkResult {.cdecl, importc.}

#-------------------------------------------------------------------------------

when defined(windows):
  type HWND = pointer
  proc glfwGetWin32Adapter*(monitor: GLFWmonitor): cstring {.cdecl, importc.}
  proc glfwGetWin32Monitor*(monitor: GLFWmonitor): cstring {.cdecl, importc.}
  proc glfwGetWin32Window*(window: GLFWwindow): HWND {.cdecl, importc.}
elif defined(macosx):
  type CGDirectDisplayID = pointer
  type id = pointer
  proc glfwGetCocoaMonitor*(monitor: GLFWmonitor): CGDirectDisplayID {.cdecl, importc.}
  proc glfwGetCocoaWindow*(window: GLFWwindow): id {.cdecl, importc.}
  proc glfwGetNSGLContext*(window: GLFWwindow): id {.cdecl, importc.}
elif defined(linux) and defined(wayland):
  # struct wl_display* glfwGetWaylandDisplay(void);
  # struct wl_output* glfwGetWaylandMonitor(GLFWmonitor* monitor);
  # struct wl_surface* glfwGetWaylandWindow(GLFWwindow* window);
  discard
elif defined(linux):
  # Display* glfwGetX11Display(void);
  # RRCrtc glfwGetX11Adapter(GLFWmonitor* monitor);
  # RROutput glfwGetX11Monitor(GLFWmonitor* monitor);
  # GLFWwindow glfwGetX11Window(GLFWwindow* window);
  # void glfwSetX11SelectionString(const char* string);
  # const char* glfwGetX11SelectionString(void);
  discard

#-------------------------------------------------------------------------------

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
