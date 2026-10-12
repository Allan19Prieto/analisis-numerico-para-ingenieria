"""Bloque 3 - Parte II: comparación de valores y vectores propios.

Coloque este archivo junto a parte1.py.
Instalación: python -m pip install numpy matplotlib
Ejecución:   python parte2.py
Sin abrir ventanas: python parte2.py --sin-ventanas

Se muestran los 200 valores, las matrices V completas y los 200 residuos.
La misma salida se guarda en resultados_parte2/resultados.txt, junto con
las gráficas. Las mediciones excluyen impresión, validación y gráficas.
"""

import argparse
from pathlib import Path
from time import perf_counter

import numpy as np

from parte1 import qr_valores_propios, jacobi_valores_propios


def evaluar_metodo(nombre, metodo, A, iterMax, tol):
    """Ejecuta un método importado y calcula las comprobaciones externas."""
    inicio = perf_counter()
    valores, V, erk, k, conv = metodo(A, iterMax, tol)
    tiempo = perf_counter() - inicio

    n = A.shape[0]
    residuos = np.zeros(n)
    normas = np.zeros(n)
    for j in range(n):
        v = V[:, j]
        residuos[j] = np.linalg.norm(A @ v - valores[j] * v)
        normas[j] = np.linalg.norm(v)

    return {
        "nombre": nombre,
        "valores": valores,
        "V": V,
        "erk": erk,
        "k": k,
        "conv": conv,
        "tiempo": tiempo,
        "residuos": residuos,
        "rmax": np.max(residuos),
        "normas": normas,
        "error_norma": np.max(np.abs(normas - 1.0)),
        "erort": np.linalg.norm(V.T @ V - np.eye(n), "fro"),
    }


def construir_analisis(resultados, tol, iterMax):
    """Interpreta las mediciones de esta ejecución, sin fijar resultados."""
    qr, jacobi = resultados
    diferencia = np.max(np.abs(qr["valores"] - jacobi["valores"]))
    lineas = [
        "ANÁLISIS COMPARATIVO",
        "=" * 90,
        "1. Valores propios y criterio de parada",
        f"La máxima diferencia entre valores ordenados de QR y Jacobi es {diferencia:.8e}.",
        "Esta diferencia compara los métodos; no es un error frente a una solución exacta.",
    ]
    for r in resultados:
        unidad = "barridos" if r["nombre"] == "Jacobi" else "iteraciones QR"
        if r["conv"] == 1:
            lineas.append(
                f'{r["nombre"]} alcanzó erk < {tol:.1e} en {r["k"]} {unidad} '
                f'(erk = {r["erk"]:.8e}).'
            )
        else:
            lineas.append(
                f'{r["nombre"]} no alcanzó la tolerancia dentro de {iterMax} '
                f'iteraciones permitidas: erk = {r["erk"]:.8e}, conv = 0. '
                'Su resultado debe interpretarse como la aproximación al agotar el límite.'
            )

    # Esta comprobación compara los dos resultados a la escala solicitada;
    # no reemplaza el criterio de parada ni la validación de cada par propio.
    if diferencia < tol:
        lineas.append("Los dos espectros coinciden entre sí dentro de la tolerancia absoluta solicitada.")
    else:
        lineas.append(
            "Las aproximaciones no coinciden entre sí dentro de la tolerancia absoluta solicitada; "
            "no se deben presentar como resultados de igual precisión."
        )
    lineas.extend([
        "",
        "2. Residuos y calidad de los pares propios",
        f'QR: rmax = {qr["rmax"]:.8e}. Jacobi: rmax = {jacobi["rmax"]:.8e}.',
        "Un residuo pequeño indica que el par calculado satisface aproximadamente Av = lambda*v.",
        "El cambio de la diagonal ordenada puede ser pequeño aunque los vectores todavía tengan "
        "residuos apreciables. Por eso se reportan tanto erk como los residuos de los 200 pares.",
        "",
        "3. Normalización y ortogonalidad",
    ])
    for r in resultados:
        lineas.append(
            f'{r["nombre"]}: máximo |norma(vj)-1| = {r["error_norma"]:.8e}; '
            f'norma de Frobenius de V.T@V-I = {r["erort"]:.8e}.'
        )
    lineas.extend([
        "Los métodos acumulan transformaciones ortogonales y normalizan sus columnas al retornar.",
        "La ortogonalidad por sí sola no demuestra que las columnas sean buenos vectores propios: "
        "también deben revisarse sus residuos.",
        "Los signos de los vectores pueden diferir: v y -v son igualmente válidos. "
        "Por ello no se compara V de ambos métodos mediante igualdad elemento a elemento.",
        "",
        "4. Iteraciones y tiempo de ejecución",
        f'QR realizó {qr["k"]} iteraciones y tardó {qr["tiempo"]:.6f} s. '
        f'Jacobi realizó {jacobi["k"]} barridos y tardó {jacobi["tiempo"]:.6f} s.',
        "Una iteración QR incluye una factorización y productos matriciales. "
        "Un barrido Jacobi visita 19900 pares de índices y omite los que ya tienen entrada cero. "
        "Los contadores no representan unidades de trabajo equivalentes.",
        "La versión QR empleada no usa desplazamientos ni deflación. "
        "Los valores propios próximos de esta matriz pueden hacer lenta su convergencia. "
        "Jacobi cíclico actúa directamente sobre las entradas fuera de la diagonal.",
    ])
    rapido = min(resultados, key=lambda r: r["tiempo"])
    lento = max(resultados, key=lambda r: r["tiempo"])
    if rapido["tiempo"] > 0:
        lineas.append(
            f'En esta ejecución, {rapido["nombre"]} fue el más rápido; '
            f'el cociente de tiempos mayor/menor fue {lento["tiempo"] / rapido["tiempo"]:.2f}.'
        )
    lineas.extend([
        "Los tiempos corresponden a una medición por método y dependen del equipo, la carga "
        "y la biblioteca de álgebra lineal. No son una clasificación universal de los algoritmos.",
        "Aunque A es tridiagonal, estas implementaciones almacenan matrices densas; "
        "no implementan un QR especializado para matrices tridiagonales.",
        "",
        "5. Diferencias en la aplicación del criterio de parada",
        "La fórmula de parada es la misma: erk = norma(lambda_actual-lambda_anterior), "
        "con ambas aproximaciones ordenadas de mayor a menor. En QR se evalúa después "
        "de cada paso QR y en Jacobi después de cada barrido completo. "
        "conv = 1 significa únicamente que se cumplió ese criterio.",
        "",
        "6. Conclusión de la comparación",
    ])
    convergentes = [r for r in resultados if r["conv"] == 1]
    candidatos = convergentes if convergentes else resultados
    mejor = min(candidatos, key=lambda r: r["rmax"])
    if convergentes:
        lineas.append(
            f'Entre los métodos que alcanzaron la tolerancia, {mejor["nombre"]} obtuvo '
            f'el menor residuo máximo ({mejor["rmax"]:.8e}). Este resultado debe considerarse '
            'junto con el tiempo al seleccionar el método para la siguiente parte.'
        )
    else:
        lineas.append(
            "Ninguno alcanzó la tolerancia. Se deben informar ambas aproximaciones como "
            "no convergentes bajo el límite establecido, sin modificar los parámetros para ocultarlo."
        )
    lineas.append(
        "La comparación corresponde a esta matriz; no garantiza el mismo comportamiento "
        "para las matrices de la aplicación de reconocimiento facial."
    )
    return "\n".join(lineas)


def generar_graficas(resultados, carpeta, plt):
    """Guarda las tres comparaciones requeridas por el enunciado."""
    nombres = [r["nombre"] for r in resultados]
    colores = ["#265D97", "#218477"]
    configuraciones = [
        ("erk", "Error final entre aproximaciones", "Error final erk", "01_error_final.png"),
        ("tiempo", "Tiempo de ejecución de los métodos", "Tiempo (segundos)", "02_tiempos.png"),
        ("k", "Iteraciones QR y barridos Jacobi", "Número de iteraciones o barridos", "03_iteraciones.png"),
    ]
    for clave, titulo, etiqueta, archivo in configuraciones:
        datos = np.array([r[clave] for r in resultados], dtype=float)
        fig, ax = plt.subplots(figsize=(7.8, 5.3))
        ax.bar(nombres, datos, color=colores, width=0.5, zorder=3)
        positivos = datos[datos > 0]
        escala = "lineal"
        # Usar log cuando las magnitudes difieren mucho. Si hay cero,
        # symlog lo representa sin reemplazarlo por un dato inventado.
        if len(positivos) == len(datos) and max(datos) / min(datos) >= 100:
            ax.set_yscale("log")
            escala = "logarítmica"
            ax.set_ylim(min(datos) / 3, max(datos) * 5)
        elif len(positivos) and np.any(datos == 0):
            ax.set_yscale("symlog", linthresh=min(positivos) / 10)
            escala = "symlog con cero exacto"
            ax.set_ylim(0, max(datos) * 5)
        else:
            ax.set_ylim(0, max(float(max(datos)) * 1.25, 1e-15))
        for i, valor in enumerate(datos):
            texto = f"{int(valor)}" if clave == "k" else f"{valor:.3e}"
            ax.annotate(texto, (i, valor), xytext=(0, 7), textcoords="offset points", ha="center")
        ax.set_title(titulo, pad=15)
        ax.set_ylabel(etiqueta)
        ax.grid(axis="y", alpha=0.25, zorder=0)
        ax.spines[["top", "right"]].set_visible(False)
        nota = f"A de 200 × 200 | tol = 1e-8 | iterMax = 10000 | escala {escala}"
        if clave == "k":
            nota += "\nUn paso QR y un barrido Jacobi tienen costos diferentes."
        fig.text(0.5, 0.035, nota, ha="center", fontsize=9)
        fig.tight_layout(rect=(0, 0.12, 1, 1))
        fig.savefig(carpeta / archivo, dpi=180, bbox_inches="tight")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--sin-ventanas", action="store_true", help="Guardar gráficas sin abrir ventanas.")
    args = parser.parse_args()

    import matplotlib
    if args.sin_ventanas:
        matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    n = 200
    iterMax = 10000
    tol = 1e-8
    # Generar A directamente: diagonal 4 y diagonales adyacentes -1.
    A = 4.0 * np.eye(n) - np.diag(np.ones(n - 1), 1) - np.diag(np.ones(n - 1), -1)
    carpeta = Path(__file__).resolve().parent / "resultados_parte2"
    carpeta.mkdir(exist_ok=True)

    resultados = []
    for nombre, metodo in [("QR", qr_valores_propios), ("Jacobi", jacobi_valores_propios)]:
        print(f"Calculando {nombre}...", flush=True)
        resultados.append(evaluar_metodo(nombre, metodo, A, iterMax, tol))

    generar_graficas(resultados, carpeta, plt)
    lineas = [
        "PORTAFOLIO COMPUTACIONAL - BLOQUE 3 - PARTE II",
        "Matriz tridiagonal simétrica: diagonal 4 y diagonales adyacentes -1.",
        f"n = {n}; iterMax = {iterMax}; tol = {tol:.1e}.",
        "Valores ordenados de mayor a menor; columna j de V asociada al valor j.",
        "Salida de texto y tres gráficas guardadas en: " + str(carpeta),
        "",
    ]
    for r in resultados:
        lineas.extend([
            "=" * 90,
            r["nombre"] + " - VALORES PROPIOS",
            np.array2string(r["valores"], threshold=np.inf, max_line_width=160,
                            formatter={"float_kind": lambda x: f"{x:.12e}"}),
            "",
            r["nombre"] + " - MATRIZ V COMPLETA (200 FILAS Y 200 COLUMNAS)",
            np.array2string(r["V"], threshold=np.inf, max_line_width=160,
                            formatter={"float_kind": lambda x: f"{x:.12e}"}),
            "",
            f'{"Par":>5} {"Valor propio":>21} {"Norma del vector":>20} {"Residuo":>20}',
        ])
        for j in range(n):
            lineas.append(
                f'{j+1:5d} {r["valores"][j]:21.12e} {r["normas"][j]:20.12e} {r["residuos"][j]:20.12e}'
            )
        lineas.append("")

    lineas.extend([
        "TABLA COMPARATIVA",
        "=" * 110,
        f'{"Método":<10} {"erk":>14} {"k":>8} {"Tiempo (s)":>14} {"conv":>6} {"rmax":>14} {"erort":>14}',
        "-" * 110,
    ])
    for r in resultados:
        lineas.append(
            f'{r["nombre"]:<10} {r["erk"]:14.6e} {r["k"]:8d} '
            f'{r["tiempo"]:14.6f} {r["conv"]:6d} {r["rmax"]:14.6e} {r["erort"]:14.6e}'
        )
    lineas.append("\nk = pasos QR o barridos completos Jacobi, según el método.\n")
    lineas.append(construir_analisis(resultados, tol, iterMax))
    informe = "\n".join(lineas)
    (carpeta / "resultados.txt").write_text(informe + "\n", encoding="utf-8")
    print(informe)
    if not args.sin_ventanas:
        plt.show()
    plt.close("all")


if __name__ == "__main__":
    main()
