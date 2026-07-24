from decimal import Decimal
from collections import defaultdict

from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.exceptions import ValidationError
from django.db import transaction
from django.shortcuts import redirect
from django.urls import reverse_lazy
from django.views.generic import CreateView, DetailView, ListView

from inventario.models import Producto

from .forms import DetalleVentaFormSet, VentaForm
from .models import DetalleVenta, Venta


class VentaListView(LoginRequiredMixin, ListView):
    model = Venta
    template_name = 'ventas/venta_list.html'
    context_object_name = 'ventas'
    paginate_by = 10


class VentaDetailView(LoginRequiredMixin, DetailView):
    model = Venta
    template_name = 'ventas/venta_detail.html'
    context_object_name = 'venta'


class VentaCreateView(LoginRequiredMixin, CreateView):
    model = Venta
    form_class = VentaForm
    template_name = 'ventas/venta_form.html'
    success_url = reverse_lazy('venta_list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if self.request.POST:
            context['formset'] = DetalleVentaFormSet(self.request.POST)
        else:
            context['formset'] = DetalleVentaFormSet()
        context['productos'] = list(
            Producto.objects.filter(
                estado=Producto.ESTADO_ACTIVO
            ).order_by('nombre').values('pk', 'nombre', 'precio_venta', 'stock')
        )
        return context

    def form_valid(self, form):
        context = self.get_context_data()
        formset = context['formset']

        if not formset.is_valid():
            return self.form_invalid(form)

        detalles_validos = [
            f for f in formset.forms
            if f.cleaned_data and not f.cleaned_data.get('DELETE', False)
            and f.cleaned_data.get('producto')
        ]

        if not detalles_validos:
            form.add_error(None, 'Debe agregar al menos un producto a la venta.')
            return self.form_invalid(form)

        try:
            with transaction.atomic():
                cantidades_por_producto = defaultdict(int)
                for detalle_form in detalles_validos:
                    producto = detalle_form.cleaned_data['producto']
                    cantidades_por_producto[producto.pk] += detalle_form.cleaned_data['cantidad']

                for producto_id, cantidad_total in cantidades_por_producto.items():
                    DetalleVenta.descontar_stock(producto_id, cantidad_total)

                self.object = form.save(commit=False)
                total = Decimal('0.00')

                for detalle_form in detalles_validos:
                    producto = detalle_form.cleaned_data['producto']
                    cantidad = detalle_form.cleaned_data['cantidad']
                    precio = producto.precio_venta
                    total += cantidad * precio

                self.object.total = total
                self.object.save()

                for detalle_form in detalles_validos:
                    producto = detalle_form.cleaned_data['producto']
                    cantidad = detalle_form.cleaned_data['cantidad']
                    precio = producto.precio_venta
                    DetalleVenta.objects.create(
                        venta=self.object,
                        producto=producto,
                        cantidad=cantidad,
                        precio=precio,
                        subtotal=cantidad * precio,
                    )

            messages.success(self.request, 'Venta registrada correctamente.')
            return redirect(self.success_url)

        except ValidationError as e:
            if hasattr(e, 'message_dict'):
                for field, errors in e.message_dict.items():
                    for error in errors:
                        form.add_error(None, error)
            else:
                form.add_error(None, e.messages[0] if e.messages else str(e))
            return self.form_invalid(form)

    def form_invalid(self, form):
        return self.render_to_response(self.get_context_data(form=form))
