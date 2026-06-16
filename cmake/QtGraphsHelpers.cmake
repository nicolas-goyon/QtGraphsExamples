# QtGraphsHelpers.cmake
# -----------------------------------------------------------------------
# Provides add_qt_graphs_example() — a thin wrapper that sets up a Qt
# executable with all common settings so each example's CMakeLists.txt
# stays short and consistent.
#
# Usage:
#   add_qt_graphs_example(
#       TARGET      my_example
#       SOURCES     main.cpp MainWindow.cpp
#       # EXTRA_LIBS  SomeOtherQt6::Module   (optional)
#   )
# -----------------------------------------------------------------------

function(add_qt_graphs_example)
    cmake_parse_arguments(
        ARG
        ""                   # options (flags)
        "TARGET"             # single-value keywords
        "SOURCES;EXTRA_LIBS" # multi-value keywords
        ${ARGN}
    )

    if(NOT ARG_TARGET)
        message(FATAL_ERROR "add_qt_graphs_example: TARGET is required")
    endif()
    if(NOT ARG_SOURCES)
        message(FATAL_ERROR "add_qt_graphs_example: SOURCES is required")
    endif()

    qt_add_executable(${ARG_TARGET} ${ARG_SOURCES})

    target_link_libraries(${ARG_TARGET}
        PRIVATE
            Qt6::Core
            Qt6::Widgets
            Qt6::Graphs
            QtGraphsShared
            ${ARG_EXTRA_LIBS}
    )

    target_compile_options(${ARG_TARGET}
        PRIVATE
            $<$<CXX_COMPILER_ID:MSVC>:/W4>
            $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -Wpedantic>
    )

    set_target_properties(${ARG_TARGET} PROPERTIES
        WIN32_EXECUTABLE TRUE
        MACOSX_BUNDLE    TRUE
        OUTPUT_NAME      "${ARG_TARGET}"
    )
endfunction()
