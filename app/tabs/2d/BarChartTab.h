#pragma once

#include "common/ExampleTab.h"

// ---------------------------------------------------------------------------
// BarChartTab
// Hosts all bar-chart examples in a vertical example list.
// ---------------------------------------------------------------------------
class BarChartTab : public ExampleTab
{
    Q_OBJECT

public:
    explicit BarChartTab(QWidget *parent = nullptr);
};
