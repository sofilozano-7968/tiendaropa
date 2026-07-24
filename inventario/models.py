from decimal import Decimal

from django.core.exceptions import ValidationError
from django.db import models, transaction
from django.core.validators import MinValueValidator

class Producto(models.Model):
    ESTADO_ACTIVO = 'activo'
    ESTADO_INACTIVO = 'inactivo'
    ESTADO_CHOICES = [
        (ESTADO_ACTIVO, 'Activo'),
        (ESTADO_INACTIVO, 'Inactivo'),
    ]

    nombre = models.CharField(max_length=150)
    descripcion = models.TextField(blank=True)
    precio_compra = models.DecimalField(max_digits=10, decimal_places=2)
    precio_venta = models.DecimalField(max_digits=10, decimal_places=2)
    stock = models.PositiveIntegerField(default=0)
    estado = models.CharField(
        max_length=10,
        choices=ESTADO_CHOICES,
        default=ESTADO_ACTIVO,
    )

    class Meta:
        ordering = ['nombre']
        verbose_name = 'Producto'
        verbose_name_plural = 'Productos'

    def __str__(self):
        return self.nombre


class MovimientoInventario(models.Model):
    TIPO_ENTRADA = 'entrada'
    TIPO_SALIDA = 'salida'
    TIPO_CHOICES = [
        (TIPO_ENTRADA, 'Entrada'),
        (TIPO_SALIDA, 'Salida'),
    ]

    producto = models.ForeignKey(
        Producto,
        on_delete=models.PROTECT,
        related_name='movimientos',
    )
    tipo_movimiento = models.CharField(max_length=10, choices=TIPO_CHOICES)
    cantidad = models.PositiveIntegerField(
        validators=[MinValueValidator(1)]
    )
    fecha = models.DateTimeField(auto_now_add=True)
    observacion = models.TextField(blank=True)

    class Meta:
        ordering = ['-fecha']
        verbose_name = 'Movimiento de inventario'
        verbose_name_plural = 'Movimientos de inventario'

    def __str__(self):
        return f'{self.get_tipo_movimiento_display()} - {self.producto.nombre}'

    def clean(self):
        if self.tipo_movimiento == self.TIPO_SALIDA and self.producto_id:
            if self.producto.stock < self.cantidad:
                raise ValidationError(
                    f'Stock insuficiente. Disponible: {self.producto.stock}'
                )

    def save(self, *args, **kwargs):
        is_new = self._state.adding
        with transaction.atomic():
            if is_new:
                producto = Producto.objects.select_for_update().get(
                    pk=self.producto_id
                )
                if self.tipo_movimiento == self.TIPO_ENTRADA:
                    producto.stock += self.cantidad
                else:
                    if producto.stock < self.cantidad:
                        raise ValidationError(
                            f'Stock insuficiente. Disponible: {producto.stock}'
                        )
                    producto.stock -= self.cantidad
                producto.save()
            super().save(*args, **kwargs)
