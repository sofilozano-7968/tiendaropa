from django import forms

from .models import MovimientoInventario, Producto


class ProductoForm(forms.ModelForm):
    class Meta:
        model = Producto
        fields = [
            'nombre',
            'descripcion',
            'precio_compra',
            'precio_venta',
            'stock',
            'estado',
        ]
        widgets = {
            'nombre': forms.TextInput(attrs={'class': 'form-control'}),
            'descripcion': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
            'precio_compra': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.01'}),
            'precio_venta': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.01'}),
            'stock': forms.NumberInput(attrs={'class': 'form-control', 'min': '0'}),
            'estado': forms.Select(attrs={'class': 'form-select'}),
        }

    def clean_precio_venta(self):
        precio_venta = self.cleaned_data.get('precio_venta')
        precio_compra = self.cleaned_data.get('precio_compra')
        if precio_venta is not None and precio_compra is not None:
            if precio_venta < precio_compra:
                raise forms.ValidationError(
                    'El precio de venta no puede ser menor al precio de compra.'
                )
        return precio_venta


class MovimientoInventarioForm(forms.ModelForm):
    class Meta:
        model = MovimientoInventario
        fields = ['producto', 'tipo_movimiento', 'cantidad', 'observacion']
        widgets = {
            'producto': forms.Select(attrs={'class': 'form-select'}),
            'tipo_movimiento': forms.Select(attrs={'class': 'form-select'}),
            'cantidad': forms.NumberInput(attrs={'class': 'form-control', 'min': '1'}),
            'observacion': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
        }

    def clean(self):
        cleaned_data = super().clean()
        producto = cleaned_data.get('producto')
        tipo_movimiento = cleaned_data.get('tipo_movimiento')
        cantidad = cleaned_data.get('cantidad')

        if producto and tipo_movimiento == MovimientoInventario.TIPO_SALIDA and cantidad:
            if producto.stock < cantidad:
                raise forms.ValidationError(
                    f'Stock insuficiente. Disponible: {producto.stock}'
                )
        return cleaned_data
