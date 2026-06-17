#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>
#include <array>
#include <functional>

class ScatterChartTrendLinesDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ScatterChartTrendLinesDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList scatterData()        const;
    Q_INVOKABLE QVariantList linearTrend()        const;  // 50 pts, least-squares linear fit
    Q_INVOKABLE QVariantList quadraticTrend()     const;  // 50 pts, least-squares quadratic fit
    Q_INVOKABLE QVariantList exponentialTrend()   const;  // 50 pts, least-squares exponential fit
    Q_INVOKABLE QVariantList logarithmicTrend()   const;  // 50 pts, least-squares logarithmic fit
private:
    static constexpr int N = 25;
    static const double s_xs[N];
    static const double s_ys[N];

    // Returns {a, b} for y = a + b*u, computed via least squares on the supplied arrays.
    static std::pair<double, double> linReg(const double *us, const double *vs, int n);

    // Returns {a, b, c} for y = a + b*x + c*x², computed via Gaussian elimination.
    static std::array<double, 3> quadReg(const double *xs, const double *ys, int n);

    static QVariantList makeLine(double xMin, double xMax, int n,
                                 std::function<double(double)> fn);
};
