# Generated manually for initial migration

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name='Producto',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombre', models.CharField(max_length=150)),
                ('descripcion', models.TextField(blank=True)),
                ('precio_compra', models.DecimalField(decimal_places=2, max_digits=10)),
                ('precio_venta', models.DecimalField(decimal_places=2, max_digits=10)),
                ('stock', models.PositiveIntegerField(default=0)),
                ('estado', models.CharField(
                    choices=[('activo', 'Activo'), ('inactivo', 'Inactivo')],
                    default='activo',
                    max_length=10,
                )),
            ],
            options={
                'verbose_name': 'Producto',
                'verbose_name_plural': 'Productos',
                'ordering': ['nombre'],
            },
        ),
        migrations.CreateModel(
            name='MovimientoInventario',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('tipo_movimiento', models.CharField(
                    choices=[('entrada', 'Entrada'), ('salida', 'Salida')],
                    max_length=10,
                )),
                ('cantidad', models.PositiveIntegerField()),
                ('fecha', models.DateTimeField(auto_now_add=True)),
                ('observacion', models.TextField(blank=True)),
                ('producto', models.ForeignKey(
                    on_delete=django.db.models.deletion.PROTECT,
                    related_name='movimientos',
                    to='inventario.producto',
                )),
            ],
            options={
                'verbose_name': 'Movimiento de inventario',
                'verbose_name_plural': 'Movimientos de inventario',
                'ordering': ['-fecha'],
            },
        ),
    ]
