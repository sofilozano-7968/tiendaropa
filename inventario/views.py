from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.exceptions import ValidationError
from django.db import transaction
from django.db.models import Q, Sum
from django.db.models.deletion import ProtectedError
from django.shortcuts import redirect
from django.urls import reverse_lazy
from django.views.generic import (
    CreateView,
    DeleteView,
    ListView,
    TemplateView,
    UpdateView,
)

from ventas.models import Venta

from .forms import MovimientoInventarioForm, ProductoForm
from .models import MovimientoInventario, Producto


class DashboardView(LoginRequiredMixin, TemplateView):
    template_name = 'inventario/dashboard.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['total_productos'] = Producto.objects.count()
        context['stock_total'] = (
            Producto.objects.aggregate(total=Sum('stock'))['total'] or 0
        )
        context['total_ventas'] = Venta.objects.count()
        context['total_movimientos'] = MovimientoInventario.objects.count()
        return context


class ProductoListView(LoginRequiredMixin, ListView):
    model = Producto
    template_name = 'inventario/producto_list.html'
    context_object_name = 'productos'
    paginate_by = 10

    def get_queryset(self):
        queryset = super().get_queryset()
        busqueda = self.request.GET.get('q', '').strip()
        if busqueda:
            queryset = queryset.filter(
                Q(nombre__icontains=busqueda)
                | Q(descripcion__icontains=busqueda)
            )
        return queryset

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['busqueda'] = self.request.GET.get('q', '')
        return context


class ProductoCreateView(LoginRequiredMixin, CreateView):
    model = Producto
    form_class = ProductoForm
    template_name = 'inventario/producto_form.html'
    success_url = reverse_lazy('producto_list')

    def form_valid(self, form):
        messages.success(self.request, 'Producto creado correctamente.')
        return super().form_valid(form)


class ProductoUpdateView(LoginRequiredMixin, UpdateView):
    model = Producto
    form_class = ProductoForm
    template_name = 'inventario/producto_form.html'
    success_url = reverse_lazy('producto_list')

    def form_valid(self, form):
        messages.success(self.request, 'Producto actualizado correctamente.')
        return super().form_valid(form)


class ProductoDeleteView(LoginRequiredMixin, DeleteView):
    model = Producto
    template_name = 'inventario/producto_confirm_delete.html'
    success_url = reverse_lazy('producto_list')

    def form_valid(self, form):
        try:
            messages.success(self.request, 'Producto eliminado correctamente.')
            return super().form_valid(form)
        except ProtectedError:
            messages.error(
                self.request,
                'No se puede eliminar el producto porque tiene movimientos o ventas asociadas.',
            )
            return redirect('producto_list')


class MovimientoListView(LoginRequiredMixin, ListView):
    model = MovimientoInventario
    template_name = 'inventario/movimiento_list.html'
    context_object_name = 'movimientos'
    paginate_by = 10


class MovimientoCreateView(LoginRequiredMixin, CreateView):
    model = MovimientoInventario
    form_class = MovimientoInventarioForm
    template_name = 'inventario/movimiento_form.html'
    success_url = reverse_lazy('movimiento_list')

    def form_valid(self, form):
        try:
            with transaction.atomic():
                self.object = form.save()
            messages.success(self.request, 'Movimiento registrado correctamente.')
            return redirect(self.get_success_url())
        except ValidationError as e:
            for msg in e.messages:
                form.add_error(None, msg)
            return self.form_invalid(form)
