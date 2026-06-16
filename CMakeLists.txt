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
        # ── 2D ──────────────────────────────────────────────────
        qml/2d/linechart/basic/LineChartBasicDataProvider.h
        qml/2d/linechart/basic/LineChartBasicDataProvider.cpp
        qml/2d/linechart/table/LineChartTableDataProvider.h
        qml/2d/linechart/table/LineChartTableDataProvider.cpp
        qml/2d/linechart/target/LineChartTargetDataProvider.h
        qml/2d/linechart/target/LineChartTargetDataProvider.cpp
        qml/2d/linechart/range/LineChartRangeDataProvider.h
        qml/2d/linechart/range/LineChartRangeDataProvider.cpp
        qml/2d/linechart/stacked/LineChartStackedDataProvider.h
        qml/2d/linechart/stacked/LineChartStackedDataProvider.cpp
        qml/2d/areachart/basic/AreaChartBasicDataProvider.h
        qml/2d/areachart/basic/AreaChartBasicDataProvider.cpp
        qml/2d/areachart/stacked/AreaChartStackedDataProvider.h
        qml/2d/areachart/stacked/AreaChartStackedDataProvider.cpp
        qml/2d/areachart/pointlabels/AreaChartPointLabelsDataProvider.h
        qml/2d/areachart/pointlabels/AreaChartPointLabelsDataProvider.cpp
        qml/2d/barchart/basic/BarChartBasicDataProvider.h
        qml/2d/barchart/basic/BarChartBasicDataProvider.cpp
        qml/2d/scatterchart/basic/ScatterChartBasicDataProvider.h
        qml/2d/scatterchart/basic/ScatterChartBasicDataProvider.cpp
        # ── 3D ──────────────────────────────────────────────────
        qml/3d/bars3d/basic/Bars3DBasicDataProvider.h
        qml/3d/bars3d/basic/Bars3DBasicDataProvider.cpp
        qml/3d/surface3d/basic/Surface3DBasicDataProvider.h
        qml/3d/surface3d/basic/Surface3DBasicDataProvider.cpp
    QML_FILES
        qml/Main.qml
        # ── 2D ──────────────────────────────────────────────────
        qml/2d/linechart/basic/LineChartBasicExample.qml
        qml/2d/linechart/basic/LineChartBasicDescription.qml
        qml/2d/linechart/table/LineChartTableExample.qml
        qml/2d/linechart/table/LineChartTableGraph.qml
        qml/2d/linechart/table/LineChartTableTable.qml
        qml/2d/linechart/table/LineChartTableDescription.qml
        qml/2d/linechart/target/LineChartTargetExample.qml
        qml/2d/linechart/target/LineChartTargetDescription.qml
        qml/2d/linechart/range/LineChartRangeExample.qml
        qml/2d/linechart/range/LineChartRangeDescription.qml
        qml/2d/linechart/stacked/LineChartStackedExample.qml
        qml/2d/linechart/stacked/LineChartStackedDescription.qml
        qml/2d/linechart/stacked/LineChartStackedHoverExample.qml
        qml/2d/linechart/stacked/LineChartStackedHoverDescription.qml
        qml/2d/areachart/basic/AreaChartBasicExample.qml
        qml/2d/areachart/basic/AreaChartBasicDescription.qml
        qml/2d/areachart/stacked/AreaChartStackedExample.qml
        qml/2d/areachart/stacked/AreaChartStackedDescription.qml
        qml/2d/areachart/pointlabels/AreaChartPointLabelsExample.qml
        qml/2d/areachart/pointlabels/AreaChartPointLabelsDescription.qml
        qml/2d/barchart/basic/BarChartBasicExample.qml
        qml/2d/barchart/basic/BarChartBasicDescription.qml
        qml/2d/scatterchart/basic/ScatterChartBasicExample.qml
        qml/2d/scatterchart/basic/ScatterChartBasicDescription.qml
        # ── 3D ──────────────────────────────────────────────────
        qml/3d/bars3d/basic/Bars3DBasicExample.qml
        qml/3d/bars3d/basic/Bars3DBasicDescription.qml
        qml/3d/surface3d/basic/Surface3DBasicExample.qml
        qml/3d/surface3d/basic/Surface3DBasicDescription.qml
)

# Each variant subfolder must be on the include path so the auto-generated
# qtgraphsexamples_qmltyperegistrations.cpp can find the provider headers by basename.
target_include_directories(QtGraphsExamples PRIVATE
    qml/2d/linechart/basic
    qml/2d/linechart/table
    qml/2d/linechart/target
    qml/2d/linechart/range
    qml/2d/linechart/stacked
    qml/2d/areachart/basic
    qml/2d/areachart/stacked
    qml/2d/areachart/pointlabels
    qml/2d/barchart/basic
    qml/2d/scatterchart/basic
    qml/3d/bars3d/basic
    qml/3d/surface3d/basic
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
