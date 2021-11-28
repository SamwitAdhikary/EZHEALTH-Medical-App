from django.db import models

# Create your models here.
class Doctor(models.Model):
    registration_id = models.CharField(max_length=30, primary_key=True, default='')
    doctor_registration_number = models.CharField(max_length=30, default='')
    doctor_name = models.CharField(max_length=50, default='')
    doctor_description = models.TextField(default='')
    degree = models.CharField(max_length=30, default='')
    designation = models.CharField(max_length=30, default='')
    mail_id = models.EmailField(default='')
    phone_no = models.BigIntegerField(default=0)

    def __str__(self):
        return self.doctor_name

class SundayChamber(models.Model):
    sunday_id = models.OneToOneField(Doctor, on_delete=models.CASCADE, primary_key=True, default='', related_name='sunday_id')
    sunday = models.CharField(max_length=10, default='sunday')
    sunday_name = models.ForeignKey(Doctor, on_delete=models.CASCADE, default='', related_name='sunday_name')
    chamber_location = models.CharField(default='', max_length=30)
    available_time = models.CharField(max_length=10, default='')
    slots_available = models.IntegerField(default=0)

    def __str__(self):
        return self.chamber_location

class MondayChamber(models.Model):
    monday_id = models.OneToOneField(Doctor, on_delete=models.CASCADE, primary_key=True, default='', related_name='monday_id')
    monday = models.CharField(max_length=10, default='monday')
    monday_name = models.ForeignKey(Doctor, on_delete=models.CASCADE, default='', related_name='monday_name')
    chamber_location = models.CharField(default='', max_length=30)
    available_time = models.CharField(max_length=10, default='')
    slots_available = models.IntegerField(default=0)

    def __str__(self):
        return self.chamber_location

class TuesdayChamber(models.Model):
    tuesday_id = models.OneToOneField(Doctor, on_delete=models.CASCADE, primary_key=True, default='', related_name='tuesday_id')
    tuesday = models.CharField(max_length=10, default='tuesday')
    tuesday_name = models.ForeignKey(Doctor, on_delete=models.CASCADE, default='', related_name='tuesday_name')
    chamber_location = models.CharField(default='', max_length=30)
    available_time = models.CharField(max_length=10, default='')
    slots_available = models.IntegerField(default=0)

    def __str__(self):
        return self.chamber_location

class WednesdayChamber(models.Model):
    wednesday_id = models.OneToOneField(Doctor, on_delete=models.CASCADE, primary_key=True, default='', related_name='wednesday_id')
    wednesday = models.CharField(max_length=10, default='wednesday')
    wednesday_name = models.ForeignKey(Doctor, on_delete=models.CASCADE, default='', related_name='wednesday_name')
    chamber_location = models.CharField(default='', max_length=30)
    available_time = models.CharField(max_length=10, default='')
    slots_available = models.IntegerField(default=0)

    def __str__(self):
        return self.chamber_location

class ThursdayChamber(models.Model):
    thursday_id = models.OneToOneField(Doctor, on_delete=models.CASCADE, primary_key=True, default='', related_name='thursday_id')
    thursday = models.CharField(max_length=10, default='thursday')
    thursday_name = models.ForeignKey(Doctor, on_delete=models.CASCADE, default='', related_name='thursday_name')
    chamber_location = models.CharField(default='', max_length=30)
    available_time = models.CharField(max_length=10, default='')
    slots_available = models.IntegerField(default=0)

    def __str__(self):
        return self.chamber_location

class FridayChamber(models.Model):
    friday_id = models.OneToOneField(Doctor, on_delete=models.CASCADE, primary_key=True, default='', related_name='friday_id')
    friday = models.CharField(max_length=10, default='friday')
    friday_name = models.ForeignKey(Doctor, on_delete=models.CASCADE, default='', related_name='friday_name')
    chamber_location = models.CharField(default='', max_length=30)
    available_time = models.CharField(max_length=10, default='')
    slots_available = models.IntegerField(default=0)

    def __str__(self):
        return self.chamber_location

class SaturdayChamber(models.Model):
    saturday_id = models.OneToOneField(Doctor, on_delete=models.CASCADE, primary_key=True, default='', related_name='saturday_id')
    saturday = models.CharField(max_length=10, default='saturday')
    saturday_name = models.ForeignKey(Doctor, on_delete=models.CASCADE, default='', related_name='saturday_name')
    chamber_location = models.CharField(default='', max_length=30)
    available_time = models.CharField(max_length=10, default='')
    slots_available = models.IntegerField(default=0)

    def __str__(self):
        return self.chamber_location

class Chamber(models.Model):
    chamber_id = models.OneToOneField(Doctor, on_delete=models.CASCADE, primary_key=True, related_name='id')
    name = models.ForeignKey(Doctor, on_delete=models.CASCADE, related_name='name')
    sunday_chamber = models.ForeignKey(SundayChamber, on_delete=models.CASCADE, default='')
    monday_chamber = models.ForeignKey(MondayChamber, on_delete=models.CASCADE, default='')
    tuesday_chamber = models.ForeignKey(TuesdayChamber, on_delete=models.CASCADE, default='')
    wednesday_chamber = models.ForeignKey(WednesdayChamber, on_delete=models.CASCADE, default='')
    thursday_chamber = models.ForeignKey(ThursdayChamber, on_delete=models.CASCADE, default='')
    friday_chamber = models.ForeignKey(FridayChamber, on_delete=models.CASCADE, default='')
    saturday_chamber = models.ForeignKey(SaturdayChamber, on_delete=models.CASCADE, default='')

    def __str__(self):
        return self.name
    
class User(models.Model):
    registration_id = models.CharField(primary_key=True, max_length=30, default='')
    user_name = models.CharField(max_length=30, default='')
    mail_id = models.EmailField(default='')
    phone_no = models.BigIntegerField(default=0)

    def __str__(self):
        return self.user_name

class Appointment(models.Model):
    appointment_id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, default='')
    username = models.CharField(max_length=30, default='')
    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE, default='')
    doctorname = models.CharField(max_length=30, default='')
    place = models.CharField(max_length=20, default='')
    day = models.CharField(max_length=10, default='')
    time = models.CharField(max_length=10, default='')

    def __str__(self):
        return self.doctor + self.user
    
