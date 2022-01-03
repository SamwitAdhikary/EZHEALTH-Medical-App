from ezhealth_db.viewsets import AppointmentDoctorViewSet, AppointmentUserViewSet, AppointmentViewSet, ChamberDoctorViewSet, ChamberViewSet, DoctorViewSet, FridayDoctorViewSet, FridayViewSet, MondayDoctorViewSet, MondayViewSet, SaturdayDoctorViewSet, SaturdayViewSet, ThursdayDoctorViewSet, ThursdayViewSet, TuesdayDoctorViewSet, TuesdayViewSet, UserViewSet, SundayViewSet, SundayDoctorViewSet, WednesdayDoctorViewSet, WednesdayViewSet
from rest_framework import routers
from django.urls import path, include

router = routers.DefaultRouter()
router.register('doctor', DoctorViewSet)
router.register('user', UserViewSet)

router.register('chamber', ChamberViewSet)
router.register('chamberdoctor', ChamberDoctorViewSet)

router.register('sunday', SundayViewSet)
router.register('sundaydoctor', SundayDoctorViewSet)

router.register('monday', MondayViewSet)
router.register('mondaydoctor', MondayDoctorViewSet)

router.register('tuesday', TuesdayViewSet)
router.register('tuesdaydoctor', TuesdayDoctorViewSet)

router.register('wednesday', WednesdayViewSet)
router.register('wednesdaydoctor', WednesdayDoctorViewSet)

router.register('thursday', ThursdayViewSet)
router.register('thursdaydoctor', ThursdayDoctorViewSet)

router.register('friday', FridayViewSet)
router.register('fridaydoctor', FridayDoctorViewSet)

router.register('saturday', SaturdayViewSet)
router.register('saturdaydoctor', SaturdayDoctorViewSet)

router.register('appointment', AppointmentViewSet)
router.register('appointmentdoctor', AppointmentDoctorViewSet)
router.register('appointmentuser', AppointmentUserViewSet)

urlpatterns = [
    path('', include(router.urls))
]