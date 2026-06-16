#include "common/ExampleTab.h"

#include <QLabel>
#include <QListWidget>
#include <QSplitter>
#include <QTextBrowser>
#include <QVBoxLayout>
#include <QHBoxLayout>

ExampleTab::ExampleTab(QWidget *parent)
    : QWidget(parent)
    , m_list(new QListWidget(this))
    , m_graphContainer(new QWidget(this))
    , m_graphLayout(new QVBoxLayout(m_graphContainer))
    , m_descView(new QTextBrowser(this))
{
    // Left: example list
    m_list->setFixedWidth(190);
    m_list->setSelectionMode(QAbstractItemView::SingleSelection);
    m_list->setStyleSheet(
        "QListWidget { border: none; background: #1e1e2e; }"
        "QListWidget::item { padding: 10px 14px; color: #cdd6f4; font-size: 13px; border-bottom: 1px solid #313244; }"
        "QListWidget::item:selected { background: #89b4fa; color: #1e1e2e; font-weight: bold; }"
        "QListWidget::item:hover:!selected { background: #313244; }"
    );

    // Graph container (placeholder until an example is selected)
    m_graphLayout->setContentsMargins(0, 0, 0, 0);
    auto *placeholder = new QLabel("Select an example", m_graphContainer);
    placeholder->setAlignment(Qt::AlignCenter);
    placeholder->setStyleSheet("color: #888; font-size: 14px;");
    m_graphLayout->addWidget(placeholder);

    // Description panel
    m_descView->setReadOnly(true);
    m_descView->setOpenExternalLinks(false);
    m_descView->setMinimumHeight(120);
    m_descView->setStyleSheet(
        "QTextBrowser { background: #181825; color: #cdd6f4; border-top: 1px solid #313244; "
        "padding: 8px; font-size: 12px; }"
    );

    // Right: vertical splitter — graph on top, description below
    auto *vSplitter = new QSplitter(Qt::Vertical, this);
    vSplitter->setChildrenCollapsible(false);
    vSplitter->addWidget(m_graphContainer);
    vSplitter->addWidget(m_descView);
    vSplitter->setStretchFactor(0, 3);
    vSplitter->setStretchFactor(1, 1);

    // Root: horizontal splitter — list on left, right panel on right
    auto *hSplitter = new QSplitter(Qt::Horizontal, this);
    hSplitter->setChildrenCollapsible(false);
    hSplitter->addWidget(m_list);
    hSplitter->addWidget(vSplitter);
    hSplitter->setStretchFactor(0, 0);
    hSplitter->setStretchFactor(1, 1);

    auto *layout = new QHBoxLayout(this);
    layout->setContentsMargins(0, 0, 0, 0);
    layout->addWidget(hSplitter);

    connect(m_list, &QListWidget::currentRowChanged,
            this,   &ExampleTab::onExampleSelected);
}

void ExampleTab::addExample(const ExampleEntry &entry)
{
    m_entries.append(entry);
    m_list->addItem(entry.name);
    if (m_entries.size() == 1)
        m_list->setCurrentRow(0);
}

void ExampleTab::onExampleSelected(int row)
{
    if (row < 0 || row >= m_entries.size())
        return;

    const ExampleEntry &e = m_entries[row];

    // Swap in the new graph widget
    clearGraph();
    QWidget *w = e.createWidget(m_graphContainer);
    m_graphLayout->addWidget(w);

    // Build description HTML
    QString html;
    html += "<p style='margin-top:6px'>" + e.description.toHtmlEscaped() + "</p>";
    if (!e.files.isEmpty()) {
        html += "<p><b>Source files:</b></p><ul style='margin:0; padding-left:20px'>";
        for (const QString &f : e.files)
            html += "<li><code>" + f.toHtmlEscaped() + "</code></li>";
        html += "</ul>";
    }
    m_descView->setHtml(html);
}

void ExampleTab::clearGraph()
{
    while (QLayoutItem *item = m_graphLayout->takeAt(0)) {
        if (QWidget *w = item->widget()) {
            w->hide();
            w->deleteLater();
        }
        delete item;
    }
}
