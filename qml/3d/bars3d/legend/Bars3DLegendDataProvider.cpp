#include "Bars3DLegendDataProvider.h"

Bars3DLegendDataProvider::Bars3DLegendDataProvider(QObject *parent)
    : QAbstractListModel(parent)
{
    // Illustrative urban/rural population (millions, 2020)
    m_data = {
        {QStringLiteral("China"),  902.0, 510.0},
        {QStringLiteral("India"),  507.0, 882.0},
        {QStringLiteral("USA"),    274.0,  59.0},
        {QStringLiteral("Brazil"), 185.0,  33.0},
        {QStringLiteral("Russia"), 108.0,  37.0},
        {QStringLiteral("Japan"),  117.0,   8.0},
    };
}

int Bars3DLegendDataProvider::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return static_cast<int>(m_data.size());
}

QVariant Bars3DLegendDataProvider::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= static_cast<int>(m_data.size()))
        return {};
    const auto &pt = m_data.at(index.row());
    switch (role) {
    case CountryRole: return pt.country;
    case UrbanRole:   return pt.urban;
    case RuralRole:   return pt.rural;
    default:          return {};
    }
}

QHash<int, QByteArray> Bars3DLegendDataProvider::roleNames() const
{
    return {
        {CountryRole, QByteArrayLiteral("country")},
        {UrbanRole,   QByteArrayLiteral("urban")},
        {RuralRole,   QByteArrayLiteral("rural")},
    };
}
