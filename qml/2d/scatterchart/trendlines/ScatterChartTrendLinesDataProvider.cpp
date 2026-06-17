#include "ScatterChartTrendLinesDataProvider.h"
#include <QVariantMap>
#include <cmath>

// ── shared data ──────────────────────────────────────────────────────────────
const double ScatterChartTrendLinesDataProvider::s_xs[N] = {
    1.0, 1.5, 2.0, 2.5,  3.0,  3.5,  4.0,  4.5,  5.0,  5.5,
    6.0, 6.5, 7.0, 7.5,  8.0,  8.5,  9.0,  9.5, 10.0, 10.5,
   11.0,11.5,12.0,12.5, 13.0
};
const double ScatterChartTrendLinesDataProvider::s_ys[N] = {
     6.2,  4.8,  4.1,  3.9,  4.3,  4.8,  5.1,  5.9,  7.2,  8.1,
     9.3, 11.1, 13.5, 15.2, 17.8, 21.1, 23.4, 26.8, 30.2, 33.5,
    38.1, 41.4, 46.2, 52.0, 56.3
};

ScatterChartTrendLinesDataProvider::ScatterChartTrendLinesDataProvider(QObject *parent)
    : QObject(parent) {}

// ── regression helpers ────────────────────────────────────────────────────────

// Ordinary least squares: y = a + b*u.  Returns {a, b}.
std::pair<double, double>
ScatterChartTrendLinesDataProvider::linReg(const double *us, const double *vs, int n)
{
    double su = 0, sv = 0, suu = 0, suv = 0;
    for (int i = 0; i < n; ++i) {
        su  += us[i];
        sv  += vs[i];
        suu += us[i] * us[i];
        suv += us[i] * vs[i];
    }
    const double denom = n * suu - su * su;
    const double b = (n * suv - su * sv) / denom;
    const double a = (sv - b * su) / n;
    return {a, b};
}

// Least-squares quadratic: y = a + b*x + c*x².
// Builds the 3×3 normal-equation system and solves it with Gaussian elimination.
std::array<double, 3>
ScatterChartTrendLinesDataProvider::quadReg(const double *xs, const double *ys, int n)
{
    double sx=0, sx2=0, sx3=0, sx4=0, sy=0, sxy=0, sx2y=0;
    for (int i = 0; i < n; ++i) {
        const double x = xs[i], y = ys[i], x2 = x*x;
        sx   += x;    sx2  += x2;    sx3 += x2*x;  sx4 += x2*x2;
        sy   += y;    sxy  += x*y;   sx2y += x2*y;
    }

    // Augmented matrix [A | b] for the normal equations
    double M[3][4] = {
        { (double)n, sx,  sx2, sy   },
        { sx,        sx2, sx3, sxy  },
        { sx2,       sx3, sx4, sx2y }
    };

    // Forward elimination
    for (int col = 0; col < 3; ++col) {
        for (int row = col + 1; row < 3; ++row) {
            const double f = M[row][col] / M[col][col];
            for (int k = col; k <= 3; ++k)
                M[row][k] -= f * M[col][k];
        }
    }

    // Back substitution
    const double c = M[2][3] / M[2][2];
    const double b = (M[1][3] - M[1][2] * c) / M[1][1];
    const double a = (M[0][3] - M[0][1] * b - M[0][2] * c) / M[0][0];
    return {a, b, c};
}

// ── point generator ──────────────────────────────────────────────────────────
QVariantList ScatterChartTrendLinesDataProvider::makeLine(double xMin, double xMax,
                                                          int n,
                                                          std::function<double(double)> fn)
{
    QVariantList result;
    for (int i = 0; i < n; ++i) {
        const double x = xMin + i * (xMax - xMin) / (n - 1);
        QVariantMap m;
        m["x"] = x;
        m["y"] = fn(x);
        result << m;
    }
    return result;
}

// ── public API ───────────────────────────────────────────────────────────────
QVariantList ScatterChartTrendLinesDataProvider::scatterData() const
{
    QVariantList result;
    for (int i = 0; i < N; ++i) {
        QVariantMap m;
        m["x"] = s_xs[i];
        m["y"] = s_ys[i];
        result << m;
    }
    return result;
}

QVariantList ScatterChartTrendLinesDataProvider::linearTrend() const
{
    // Fit y = a + b*x via OLS
    auto [a, b] = linReg(s_xs, s_ys, N);
    return makeLine(s_xs[0], s_xs[N - 1], 50,
                    [a, b](double x) { return a + b * x; });
}

QVariantList ScatterChartTrendLinesDataProvider::quadraticTrend() const
{
    // Fit y = a + b*x + c*x² via OLS normal equations
    auto [a, b, c] = quadReg(s_xs, s_ys, N);
    return makeLine(s_xs[0], s_xs[N - 1], 50,
                    [a, b, c](double x) { return a + b * x + c * x * x; });
}

QVariantList ScatterChartTrendLinesDataProvider::exponentialTrend() const
{
    // Linearise: ln(y) = ln(A) + b*x, then fit via OLS
    double lny[N];
    for (int i = 0; i < N; ++i) lny[i] = std::log(s_ys[i]);
    auto [lnA, b] = linReg(s_xs, lny, N);
    const double A = std::exp(lnA);
    return makeLine(s_xs[0], s_xs[N - 1], 50,
                    [A, b](double x) { return A * std::exp(b * x); });
}

QVariantList ScatterChartTrendLinesDataProvider::logarithmicTrend() const
{
    // Linearise: y = a + b*ln(x), then fit via OLS
    double lnx[N];
    for (int i = 0; i < N; ++i) lnx[i] = std::log(s_xs[i]);
    auto [a, b] = linReg(lnx, s_ys, N);
    return makeLine(s_xs[0], s_xs[N - 1], 50,
                    [a, b](double x) { return a + b * std::log(x); });
}
