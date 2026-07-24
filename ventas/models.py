from decimal import Decimal

from django.core.exceptions import ValidationError
from django.db import models, transaction

from inventario.models import Producto


class Venta(models.Model):
    fecha = models.DateTimeField(auto_now_add=True)
    total = models.DecimalField(max_digits=12, decimal_places=2, default=Decimal('0.00'))

    class Meta:
        ordering = ['-fecha']
        verbose_name = 'Venta'
        verbose_name_plural = 'Ventas'

    def __str__(self):
        return f'Venta #{self.pk} - {self.fecha:%d/%m/%Y %H:%M}'


class DetalleVenta(models.Model):
    venta = models.ForeignKey(
        Venta,
        on_delete=models.CASCADE,
        related_name='detalles',
    )
    producto = models.ForeignKey(
        Producto,
        on_delete=models.PROTECT,
        related_name='detalles_venta',
    )
    cantidad = models.PositiveIntegerField()
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    subtotal = models.DecimalField(max_digits=12, decimal_places=2)

    class Meta:
        verbose_name = 'Detalle de venta'
        verbose_name_plural = 'Detalles de venta'

    def __str__(self):
        return f'{self.producto.nombre} x {self.cantidad}'

    def calcular_subtotal(self):
        return self.cantidad * self.precio

    def clean(self):
        if self.producto_id and self.cantidad:
            if self.producto.stock < self.cantidad:
                raise ValidationError(
                    f'Stock insuficiente para {self.producto.nombre}. '
                    f'Disponible: {self.producto.stock}'
                )

    def save(self, *args, **kwargs):
        self.subtotal = self.calcular_subtotal()
        super().save(*args, **kwargs)

    @staticmethod
    def descontar_stock(producto_id, cantidad):
        """Descuenta stock del producto dentro de una transacción."""
        producto = Producto.objects.select_for_update().get(pk=producto_id)
        if producto.stock < cantidad:
            raise ValidationError(
                f'Stock insuficiente para {producto.nombre}. '
                f'Disponible: {producto.stock}'
            )
        producto.stock -= cantidad
        producto.save()
