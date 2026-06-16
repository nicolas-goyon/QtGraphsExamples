cmake_minimum_required(VERSION 3.16)
project(QtGraphsExamples VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick Qml Graphs)

qt_standard_project_setup(REQUIRES 6.6)

qt_add_executable(QtGraphsExamples
    main.cpp
)

qt_add_qml_module(QtGraphsExamples
    URI QtGraphsExamples
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/LineChartExample.qml
        qml/BarChartExample.qml
        qml/ScatterChartExample.qml
        qml/Bars3DExample.qml
        qml/Surface3DExample.qml
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
