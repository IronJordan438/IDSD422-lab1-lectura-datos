# inspeccion.R — Tipos, columna derivada e indicadores (R)
# Completa los pasos marcados con TODO. Ejecuta desde la raíz del repositorio:
#   Rscript scripts/inspeccion.R

# TODO 1: carga data/ventas.csv
# TODO 2: imprime la estructura (str) para ver los tipos
#         (fija si region llegó como character o factor)
# TODO 3: crea la columna derivada "ticket" = ventas / clientes
# TODO 4: calcula e imprime:
#         - venta promedio por sucursal (aggregate o dplyr)
#         - ticket promedio (ventas totales / clientes totales)
#         - sucursal con mayor y menor venta
#         - región con mayor venta total
#Cargar el archivo CSV
ventas <- read_csv("data/ventas.csv")

#Crear la columna derivada "ticket" = ventas / clientes
ventas <- ventas %>%
  mutate(ticket = ventas / clientes)

# Imprimir el DataFrame completo
print(ventas)

#Sucursal con mayor venta
sucursal_max <- ventas %>%
  filter(ventas == max(ventas)) %>%
  pull(sucursal)

cat("Sucursal con mayor venta:", sucursal_max, "\n")

# Sucursal con menor venta
sucursal_min <- ventas %>%
  filter(ventas == min(ventas)) %>%
  pull(sucursal)

cat("Sucursal con menor venta:", sucursal_min, "\n")

# Ventas totales por región
ventas_per_region <- ventas %>%
  group_by(region) %>%
  summarise(ventas_totales = sum(ventas))

cat("\n- Ventas totales por región:\n")
print(ventas_per_region)

# Región con mayor venta total
region_max <- ventas_per_region %>%
  filter(ventas_totales == max(ventas_totales)) %>%
  pull(region)

cat("\n• Región con mayor venta total:", region_max, "\n")

# Venta promedio por sucursal
venta_promedio <- mean(ventas$ventas)
cat(sprintf("• Venta promedio por sucursal: %.2f\n", venta_promedio))

# Ticket promedio global (ventas totales / clientes totales)
ticket_promedio_global <- sum(ventas$ventas) / sum(ventas$clientes)
cat(sprintf("• Ticket promedio global: %.2f\n", ticket_promedio_global))
