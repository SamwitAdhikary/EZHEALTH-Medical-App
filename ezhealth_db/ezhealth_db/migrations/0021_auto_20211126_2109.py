# Generated by Django 3.1.7 on 2021-11-26 15:39

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ezhealth_db', '0020_auto_20211120_2316'),
    ]

    operations = [
        migrations.RenameField(
            model_name='appointment',
            old_name='date',
            new_name='day',
        ),
    ]
