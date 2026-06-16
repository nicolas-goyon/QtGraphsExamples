add_library(QtGraphsShared INTERFACE)

target_include_directories(QtGraphsShared
    INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(QtGraphsShared
    INTERFACE
        Qt6::Core
        Qt6::Widgets
        Qt6::Graphs
)
