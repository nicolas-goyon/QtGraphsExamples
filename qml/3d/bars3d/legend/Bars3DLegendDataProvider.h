#pragma once
#include <QAbstractListModel>
#include <QtQml/qqmlregistration.h>

// Provides urban and rural population data (millions, 2020) for six countries.
// Compatible with ItemModelBarDataProxy via "country", "urban", "rural" roles.
class Bars3DLegendDataProvider : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    struct DataPoint { QString country; double urban; double rural; };
    enum Roles { CountryRole = Qt::UserRole + 1, UrbanRole, RuralRole };

public:
    explicit Bars3DLegendDataProvider(QObject *parent = nullptr);

    int      rowCount(const QModelIndex &parent = {}) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<DataPoint> m_data;
};
