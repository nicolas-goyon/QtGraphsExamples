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
        qml/linechart/LineChartDataProvider.h
        qml/linechart/LineChartDataProvider.cpp
        qml/barchart/BarChartDataProvider.h
        qml/barchart/BarChartDataProvider.cpp
        qml/scatterchart/ScatterChartDataProvider.h
        qml/scatterchart/ScatterChartDataProvider.cpp
        qml/bars3d/Bars3DDataProvider.h
        qml/bars3d/Bars3DDataProvider.cpp
        qml/surface3d/Surface3DDataProvider.h
        qml/surface3d/Surface3DDataProvider.cpp
    QML_FILES
        qml/Main.qml
        qml/linechart/LineChartExample.qml
        qml/barchart/BarChartExample.qml
        qml/scatterchart/ScatterChartExample.qml
        qml/bars3d/Bars3DExample.qml
        qml/surface3d/Surface3DExample.qml
)

# Each subdirectory must be on the include path so the auto-generated
# qtgraphsexamples_qmltyperegistrations.cpp can find the provider headers by basename.
target_include_directories(QtGraphsExamples PRIVATE
    qml/linechart
    qml/barchart
    qml/scatterchart
    qml/bars3d
    qml/surface3d
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
