from django.urls import path

from . import views

urlpatterns = [
    path('', views.DashboardView.as_view(), name='dashboard'),
    path('productos/', views.ProductoListView.as_view(), name='producto_list'),
    path('productos/nuevo/', views.ProductoCreateView.as_view(), name='producto_create'),
    path('productos/<int:pk>/editar/', views.ProductoUpdateView.as_view(), name='producto_update'),
    path('productos/<int:pk>/eliminar/', views.ProductoDeleteView.as_view(), name='producto_delete'),
    path('movimientos/', views.MovimientoListView.as_view(), name='movimiento_list'),
    path('movimientos/nuevo/', views.MovimientoCreateView.as_view(), name='movimiento_create'),
]
