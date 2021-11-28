from django.contrib import admin
from .models import Appointment, Chamber, Doctor, SundayChamber, MondayChamber, TuesdayChamber, WednesdayChamber, ThursdayChamber, FridayChamber, SaturdayChamber, User

# Register your models here.
admin.site.register(Chamber)
admin.site.register(Doctor)
admin.site.register(User)
admin.site.register(SundayChamber)
admin.site.register(MondayChamber)
admin.site.register(TuesdayChamber)
admin.site.register(WednesdayChamber)
admin.site.register(ThursdayChamber)
admin.site.register(FridayChamber)
admin.site.register(SaturdayChamber)
admin.site.register(Appointment)
