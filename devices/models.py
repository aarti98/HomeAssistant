from django.db import models

class Device(models.Model):
    name = models.CharField(max_length=200)

    def __str__(self):
        return self.name

class DeviceLog(models.Model):
    device = models.ForeignKey(
        "Device",
        on_delete=models.CASCADE,
    )
    voltage = models.FloatField()
    current = models.FloatField()
    power = models.FloatField()
    time = models.DateTimeField()

    def __str__(self):
        return self.device.name + ' '  + str(self.time)