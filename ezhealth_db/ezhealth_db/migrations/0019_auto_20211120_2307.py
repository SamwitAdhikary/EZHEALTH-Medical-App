# Generated by Django 3.1.7 on 2021-11-20 17:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ezhealth_db', '0018_auto_20211120_2306'),
    ]

    operations = [
        migrations.AlterField(
            model_name='fridaychamber',
            name='slots_available',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='mondaychamber',
            name='slots_available',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='saturdaychamber',
            name='slots_available',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='sundaychamber',
            name='slots_available',
            field=models.IntegerField(default=''),
        ),
        migrations.AlterField(
            model_name='thursdaychamber',
            name='slots_available',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='tuesdaychamber',
            name='slots_available',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='wednesdaychamber',
            name='slots_available',
            field=models.IntegerField(default=0),
        ),
    ]
