#pragma once

#include <QWidget>
#include <QString>
#include <QStringList>
#include <QVector>
#include <functional>

class QListWidget;
class QSplitter;
class QTextBrowser;
class QVBoxLayout;

// ---------------------------------------------------------------------------
// ExampleEntry
// Describes one example that can be loaded into an ExampleTab.
// ---------------------------------------------------------------------------
struct ExampleEntry {
    QString                            name;
    std::function<QWidget*(QWidget*)>  createWidget;
    QString                            description;
    QStringList                        files;
};

// ---------------------------------------------------------------------------
// ExampleTab
// Tab layout:
//
//   +-----------+-------------------------------+
//   |           |  Graph widget (real or stub)  |
//   |  Example  +-------------------------------+
//   |  List     |  Description text             |
//   |           |  Source files:                |
//   |           |    • examples/.../Foo.h       |
//   +-----------+-------------------------------+
//
// Usage: construct, then call addExample() for each example.
// ---------------------------------------------------------------------------
class ExampleTab : public QWidget
{
    Q_OBJECT

public:
    explicit ExampleTab(QWidget *parent = nullptr);

    // Register a new example. The first one added is selected automatically.
    void addExample(const ExampleEntry &entry);

private slots:
    void onExampleSelected(int row);

private:
    QListWidget  *m_list;
    QWidget      *m_graphContainer;
    QVBoxLayout  *m_graphLayout;
    QTextBrowser *m_descView;
    QVector<ExampleEntry> m_entries;

    void clearGraph();
};
