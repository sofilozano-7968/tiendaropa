from django.contrib import admin

from .models import MovimientoInventario, Producto


@admin.register(Producto)
class ProductoAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'precio_compra', 'precio_venta', 'stock', 'estado')
    list_filter = ('estado',)
    search_fields = ('nombre',)


@admin.register(MovimientoInventario)
class MovimientoInventarioAdmin(admin.ModelAdmin):
    list_display = ('producto', 'tipo_movimiento', 'cantidad', 'fecha')
    list_filter = ('tipo_movimiento', 'fecha')
    search_fields = ('producto__nombre', 'observacion')
