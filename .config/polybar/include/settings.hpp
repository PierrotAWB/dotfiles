#pragma once

#include <cstdio>
#include <string>
#include <vector>

#include "version.hpp"

#define APP_NAME "polybar"
#define APP_VERSION "3.2.1"
#ifndef APP_VERSION
#define APP_VERSION GIT_TAG
#endif
#define APP_VERSION_NAMESPACE v3_2_1
#ifndef APP_VERSION_NAMESPACE
#define APP_VERSION_NAMESPACE GIT_TAG_NAMESPACE
#endif
#define BASE_PATH "/home/andrew/.config/polybar"

#define ENABLE_ALSA 0
#define ENABLE_MPD 0
#define ENABLE_NETWORK 0
#define WITH_LIBNL 0
#define ENABLE_I3 1
#define ENABLE_CURL 0
#define ENABLE_PULSEAUDIO 0

#define WITH_XRANDR 1
#define WITH_XRENDER 0
#define WITH_XDAMAGE 0
#define WITH_XSYNC 0
#define WITH_XCOMPOSITE 0
#define WITH_XKB 1
#define WITH_XRM 1
#define WITH_XCURSOR 1

#if WITH_XRANDR
#define WITH_XRANDR_MONITORS 1
#else
#define WITH_XRANDR_MONITORS 0
#endif

#if WITH_XKB
#define ENABLE_XKEYBOARD 1
#else
#define ENABLE_XKEYBOARD 0
#endif

#define XPP_EXTENSION_LIST xpp::randr::extension, xpp::xkb::extension

#define DEBUG_LOGGER

#if DEBUG
/* #undef DEBUG_LOGGER_VERBOSE */
/* #undef DEBUG_HINTS */
/* #undef DEBUG_WHITESPACE */
/* #undef DEBUG_SHADED */
/* #undef DEBUG_FONTCONFIG */
#endif

static const size_t EVENT_SIZE = 64;

static const int SIGN_PRIORITY_CONTROLLER{1};
static const int SIGN_PRIORITY_SCREEN{2};
static const int SIGN_PRIORITY_BAR{3};
static const int SIGN_PRIORITY_RENDERER{4};
static const int SIGN_PRIORITY_TRAY{5};

static const int SINK_PRIORITY_BAR{1};
static const int SINK_PRIORITY_SCREEN{2};
static const int SINK_PRIORITY_TRAY{3};
static const int SINK_PRIORITY_MODULE{4};

#ifdef DEBUG_HINTS
static const int DEBUG_HINTS_OFFSET_X{};
static const int DEBUG_HINTS_OFFSET_Y{};
#endif

static constexpr const char* ALSA_SOUNDCARD{"default"};
static constexpr const char* BSPWM_SOCKET_PATH{"/tmp/bspwm_0_0-socket"};
static constexpr const char* BSPWM_STATUS_PREFIX{"W"};
static constexpr const char* CONNECTION_TEST_IP{"8.8.8.8"};
static constexpr const char* PATH_ADAPTER{"/sys/class/power_supply/%adapter%"};
static constexpr const char* PATH_BACKLIGHT_MAX{"/sys/class/backlight/%card%/max_brightness"};
static constexpr const char* PATH_BACKLIGHT_VAL{"/sys/class/backlight/%card%/brightness"};
static constexpr const char* PATH_BATTERY{"/sys/class/power_supply/%battery%"};
static constexpr const char* PATH_CPU_INFO{"/proc/stat"};
static constexpr const char* PATH_MEMORY_INFO{"/proc/meminfo"};
static constexpr const char* PATH_MESSAGING_FIFO{"/tmp/polybar_mqueue.%pid%"};
static constexpr const char* PATH_TEMPERATURE_INFO{"/sys/class/thermal/thermal_zone%zone%/temp"};

static constexpr const char* BUILDER_SPACE_TOKEN{"%__"};

const auto version_details = [](const std::vector<std::string>& args) {
  for (auto&& arg : args) {
    if (arg.compare(0, 3, "-vv") == 0)
      return true;
  }
  return false;
};

// clang-format off
const auto print_build_info = [](bool extended = false) {
  printf("%s %s\n\n", APP_NAME, APP_VERSION);
  printf("Features: %calsa %ccurl %ci3 %cmpd %cnetwork %cpulseaudio %cxkeyboard\n",
    (ENABLE_ALSA       ? '+' : '-'),
    (ENABLE_CURL       ? '+' : '-'),
    (ENABLE_I3         ? '+' : '-'),
    (ENABLE_MPD        ? '+' : '-'),
    (ENABLE_NETWORK    ? '+' : '-'),
    (ENABLE_PULSEAUDIO ? '+' : '-'),
    (ENABLE_XKEYBOARD  ? '+' : '-'));
  if (extended) {
    printf("\n");
    printf("X extensions: %crandr (%cmonitors) %crender %cdamage %csync %ccomposite %cxkb %cxrm %cxcursor\n",
      (WITH_XRANDR            ? '+' : '-'),
      (WITH_XRANDR_MONITORS   ? '+' : '-'),
      (WITH_XRENDER           ? '+' : '-'),
      (WITH_XDAMAGE           ? '+' : '-'),
      (WITH_XSYNC             ? '+' : '-'),
      (WITH_XCOMPOSITE        ? '+' : '-'),
      (WITH_XKB               ? '+' : '-'),
      (WITH_XRM               ? '+' : '-'),
      (WITH_XCURSOR           ? '+' : '-'));
    printf("\n");
    printf("Build type: RelWithDebInfo\n");
    printf("Compiler: /usr/bin/c++\n");
    printf("Compiler flags:  -Wall -Wextra -Werror -Wno-noexcept-type -O2 -pedantic -pedantic-errors\n");
    printf("Linker flags: \n");
  }
};
// clang-format on

// vim:ft=cpp
