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
        qml/2d/linechart/legend/LineChartLegendDataProvider.h
        qml/2d/linechart/legend/LineChartLegendDataProvider.cpp
        qml/2d/areachart/basic/AreaChartBasicDataProvider.h
        qml/2d/areachart/basic/AreaChartBasicDataProvider.cpp
        qml/2d/areachart/stacked/AreaChartStackedDataProvider.h
        qml/2d/areachart/stacked/AreaChartStackedDataProvider.cpp
        qml/2d/areachart/pointlabels/AreaChartPointLabelsDataProvider.h
        qml/2d/areachart/pointlabels/AreaChartPointLabelsDataProvider.cpp
        qml/2d/barchart/basic/BarChartBasicDataProvider.h
        qml/2d/barchart/basic/BarChartBasicDataProvider.cpp
        qml/2d/barchart/stacked/BarChartStackedDataProvider.h
        qml/2d/barchart/stacked/BarChartStackedDataProvider.cpp
        qml/2d/barchart/labels/BarChartLabelsDataProvider.h
        qml/2d/barchart/labels/BarChartLabelsDataProvider.cpp
        qml/2d/barchart/targetline/BarChartTargetLineDataProvider.h
        qml/2d/barchart/targetline/BarChartTargetLineDataProvider.cpp
        qml/2d/barchart/legend/BarChartLegendDataProvider.h
        qml/2d/barchart/legend/BarChartLegendDataProvider.cpp
        qml/2d/scatterchart/basic/ScatterChartBasicDataProvider.h
        qml/2d/scatterchart/basic/ScatterChartBasicDataProvider.cpp
        qml/2d/scatterchart/trendline/ScatterChartTrendLineDataProvider.h
        qml/2d/scatterchart/trendline/ScatterChartTrendLineDataProvider.cpp
        qml/2d/scatterchart/custommarkers/ScatterChartCustomMarkersDataProvider.h
        qml/2d/scatterchart/custommarkers/ScatterChartCustomMarkersDataProvider.cpp
        qml/2d/scatterchart/hover/ScatterChartHoverDataProvider.h
        qml/2d/scatterchart/hover/ScatterChartHoverDataProvider.cpp
        qml/2d/scatterchart/legend/ScatterChartLegendDataProvider.h
        qml/2d/scatterchart/legend/ScatterChartLegendDataProvider.cpp
        qml/2d/splinechart/basic/SplineChartBasicDataProvider.h
        qml/2d/splinechart/basic/SplineChartBasicDataProvider.cpp
        qml/2d/splinechart/legend/SplineChartLegendDataProvider.h
        qml/2d/splinechart/legend/SplineChartLegendDataProvider.cpp
        qml/2d/populationpyramid/basic/PopulationPyramidDataProvider.h
        qml/2d/populationpyramid/basic/PopulationPyramidDataProvider.cpp
        qml/2d/barchart/stackedpercent/BarChartStackedPercentDataProvider.h
        qml/2d/barchart/stackedpercent/BarChartStackedPercentDataProvider.cpp
        qml/2d/barchart/horizontal/BarChartHorizontalDataProvider.h
        qml/2d/barchart/horizontal/BarChartHorizontalDataProvider.cpp
        qml/2d/barchart/mixedline/BarChartMixedLineDataProvider.h
        qml/2d/barchart/mixedline/BarChartMixedLineDataProvider.cpp
        qml/2d/scatterchart/trendlines/ScatterChartTrendLinesDataProvider.h
        qml/2d/scatterchart/trendlines/ScatterChartTrendLinesDataProvider.cpp
        qml/2d/scatterchart/averages/ScatterChartAveragesDataProvider.h
        qml/2d/scatterchart/averages/ScatterChartAveragesDataProvider.cpp
        qml/2d/piechart/basic/PieChartBasicDataProvider.h
        qml/2d/piechart/basic/PieChartBasicDataProvider.cpp
        qml/2d/linechart/editor/LineChartEditorDataProvider.h
        qml/2d/linechart/editor/LineChartEditorDataProvider.cpp
        # ── Radar chart — pure QML, no C++ data provider ────────
        # (no SOURCES entries needed)
        # ── 3D ──────────────────────────────────────────────────
        qml/3d/bars3d/basic/Bars3DBasicDataProvider.h
        qml/3d/bars3d/basic/Bars3DBasicDataProvider.cpp
        qml/3d/bars3d/legend/Bars3DLegendDataProvider.h
        qml/3d/bars3d/legend/Bars3DLegendDataProvider.cpp
        qml/3d/surface3d/basic/Surface3DBasicDataProvider.h
        qml/3d/surface3d/basic/Surface3DBasicDataProvider.cpp
        qml/3d/surface3d/legend/Surface3DLegendDataProvider.h
        qml/3d/surface3d/legend/Surface3DLegendDataProvider.cpp
    QML_FILES
        qml/Main.qml
        qml/ChartPage.qml
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
        qml/2d/linechart/legend/LineChartInlineLegendExample.qml
        qml/2d/linechart/legend/LineChartInlineLegendDescription.qml
        qml/2d/linechart/legend/LineChartSideLegendExample.qml
        qml/2d/linechart/legend/LineChartSideLegendDescription.qml
        qml/2d/linechart/live/LiveLineChartExample.qml
        qml/2d/linechart/live/LiveLineChartDescription.qml
        qml/2d/linechart/editor/LineChartEditorExample.qml
        qml/2d/linechart/editor/LineChartEditorDescription.qml
        qml/2d/linechart/editor/LineChartEditorInspector.qml
        qml/2d/linechart/editor/components/EditorPropField.qml
        qml/2d/linechart/editor/components/EditorPropSlider.qml
        qml/2d/linechart/editor/components/EditorSectionLabel.qml
        qml/2d/linechart/editor/components/EditorSeriesPanel.qml
        qml/2d/linechart/editor/components/EditorNumericField.qml
        qml/2d/linechart/editor/components/EditorToggle.qml
        qml/2d/areachart/basic/AreaChartBasicExample.qml
        qml/2d/areachart/basic/AreaChartBasicDescription.qml
        qml/2d/areachart/stacked/AreaChartStackedExample.qml
        qml/2d/areachart/stacked/AreaChartStackedDescription.qml
        qml/2d/areachart/pointlabels/AreaChartPointLabelsExample.qml
        qml/2d/areachart/pointlabels/AreaChartPointLabelsDescription.qml
        qml/2d/areachart/stackedlabels/AreaChartStackedSideLegendExample.qml
        qml/2d/areachart/stackedlabels/AreaChartStackedSideLegendDescription.qml
        qml/2d/areachart/stackedlabels/AreaChartStackedInlineLabelsExample.qml
        qml/2d/areachart/stackedlabels/AreaChartStackedInlineLabelsDescription.qml
        qml/2d/areachart/live/LiveAreaChartExample.qml
        qml/2d/areachart/live/LiveAreaChartDescription.qml
        qml/2d/barchart/basic/BarChartBasicExample.qml
        qml/2d/barchart/basic/BarChartBasicDescription.qml
        qml/2d/barchart/stacked/BarChartStackedExample.qml
        qml/2d/barchart/stacked/BarChartStackedDescription.qml
        qml/2d/barchart/labels/BarChartLabelsExample.qml
        qml/2d/barchart/labels/BarChartLabelsDescription.qml
        qml/2d/barchart/targetline/BarChartTargetLineExample.qml
        qml/2d/barchart/targetline/BarChartTargetLineDescription.qml
        qml/2d/barchart/legend/BarChartInlineLegendExample.qml
        qml/2d/barchart/legend/BarChartInlineLegendDescription.qml
        qml/2d/barchart/legend/BarChartSideLegendExample.qml
        qml/2d/barchart/legend/BarChartSideLegendDescription.qml
        qml/2d/scatterchart/basic/ScatterChartBasicExample.qml
        qml/2d/scatterchart/basic/ScatterChartBasicDescription.qml
        qml/2d/scatterchart/trendline/ScatterChartTrendLineExample.qml
        qml/2d/scatterchart/trendline/ScatterChartTrendLineDescription.qml
        qml/2d/scatterchart/custommarkers/ScatterChartCustomMarkersExample.qml
        qml/2d/scatterchart/custommarkers/ScatterChartCustomMarkersDescription.qml
        qml/2d/scatterchart/hover/ScatterChartHoverExample.qml
        qml/2d/scatterchart/hover/ScatterChartHoverDescription.qml
        qml/2d/scatterchart/live/LiveScatterChartExample.qml
        qml/2d/scatterchart/live/LiveScatterChartDescription.qml
        qml/2d/scatterchart/legend/ScatterChartInlineLegendExample.qml
        qml/2d/scatterchart/legend/ScatterChartInlineLegendDescription.qml
        qml/2d/scatterchart/legend/ScatterChartSideLegendExample.qml
        qml/2d/scatterchart/legend/ScatterChartSideLegendDescription.qml
        qml/2d/splinechart/basic/SplineChartBasicExample.qml
        qml/2d/splinechart/basic/SplineChartBasicDescription.qml
        qml/2d/splinechart/legend/SplineChartInlineLegendExample.qml
        qml/2d/splinechart/legend/SplineChartInlineLegendDescription.qml
        qml/2d/splinechart/legend/SplineChartSideLegendExample.qml
        qml/2d/splinechart/legend/SplineChartSideLegendDescription.qml
        qml/2d/splinechart/live/LiveSplineChartExample.qml
        qml/2d/splinechart/live/LiveSplineChartDescription.qml
        qml/2d/populationpyramid/basic/PopulationPyramidExample.qml
        qml/2d/populationpyramid/basic/PopulationPyramidDescription.qml
        qml/2d/heatmap/basic/HeatmapExample.qml
        qml/2d/heatmap/basic/HeatmapDescription.qml
        qml/2d/flowchart/basic/FlowChartExample.qml
        qml/2d/flowchart/basic/FlowChartDescription.qml
        qml/2d/flowchart/multilayer/FlowChartMultiLayerExample.qml
        qml/2d/flowchart/multilayer/FlowChartMultiLayerDescription.qml
        qml/2d/flowchart/hover/FlowChartHoverExample.qml
        qml/2d/flowchart/hover/FlowChartHoverDescription.qml
        qml/2d/flowchart/topdown/FlowChartTopDownExample.qml
        qml/2d/flowchart/topdown/FlowChartTopDownDescription.qml
        qml/2d/flowchart/partial/FlowChartPartialExample.qml
        qml/2d/flowchart/partial/FlowChartPartialDescription.qml
        qml/2d/barchart/stackedpercent/BarChartStackedPercentExample.qml
        qml/2d/barchart/stackedpercent/BarChartStackedPercentDescription.qml
        qml/2d/barchart/horizontal/BarChartHorizontalExample.qml
        qml/2d/barchart/horizontal/BarChartHorizontalDescription.qml
        qml/2d/barchart/mixedline/BarChartMixedLineExample.qml
        qml/2d/barchart/mixedline/BarChartMixedLineDescription.qml
        qml/2d/scatterchart/trendlines/ScatterChartTrendLinesExample.qml
        qml/2d/scatterchart/trendlines/ScatterChartTrendLinesDescription.qml
        qml/2d/scatterchart/averages/ScatterChartAveragesExample.qml
        qml/2d/scatterchart/averages/ScatterChartAveragesDescription.qml
        qml/2d/piechart/basic/PieChartBasicExample.qml
        qml/2d/piechart/basic/PieChartBasicDescription.qml
        qml/2d/piechart/donut/PieChartDonutExample.qml
        qml/2d/piechart/donut/PieChartDonutDescription.qml
        # ── Radar chart ──────────────────────────────────────────
        qml/2d/radarchart/RadarChart.qml
        qml/2d/radarchart/basic/RadarChartBasicExample.qml
        qml/2d/radarchart/basic/RadarChartBasicDescription.qml
        qml/2d/radarchart/multiline/RadarChartMultiLineExample.qml
        qml/2d/radarchart/multiline/RadarChartMultiLineDescription.qml
        qml/2d/radarchart/legend/RadarChartInlineLegendExample.qml
        qml/2d/radarchart/legend/RadarChartInlineLegendDescription.qml
        qml/2d/radarchart/legend/RadarChartSideLegendExample.qml
        qml/2d/radarchart/legend/RadarChartSideLegendDescription.qml
        # ── 3D ──────────────────────────────────────────────────
        qml/3d/bars3d/basic/Bars3DBasicExample.qml
        qml/3d/bars3d/basic/Bars3DBasicDescription.qml
        qml/3d/bars3d/legend/Bars3DInlineLegendExample.qml
        qml/3d/bars3d/legend/Bars3DInlineLegendDescription.qml
        qml/3d/bars3d/legend/Bars3DSideLegendExample.qml
        qml/3d/bars3d/legend/Bars3DSideLegendDescription.qml
        qml/3d/surface3d/basic/Surface3DBasicExample.qml
        qml/3d/surface3d/basic/Surface3DBasicDescription.qml
        qml/3d/surface3d/legend/Surface3DInlineLegendExample.qml
        qml/3d/surface3d/legend/Surface3DInlineLegendDescription.qml
        qml/3d/surface3d/legend/Surface3DSideLegendExample.qml
        qml/3d/surface3d/legend/Surface3DSideLegendDescription.qml
)

# Each variant subfolder must be on the include path so the auto-generated
# qtgraphsexamples_qmltyperegistrations.cpp can find the provider headers by basename.
target_include_directories(QtGraphsExamples PRIVATE
    qml/2d/linechart/basic
    qml/2d/linechart/table
    qml/2d/linechart/target
    qml/2d/linechart/range
    qml/2d/linechart/stacked
    qml/2d/linechart/legend
    qml/2d/areachart/basic
    qml/2d/areachart/stacked
    qml/2d/areachart/pointlabels
    qml/2d/barchart/basic
    qml/2d/barchart/stacked
    qml/2d/barchart/labels
    qml/2d/barchart/targetline
    qml/2d/barchart/legend
    qml/2d/scatterchart/basic
    qml/2d/scatterchart/trendline
    qml/2d/scatterchart/custommarkers
    qml/2d/scatterchart/hover
    qml/2d/scatterchart/legend
    qml/2d/splinechart/basic
    qml/2d/splinechart/legend
    qml/2d/populationpyramid/basic
    qml/2d/barchart/stackedpercent
    qml/2d/barchart/horizontal
    qml/2d/barchart/mixedline
    qml/2d/scatterchart/trendlines
    qml/2d/scatterchart/averages
    qml/2d/piechart/basic
    qml/2d/linechart/editor
    qml/3d/bars3d/basic
    qml/3d/bars3d/legend
    qml/3d/surface3d/basic
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
