# Generated manually for initial migration

import decimal

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('inventario', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Venta',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('fecha', models.DateTimeField(auto_now_add=True)),
                ('total', models.DecimalField(decimal_places=2, default=decimal.Decimal('0.00'), max_digits=12)),
            ],
            options={
                'verbose_name': 'Venta',
                'verbose_name_plural': 'Ventas',
                'ordering': ['-fecha'],
            },
        ),
        migrations.CreateModel(
            name='DetalleVenta',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cantidad', models.PositiveIntegerField()),
                ('precio', models.DecimalField(decimal_places=2, max_digits=10)),
                ('subtotal', models.DecimalField(decimal_places=2, max_digits=12)),
                ('producto', models.ForeignKey(
                    on_delete=django.db.models.deletion.PROTECT,
                    related_name='detalles_venta',
                    to='inventario.producto',
                )),
                ('venta', models.ForeignKey(
                    on_delete=django.db.models.deletion.CASCADE,
                    related_name='detalles',
                    to='ventas.venta',
                )),
            ],
            options={
                'verbose_name': 'Detalle de venta',
                'verbose_name_plural': 'Detalles de venta',
            },
        ),
    ]
