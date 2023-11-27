from django.shortcuts import get_object_or_404
from django.http import HttpResponse

from rest_framework import viewsets, permissions
from rest_framework.response import Response
from devices.models import (
    Device,
    DeviceLog
)
from devices.serializers import DeviceSerializer, DeviceLogSerializer

# Create your views here.
def index(request):
    return HttpResponse("Hello, world.")

class DeviceViewSet(viewsets.ModelViewSet):
    queryset = Device.objects.all()
    serializer_class = DeviceSerializer

    # def retrieve(self, request, pk):
    #     device = get_object_or_404(Device, pk=pk)
    #     serializer = self.get_serializer(device)

    #     return Response(serializer.data)

class DeviceLogViewSet(viewsets.ModelViewSet):
    queryset = DeviceLog.objects.all()
    serializer_class = DeviceLogSerializer