cmake_minimum_required(VERSION 3.21)

project(QtGraphsExamples
    VERSION 1.0.0
    DESCRIPTION "Ready-to-use Qt Graphs examples covering 2D and 3D APIs"
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# --------------------------------------------------------------------------
# Qt discovery
# --------------------------------------------------------------------------
find_package(Qt6 6.11 REQUIRED COMPONENTS Core Widgets Graphs Quick QuickWidgets)
qt_standard_project_setup()

# --------------------------------------------------------------------------
# Shared helpers
# --------------------------------------------------------------------------
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(QtGraphsHelpers)

add_subdirectory(shared)

# --------------------------------------------------------------------------
# Application
# --------------------------------------------------------------------------
add_subdirectory(app)
