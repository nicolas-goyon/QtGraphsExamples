#include "Bars3DBasicDataProvider.h"

Bars3DBasicDataProvider::Bars3DBasicDataProvider(QObject *parent)
    : QAbstractListModel(parent)
{
    m_data = {
        {QStringLiteral("North"), QStringLiteral("Q1"), 3.5},
        {QStringLiteral("North"), QStringLiteral("Q2"), 4.2},
        {QStringLiteral("North"), QStringLiteral("Q3"), 5.8},
        {QStringLiteral("North"), QStringLiteral("Q4"), 7.1},
        {QStringLiteral("South"), QStringLiteral("Q1"), 2.8},
        {QStringLiteral("South"), QStringLiteral("Q2"), 3.6},
        {QStringLiteral("South"), QStringLiteral("Q3"), 4.9},
        {QStringLiteral("South"), QStringLiteral("Q4"), 6.3},
        {QStringLiteral("East"),  QStringLiteral("Q1"), 4.0},
        {QStringLiteral("East"),  QStringLiteral("Q2"), 5.5},
        {QStringLiteral("East"),  QStringLiteral("Q3"), 6.2},
        {QStringLiteral("East"),  QStringLiteral("Q4"), 8.0},
        {QStringLiteral("West"),  QStringLiteral("Q1"), 3.2},
        {QStringLiteral("West"),  QStringLiteral("Q2"), 4.8},
        {QStringLiteral("West"),  QStringLiteral("Q3"), 5.5},
        {QStringLiteral("West"),  QStringLiteral("Q4"), 6.9},
    };
}

int Bars3DBasicDataProvider::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return static_cast<int>(m_data.size());
}

QVariant Bars3DBasicDataProvider::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= static_cast<int>(m_data.size()))
        return {};
    const auto &pt = m_data.at(index.row());
    switch (role) {
    case RowRole:   return pt.row;
    case ColRole:   return pt.col;
    case ValueRole: return pt.value;
    default:        return {};
    }
}

QHash<int, QByteArray> Bars3DBasicDataProvider::roleNames() const
{
    return {
        {RowRole,   QByteArrayLiteral("row")},
        {ColRole,   QByteArrayLiteral("col")},
        {ValueRole, QByteArrayLiteral("value")},
    };
}
