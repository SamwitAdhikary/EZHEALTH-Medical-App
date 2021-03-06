# Generated by Django 3.1.7 on 2021-10-25 17:54

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('ezhealth_db', '0007_auto_20211025_2254'),
    ]

    operations = [
        migrations.AlterField(
            model_name='chamber',
            name='chamber_id',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, related_name='id', serialize=False, to='ezhealth_db.doctor'),
        ),
        migrations.AlterField(
            model_name='chamber',
            name='name',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='name', to='ezhealth_db.doctor'),
        ),
    ]
