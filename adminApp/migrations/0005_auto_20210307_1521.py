# Generated by Django 3.1.7 on 2021-03-07 15:21

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('adminApp', '0004_auto_20210307_1214'),
    ]

    operations = [
        migrations.AlterField(
            model_name='instructor',
            name='instructor',
            field=models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='instructor', to=settings.AUTH_USER_MODEL),
        ),
    ]