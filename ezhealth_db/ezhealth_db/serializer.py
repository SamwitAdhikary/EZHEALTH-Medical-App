from rest_framework import serializers
from .models import Appointment, Chamber, SaturdayChamber, SundayChamber, MondayChamber, ThursdayChamber, TuesdayChamber, WednesdayChamber, FridayChamber, Doctor, User

class ChamberSerializer(serializers.ModelSerializer):
    class Meta:
        model = Chamber
        fields = '__all__'

class DoctorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Doctor
        fields = '__all__'

class ChamberDoctorSerializer(serializers.ModelSerializer):
    chamber = serializers.SerializerMethodField('getChamber')

    def getChamber(self, doctor_name):
        qs = Chamber.objects.filter(name=doctor_name)
        serializer = ChamberSerializer(instance=qs, many=True)
        return serializer.data

    class Meta:
        model = Doctor
        fields = '__all__'

class SundaySerializer(serializers.ModelSerializer):
    class Meta:
        model = SundayChamber
        fields = '__all__'

class SundayDoctorSerializer(serializers.ModelSerializer):
    sunday = serializers.SerializerMethodField('getSunday')

    def getSunday(self, doctor_name):
        qs = SundayChamber.objects.filter(sunday_name=doctor_name)
        serializer = SundaySerializer(instance=qs, many=True)
        return serializer.data

    class Meta:
        model = Doctor
        fields = '__all__'

class MondaySerializer(serializers.ModelSerializer):
    class Meta:
        model = MondayChamber
        fields = '__all__'

class MondayDoctorSerializer(serializers.ModelSerializer):
    monday = serializers.SerializerMethodField('getMonday')

    def getMonday(self, doctor_name):
        qs = MondayChamber.objects.filter(monday_name=doctor_name)
        serializer = MondaySerializer(instance=qs, many=True)
        return serializer.data

    class Meta:
        model = Doctor
        fields = '__all__'

class TuesdaySerializer(serializers.ModelSerializer):
    class Meta:
        model = TuesdayChamber
        fields = '__all__'

class TuesdayDoctorSerializer(serializers.ModelSerializer):
    monday = serializers.SerializerMethodField('getTuesday')

    def getTuesday(self, doctor_name):
        qs = TuesdayChamber.objects.filter(tuesday_name=doctor_name)
        serializer = TuesdaySerializer(instance=qs, many=True)
        return serializer.data

    class Meta:
        model = Doctor
        fields = '__all__'

class WednesdaySerializer(serializers.ModelSerializer):
    class Meta:
        model = WednesdayChamber
        fields = '__all__'

class WednesdayDoctorSerializer(serializers.ModelSerializer):
    wednesday = serializers.SerializerMethodField('getWednesday')

    def getWednesday(self, doctor_name):
        qs = WednesdayChamber.objects.filter(wednesday_name=doctor_name)
        serializer = WednesdaySerializer(instance=qs, many=True)
        return serializer.data

    class Meta:
        model = Doctor
        fields = '__all__'

class ThursdaySerializer(serializers.ModelSerializer):
    class Meta:
        model = ThursdayChamber
        fields = '__all__'

class ThursdayDoctorSerializer(serializers.ModelSerializer):
    thursday = serializers.SerializerMethodField('getThursday')

    def getThursday(self, doctor_name):
        qs = ThursdayChamber.objects.filter(thursday_name=doctor_name)
        serializer = ThursdaySerializer(instance=qs, many=True)
        return serializer.data

    class Meta:
        model = Doctor
        fields = '__all__'

class FridaySerializer(serializers.ModelSerializer):
    class Meta:
        model = FridayChamber
        fields = '__all__'

class FridayDoctorSerializer(serializers.ModelSerializer):
    friday = serializers.SerializerMethodField('getFriday')

    def getFriday(self, doctor_name):
        qs = FridayChamber.objects.filter(friday_name=doctor_name)
        serializer = FridaySerializer(instance=qs, many=True)
        return serializer.data

    class Meta:
        model = Doctor
        fields = '__all__'

class SaturdaySerializer(serializers.ModelSerializer):
    class Meta:
        model = SaturdayChamber
        fields = '__all__'

class SaturdayDoctorSerializer(serializers.ModelSerializer):
    saturday = serializers.SerializerMethodField('getSaturday')

    def getSaturday(self, doctor_name):
        qs = SaturdayChamber.objects.filter(saturday_name=doctor_name)
        serializer = SaturdaySerializer(instance=qs, many=True)
        return serializer.data

    class Meta:
        model = Doctor
        fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class AppointmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Appointment
        fields = '__all__'
        

class AppointmentDoctorSerializer(serializers.ModelSerializer):
    appointment_doctor = serializers.SerializerMethodField('getDoctorAppointment')

    def getDoctorAppointment(self, doctor_name):
        qs = Appointment.objects.filter(doctor=doctor_name)
        serializer = AppointmentSerializer(instance=qs, many=True)
        return serializer.data

    class Meta:
        model = Doctor
        fields = '__all__'

class AppointmentUserSerializer(serializers.ModelSerializer):
    appointment_user = serializers.SerializerMethodField('getUserAppointment')

    def getUserAppointment(self, user_name):
        qs = Appointment.objects.filter(user=user_name)
        serializer = AppointmentSerializer(instance=qs, many=True)
        return serializer.data

    class Meta:
        model = User
        fields = '__all__'