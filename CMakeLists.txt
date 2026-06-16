cmake_minimum_required(VERSION 3.16)
project(QtGraphsExamples VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick Qml Graphs)

qt_standard_project_setup(REQUIRES 6.6)

# QTP0004: auto-generate qmldir for QML files in subdirectories (no manual qmldir files needed)
qt_policy(SET QTP0004 NEW)

qt_add_executable(QtGraphsExamples
    main.cpp
)

qt_add_qml_module(QtGraphsExamples
    URI QtGraphsExamples
    VERSION 1.0
    SOURCES
        # ── 2D basic ────────────────────────────────────────────
        qml/2d/linechart/basic/LineChartBasicDataProvider.h
        qml/2d/linechart/basic/LineChartBasicDataProvider.cpp
        qml/2d/barchart/basic/BarChartBasicDataProvider.h
        qml/2d/barchart/basic/BarChartBasicDataProvider.cpp
        qml/2d/scatterchart/basic/ScatterChartBasicDataProvider.h
        qml/2d/scatterchart/basic/ScatterChartBasicDataProvider.cpp
        # ── 2D legend ───────────────────────────────────────────
        qml/2d/linechart/legend/LineChartLegendDataProvider.h
        qml/2d/linechart/legend/LineChartLegendDataProvider.cpp
        qml/2d/barchart/legend/BarChartLegendDataProvider.h
        qml/2d/barchart/legend/BarChartLegendDataProvider.cpp
        qml/2d/scatterchart/legend/ScatterChartLegendDataProvider.h
        qml/2d/scatterchart/legend/ScatterChartLegendDataProvider.cpp
        # ── 3D basic ────────────────────────────────────────────
        qml/3d/bars3d/basic/Bars3DBasicDataProvider.h
        qml/3d/bars3d/basic/Bars3DBasicDataProvider.cpp
        qml/3d/surface3d/basic/Surface3DBasicDataProvider.h
        qml/3d/surface3d/basic/Surface3DBasicDataProvider.cpp
        # ── 3D legend ───────────────────────────────────────────
        qml/3d/bars3d/legend/Bars3DLegendDataProvider.h
        qml/3d/bars3d/legend/Bars3DLegendDataProvider.cpp
        qml/3d/surface3d/legend/Surface3DLegendDataProvider.h
        qml/3d/surface3d/legend/Surface3DLegendDataProvider.cpp
    QML_FILES
        qml/Main.qml
        # ── 2D basic ────────────────────────────────────────────
        qml/2d/linechart/basic/LineChartBasicExample.qml
        qml/2d/linechart/basic/LineChartBasicDescription.qml
        qml/2d/barchart/basic/BarChartBasicExample.qml
        qml/2d/barchart/basic/BarChartBasicDescription.qml
        qml/2d/scatterchart/basic/ScatterChartBasicExample.qml
        qml/2d/scatterchart/basic/ScatterChartBasicDescription.qml
        # ── 2D legend ───────────────────────────────────────────
        qml/2d/linechart/legend/LineChartLegendExample.qml
        qml/2d/linechart/legend/LineChartLegendDescription.qml
        qml/2d/barchart/legend/BarChartLegendExample.qml
        qml/2d/barchart/legend/BarChartLegendDescription.qml
        qml/2d/scatterchart/legend/ScatterChartLegendExample.qml
        qml/2d/scatterchart/legend/ScatterChartLegendDescription.qml
        # ── 3D basic ────────────────────────────────────────────
        qml/3d/bars3d/basic/Bars3DBasicExample.qml
        qml/3d/bars3d/basic/Bars3DBasicDescription.qml
        qml/3d/surface3d/basic/Surface3DBasicExample.qml
        qml/3d/surface3d/basic/Surface3DBasicDescription.qml
        # ── 3D legend ───────────────────────────────────────────
        qml/3d/bars3d/legend/Bars3DLegendExample.qml
        qml/3d/bars3d/legend/Bars3DLegendDescription.qml
        qml/3d/surface3d/legend/Surface3DLegendExample.qml
        qml/3d/surface3d/legend/Surface3DLegendDescription.qml
)

# Each variant subfolder must be on the include path so the auto-generated
# qtgraphsexamples_qmltyperegistrations.cpp can find the provider headers by basename.
target_include_directories(QtGraphsExamples PRIVATE
    # basic
    qml/2d/linechart/basic
    qml/2d/barchart/basic
    qml/2d/scatterchart/basic
    qml/3d/bars3d/basic
    qml/3d/surface3d/basic
    # legend
    qml/2d/linechart/legend
    qml/2d/barchart/legend
    qml/2d/scatterchart/legend
    qml/3d/bars3d/legend
    qml/3d/surface3d/legend
)

target_link_libraries(QtGraphsExamples PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Qml
    Qt6::Graphs
)

target_compile_definitions(QtGraphsExamples PRIVATE
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
)
