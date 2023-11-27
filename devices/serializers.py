from devices.models import Device, DeviceLog
from rest_framework import serializers

class DeviceSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Device
        fields = ['name']

class DeviceLogSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = DeviceLog
        fields = ['voltage', 'current', 'power', 'time']