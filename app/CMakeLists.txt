add_qt_graphs_example(
    TARGET QtGraphsExamples
    SOURCES
        main.cpp

        MainWindow.h
        MainWindow.cpp

        common/ExampleTab.h
        common/ExampleTab.cpp

        pages/Page2D.h
        pages/Page2D.cpp
        pages/Page3D.h
        pages/Page3D.cpp

        tabs/2d/LineChartTab.h
        tabs/2d/LineChartTab.cpp
        tabs/2d/BarChartTab.h
        tabs/2d/BarChartTab.cpp
        tabs/2d/ScatterChartTab.h
        tabs/2d/ScatterChartTab.cpp

        tabs/3d/Bars3DTab.h
        tabs/3d/Bars3DTab.cpp
        tabs/3d/Scatter3DTab.h
        tabs/3d/Scatter3DTab.cpp
        tabs/3d/Surface3DTab.h
        tabs/3d/Surface3DTab.cpp

        # ---------- 2D Examples ----------
        examples/2D/Line/BasicLine/BasicLineExample.h
        examples/2D/Line/BasicLine/BasicLineExample.cpp
        examples/2D/Line/BasicLine/BasicLineData.h
        examples/2D/Line/BasicLine/BasicLineDescription.h

        examples/2D/Bar/BasicBar/BasicBarExample.h
        examples/2D/Bar/BasicBar/BasicBarExample.cpp
        examples/2D/Bar/BasicBar/BasicBarData.h
        examples/2D/Bar/BasicBar/BasicBarDescription.h

        examples/2D/Scatter/BasicScatter/BasicScatterExample.h
        examples/2D/Scatter/BasicScatter/BasicScatterExample.cpp
        examples/2D/Scatter/BasicScatter/BasicScatterData.h
        examples/2D/Scatter/BasicScatter/BasicScatterDescription.h

        # ---------- 3D Examples ----------
        examples/3D/Bars/BasicBars3D/BasicBars3DExample.h
        examples/3D/Bars/BasicBars3D/BasicBars3DExample.cpp
        examples/3D/Bars/BasicBars3D/BasicBars3DData.h
        examples/3D/Bars/BasicBars3D/BasicBars3DDescription.h

        examples/3D/Scatter/BasicScatter3D/BasicScatter3DExample.h
        examples/3D/Scatter/BasicScatter3D/BasicScatter3DExample.cpp
        examples/3D/Scatter/BasicScatter3D/BasicScatter3DData.h
        examples/3D/Scatter/BasicScatter3D/BasicScatter3DDescription.h

        examples/3D/Surface/BasicSurface3D/BasicSurface3DExample.h
        examples/3D/Surface/BasicSurface3D/BasicSurface3DExample.cpp
        examples/3D/Surface/BasicSurface3D/BasicSurface3DData.h
        examples/3D/Surface/BasicSurface3D/BasicSurface3DDescription.h

    # Qt6::QuickWidgets — required for QQuickWidget (2D and 3D examples).
    # Qt6::GraphsWidgets (Q3DBarsWidgetItem, etc.) is NOT needed: all graphs
    # are defined in QML files and loaded via QQuickWidget::setSource().
    EXTRA_LIBS
        Qt6::QuickWidgets
)

# ---------------------------------------------------------------------------
# QML files — compiled into the binary as Qt resources under the /qml prefix.
# C++ Example files load them via QUrl("qrc:/qml/examples/...").
# ---------------------------------------------------------------------------
qt_add_resources(QtGraphsExamples "example_qml"
    PREFIX "/qml"
    FILES
        examples/2D/Line/BasicLine/BasicLine.qml
        examples/2D/Bar/BasicBar/BasicBar.qml
        examples/2D/Scatter/BasicScatter/BasicScatter.qml
        examples/3D/Bars/BasicBars3D/BasicBars3D.qml
        examples/3D/Scatter/BasicScatter3D/BasicScatter3D.qml
        examples/3D/Surface/BasicSurface3D/BasicSurface3D.qml
)

# app/ is an include root for internal headers ("pages/Page2D.h", etc.)
# Project root is an include root for example headers ("examples/2D/Line/BasicLine/BasicLineExample.h")
target_include_directories(QtGraphsExamples PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}
)

# ---------------------------------------------------------------------------
# Windows: copy Qt DLLs next to the executable after every build.
# windeployqt scans the binary and deploys exactly what it needs.
# ---------------------------------------------------------------------------
if(WIN32)
    find_program(WINDEPLOYQT windeployqt
        HINTS "${Qt6_DIR}/../../../bin"
    )
    if(WINDEPLOYQT)
        add_custom_command(TARGET QtGraphsExamples POST_BUILD
            COMMAND "${WINDEPLOYQT}"
                --no-translations
                --no-system-d3d-compiler
                --no-opengl-sw
                "$<TARGET_FILE:QtGraphsExamples>"
            COMMENT "Deploying Qt DLLs..."
        )
    else()
        message(WARNING "windeployqt not found — you may need to add Qt/bin to PATH to run the app.")
    endif()
endif()
