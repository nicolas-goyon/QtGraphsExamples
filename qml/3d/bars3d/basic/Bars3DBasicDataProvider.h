#pragma once
#include <QAbstractListModel>
#include <QtQml/qqmlregistration.h>

// Provides regional quarterly sales data as a list model for Bars3D.
// Compatible with ItemModelBarDataProxy (roles: "row", "col", "value").
// Swap the constructor body to load from file, network, etc.
class Bars3DBasicDataProvider : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    struct DataPoint { QString row; QString col; double value; };
    enum Roles { RowRole = Qt::UserRole + 1, ColRole, ValueRole };

public:
    explicit Bars3DBasicDataProvider(QObject *parent = nullptr);

    int      rowCount(const QModelIndex &parent = {}) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<DataPoint> m_data;
};
