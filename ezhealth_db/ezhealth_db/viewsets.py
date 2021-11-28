from rest_framework import viewsets
from . import serializer

class DoctorViewSet(viewsets.ModelViewSet):
    queryset = serializer.Doctor.objects.all()
    serializer_class = serializer.DoctorSerializer

class UserViewSet(viewsets.ModelViewSet):
    queryset = serializer.User.objects.all()
    serializer_class = serializer.UserSerializer

class ChamberViewSet(viewsets.ModelViewSet):
    queryset = serializer.Chamber.objects.all()
    serializer_class = serializer.ChamberSerializer

class ChamberDoctorViewSet(viewsets.ModelViewSet):
    queryset = serializer.Doctor.objects.all()
    serializer_class = serializer.ChamberDoctorSerializer

class SundayViewSet(viewsets.ModelViewSet):
    queryset = serializer.SundayChamber.objects.all()
    serializer_class = serializer.SundaySerializer

class SundayDoctorViewSet(viewsets.ModelViewSet):
    queryset = serializer.Doctor.objects.all()
    serializer_class = serializer.SundayDoctorSerializer

class MondayViewSet(viewsets.ModelViewSet):
    queryset = serializer.MondayChamber.objects.all()
    serializer_class = serializer.MondaySerializer

class MondayDoctorViewSet(viewsets.ModelViewSet):
    queryset = serializer.Doctor.objects.all()
    serializer_class = serializer.MondayDoctorSerializer

class TuesdayViewSet(viewsets.ModelViewSet):
    queryset = serializer.TuesdayChamber.objects.all()
    serializer_class = serializer.TuesdaySerializer

class TuesdayDoctorViewSet(viewsets.ModelViewSet):
    queryset = serializer.Doctor.objects.all()
    serializer_class = serializer.TuesdayDoctorSerializer

class WednesdayViewSet(viewsets.ModelViewSet):
    queryset = serializer.WednesdayChamber.objects.all()
    serializer_class = serializer.WednesdaySerializer

class WednesdayDoctorViewSet(viewsets.ModelViewSet):
    queryset = serializer.Doctor.objects.all()
    serializer_class = serializer.WednesdayDoctorSerializer

class ThursdayViewSet(viewsets.ModelViewSet):
    queryset = serializer.ThursdayChamber.objects.all()
    serializer_class = serializer.ThursdaySerializer

class ThursdayDoctorViewSet(viewsets.ModelViewSet):
    queryset = serializer.Doctor.objects.all()
    serializer_class = serializer.ThursdayDoctorSerializer

class FridayViewSet(viewsets.ModelViewSet):
    queryset = serializer.FridayChamber.objects.all()
    serializer_class = serializer.FridaySerializer

class FridayDoctorViewSet(viewsets.ModelViewSet):
    queryset = serializer.Doctor.objects.all()
    serializer_class = serializer.FridayDoctorSerializer

class SaturdayViewSet(viewsets.ModelViewSet):
    queryset = serializer.SaturdayChamber.objects.all()
    serializer_class = serializer.SaturdaySerializer

class SaturdayDoctorViewSet(viewsets.ModelViewSet):
    queryset = serializer.Doctor.objects.all()
    serializer_class = serializer.SaturdayDoctorSerializer

class AppointmentViewSet(viewsets.ModelViewSet):
    queryset = serializer.Appointment.objects.all()
    serializer_class = serializer.AppointmentSerializer

class AppointmentDoctorViewSet(viewsets.ModelViewSet):
    queryset = serializer.Doctor.objects.all()
    serializer_class = serializer.AppointmentDoctorSerializer

class AppointmentUserViewSet(viewsets.ModelViewSet):
    queryset = serializer.User.objects.all()
    serializer_class = serializer.AppointmentUserSerializer