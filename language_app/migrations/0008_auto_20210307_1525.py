# Generated by Django 3.1.7 on 2021-03-07 15:25

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('adminApp', '0006_auto_20210307_1525'),
        ('language_app', '0007_auto_20210307_1522'),
    ]

    operations = [
        migrations.AlterField(
            model_name='course',
            name='instructor',
            field=models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='course', to='adminApp.instructor'),
        ),
    ]
