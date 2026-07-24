from decimal import Decimal

from django import forms
from django.forms import inlineformset_factory

from inventario.models import Producto

from .models import DetalleVenta, Venta


class VentaForm(forms.ModelForm):
    class Meta:
        model = Venta
        fields = []


from decimal import Decimal

from django import forms
from django.forms import inlineformset_factory

from inventario.models import Producto

from .models import DetalleVenta, Venta


class ProductoSelect(forms.Select):
    """Select con data-precio y data-stock en cada opción."""

    def create_option(self, name, value, label, selected, index, subindex=None, attrs=None):
        option = super().create_option(
            name, value, label, selected, index, subindex=subindex, attrs=attrs
        )
        if value:
            try:
                producto = Producto.objects.get(pk=value)
                option['attrs']['data-precio'] = str(producto.precio_venta)
                option['attrs']['data-stock'] = str(producto.stock)
            except (Producto.DoesNotExist, ValueError, TypeError):
                pass
        return option


class DetalleVentaForm(forms.ModelForm):
    class Meta:
        model = DetalleVenta
        fields = ['producto', 'cantidad']
        widgets = {
            'producto': ProductoSelect(attrs={'class': 'form-select producto-select'}),
            'cantidad': forms.NumberInput(attrs={
                'class': 'form-control cantidad-input',
                'min': '1',
                'value': '1',
            }),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        queryset = Producto.objects.filter(
            estado=Producto.ESTADO_ACTIVO
        ).order_by('nombre')
        self.fields['producto'].queryset = queryset
        self.fields['producto'].empty_label = 'Seleccione un producto'
        self.fields['producto'].label_from_instance = (
            lambda obj: f'{obj.nombre} — ${obj.precio_venta} (Stock: {obj.stock})'
        )
        if not self.instance.pk and not self.data:
            self.fields['cantidad'].initial = 1

    def clean(self):
        cleaned_data = super().clean()
        producto = cleaned_data.get('producto')
        cantidad = cleaned_data.get('cantidad')

        if producto and cantidad:
            if producto.stock < cantidad:
                raise forms.ValidationError(
                    f'Stock insuficiente para {producto.nombre}. '
                    f'Disponible: {producto.stock}'
                )
        return cleaned_data


DetalleVentaFormSet = inlineformset_factory(
    Venta,
    DetalleVenta,
    form=DetalleVentaForm,
    extra=1,
    can_delete=True,
    min_num=1,
    validate_min=True,
)
