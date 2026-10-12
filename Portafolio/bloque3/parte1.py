
import numpy as np

def qr_valores_propios(A, iterMax, tol):
    """Aproxima pares propios mediante iteración QR sin desplazamiento."""
    B = np.array(A, dtype=float, copy=True)
    n = B.shape[0]
    V = np.eye(n)
    valores = np.sort(np.diag(B))[::-1]
    erk = np.inf
    k = 0
    conv = 0

    for k in range(1, iterMax + 1):
        anteriores = valores.copy()
        # factorización QR 
        Q, R = np.linalg.qr(B)
        B = R @ Q
        V = V @ Q

        # Ordenar solo la copia usada para comparar aproximaciones
        valores = np.sort(np.diag(B))[::-1]
        erk = np.linalg.norm(valores - anteriores)
        if erk < tol:
            conv = 1
            break

    # Mantener la correspondencia entre valores y columnas de V.
    indices = np.argsort(np.diag(B))[::-1]
    valores = np.diag(B)[indices].copy()
    V = V[:, indices].copy()
    for j in range(n):
        V[:, j] /= np.linalg.norm(V[:, j])
    return valores, V, erk, k, conv


def jacobi_valores_propios(A, iterMax, tol):
    """Aproxima pares propios mediante el método de Jacobi."""
    B = np.array(A, dtype=float, copy=True)
    n = B.shape[0]
    V = np.eye(n)
    valores = np.sort(np.diag(B))[::-1]
    erk = np.inf
    k = 0
    conv = 0
    filas = np.arange(n)

    for k in range(1, iterMax + 1):
        anteriores = valores.copy()
        for p in range(n - 1):
            for q in range(p + 1, n):
                apq = B[p, q]
                if apq == 0.0:
                    continue
                app = B[p, p]
                aqq = B[q, q]
                tau = (aqq - app) / (2.0 * apq)
                # hypot(1, tau) calcula sqrt(1 + tau**2).
                # Esta elección incluye tau = 0, para el cual t = 1.
                if tau >= 0:
                    t = 1.0 / (tau + np.hypot(1.0, tau))
                else:
                    t = -1.0 / (-tau + np.hypot(1.0, tau))
                c = 1.0 / np.sqrt(1.0 + t * t)
                s = t * c

                otros = (filas != p) & (filas != q)
                bp = B[otros, p].copy()
                bq = B[otros, q].copy()
                B[otros, p] = c * bp - s * bq
                B[p, otros] = B[otros, p]
                B[otros, q] = s * bp + c * bq
                B[q, otros] = B[otros, q]
                B[p, p] = app - t * apq
                B[q, q] = aqq + t * apq
                B[p, q] = B[q, p] = 0.0

                # Ambas columnas nuevas utilizan los valores anteriores.
                vp = V[:, p].copy()
                vq = V[:, q].copy()
                V[:, p] = c * vp - s * vq
                V[:, q] = s * vp + c * vq

        valores = np.sort(np.diag(B))[::-1]
        erk = np.linalg.norm(valores - anteriores)
        if erk < tol:
            conv = 1
            break

    indices = np.argsort(np.diag(B))[::-1]
    valores = np.diag(B)[indices].copy()
    V = V[:, indices].copy()
    for j in range(n):
        V[:, j] /= np.linalg.norm(V[:, j])
    return valores, V, erk, k, conv
